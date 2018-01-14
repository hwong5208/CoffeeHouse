import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by hwong on 3/31/2017.
 */
public class deleteOrderSupplies extends Window {
    private JButton checkAll;
    private JFormattedTextField orderIDTextField;
    private JButton submitButton1;
    private JPanel jpanel;
    private JTable table1;
    private JButton backToHomePageButton;

    public deleteOrderSupplies(){
        super(new GridBagLayout());
        checkAll.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                checkOrders();
            }
        });
        submitButton1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                deleteOrders();
            }
        });
        backToHomePageButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.removeDeleteOrderSuppliesWindow();
                if(LogInWindow.getIsManager()) {
                    Main.setUser(Main.User.MANAGER);
                    Main.getHomeWindow().refresh();
                    Main.switchWindow(Main.getHomeWindow());
                }else{
                    Main.setUser(Main.User.CLERK);
                    Main.getHomeWindow().refresh();
                    Main.switchWindow(Main.getHomeWindow());
                }
            }
        });
    }


    JPanel getPanel1(){
        return jpanel;
    }


    Boolean checkOrders(){
        try {
            Statement stmt = ConnectDB.conn.createStatement();
//            ResultSet rs = stmt.executeQuery("SELECT * FROM orders");

            ResultSet rs = stmt.executeQuery("Select o.oid, s.sname, o.total_price, o.day, o.qty\n" +
                    "From orders o, supplies s\n" +
                    "Where o.supplies_id = s.supplies_id \n" +
                    "Order by o.oid; "  );


            table1 = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table1), "Check Supplies", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));

            //    JOptionPane.showMessageDialog(null,new JScrollPane(table1));

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }

     return false;
    }

    Boolean deleteOrders(){
        try {
            String orderID = orderIDTextField.getText();

            try{
                Integer.parseInt(orderID);
            }catch (Exception e){
                JOptionPane.showMessageDialog(null, "It must be an integer");
            }

            Statement statement = ConnectDB.conn.createStatement();

            String queryClubMember = "SELECT * FROM orders WHERE oid = "+ orderID+";";

            ResultSet rs = statement.executeQuery(queryClubMember );

            //check the oid exist or not
            if(rs.isBeforeFirst()){

                String query = "SELECT * FROM orders WHERE oid = "+ orderID+";";
                ResultSet rs1  =   statement.executeQuery(query);



                    query = "DELETE FROM orders WHERE oid = "+ orderID+" ;";
                    statement.executeUpdate(query);
                    JOptionPane.showMessageDialog(null, "Order Deleted");
                    return false;



            }else{
                JOptionPane.showMessageDialog(null, "Orders does not exist");
            }


        }catch(Exception e){
            JOptionPane.showMessageDialog(null, e);
        }
        return false;
    }


}



