import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;

/**
 * Created by hwong on 3/28/2017.
 */
public class CheckInventory extends Window {

    private JButton returnToHomePageButton;
    private JTable table1;
    private JButton checkButton;
    private javax.swing.JPanel panel1;
    private JFormattedTextField exdateTextField;
    private JButton submitButton;

    public CheckInventory() {
        super(new GridBagLayout());
        checkButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printCheckInventoryList();
            }
        });
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
             checkExdate();
            }
        });
        returnToHomePageButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.removeCheckInventoryWindow();
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

  //select * from food_ingredients where exdate between '2017-04-05' and '2017-04-22';


    private void checkExdate(){
        String exDate = exdateTextField.getText();
        java.sql.Date sqlStartDate;

        String startDate=exdateTextField.getText();;
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");



        try {
            java.util.Date date = sdf1.parse(startDate);

            sqlStartDate = new Date(date.getTime());

            Calendar cal = Calendar.getInstance();
            cal.setTime(sqlStartDate);
            cal.add(Calendar.DATE, 3);
           // java.util.Date sqlEndDate = cal.getTime();
            String sqlEndDate = sdf1.format(cal.getTime());
            System.out.println(sqlStartDate );
            System.out.println(sqlEndDate );

            Statement stmt = ConnectDB.conn.createStatement();
           // ResultSet rs = stmt.executeQuery("SELECT * FROM food_ingredients WHERE exdate BETWEEN '2017-04-05' and '2017-04-22'"  );
           // ResultSet rs = stmt.executeQuery("SELECT * FROM food_ingredients WHERE exdate BETWEEN '"+ sqlStartDate+"' and '"+sqlEndDate+"'"  );
    /*
            ResultSet rs = stmt.executeQuery("SELECT f.supplies_id, s.sname AS Name, o.qty AS Quantity\n" +
                    "FROM supplies s, orders o, food_ingredients f\n" +
                    "WHERE s.supplies_id = f.supplies_id and o.oid = f.oid and exdate BETWEEN '"+ sqlStartDate+"' and '"+sqlEndDate+"'"  );
*/
            ResultSet rs = stmt.executeQuery("SELECT f.supplies_id, s.sname AS Name,exdate, o.qty AS Quantity\n" +
                    "FROM supplies s, orders o, food_ingredients f\n" +
                    "WHERE s.supplies_id = f.supplies_id and o.oid = f.oid and exdate BETWEEN '"+ sqlStartDate+"' and '"+sqlEndDate+"'"  );


            table1 = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));


            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table1), "Check Inventory", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));

           // JOptionPane.showMessageDialog(null,new JScrollPane(table1));

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }

    }


    public void printCheckInventoryList() {
        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM supplies");

            table1 = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table1), "Check Inventory", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));

        //    JOptionPane.showMessageDialog(null,new JScrollPane(table1));

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

/*

    public static DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();

        // names of columns
        Vector<String> columnNames = new Vector<String>();
        int columnCount = metaData.getColumnCount();
        for (int column = 1; column <= columnCount; column++) {
            columnNames.add(metaData.getColumnName(column));
        }

        // data of the table
        Vector<Vector<Object>> data = new Vector<Vector<Object>>();
        while (rs.next()) {
            Vector<Object> vector = new Vector<Object>();
            for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
                vector.add(rs.getObject(columnIndex));
            }
            data.add(vector);
        }

        return new DefaultTableModel(data, columnNames);
    }
*/
    JPanel getPane1(){
        return panel1;
    }


}
