import java.awt.event.ComponentAdapter;
import java.awt.image.BufferedImage;
import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;


/**
 * Created by Christine on 2017-03-27.
 */
public class checkMember extends Window{
    private JPanel panel2;
    private JTable memberTable;
    private JButton returnButton;
    private JButton loadButton;
    private JButton submitButton;
    private JFormattedTextField input;
    private JFormattedTextField memberIDTextField;
    private JButton deleteMemberButton;
    private final DefaultTableModel tableModel = new DefaultTableModel();


    public checkMember() {
        super(new GridBagLayout());

        loadButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printMemberList();
            }
        });
        input.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

            }
        });
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String userInput = input.getText();
                printIndividualMember(userInput);
                System.out.println(userInput);
            }
        });

        returnButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                Main.removeLookUpClubmemberWindow();
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
        returnButton.addComponentListener(new ComponentAdapter() {
        });
        deleteMemberButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                deleteMember();
            }
        });
    }

    public void printIndividualMember(String x) {
        try {
            Statement stmt = ConnectDB.conn.createStatement();


            if(!EnrollMember.validatePhoneNumber(x)){
                throw new Exception( "Invalid number");
            };

            ResultSet rs = stmt.executeQuery("SELECT cid, cname, phone, points FROM club_members WHERE phone='"+x+"'");

            if(!rs.isBeforeFirst()){
                JOptionPane.showMessageDialog(null, "Member not found!");

            } else {
                memberTable = new JTable(buildTableModel(rs));
                UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

                Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
                JPanel gui = new JPanel(new BorderLayout());

                JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                        BufferedImage.TYPE_INT_RGB)));
                gui.add(clouds);

                JOptionPane.showMessageDialog(null,new JScrollPane(memberTable), "Member Information", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
            }


        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }


    public void printMemberList() {
        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM club_members");

            memberTable = new JTable(buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(memberTable), "Member Information", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
            //JOptionPane.showMessageDialog(null,new JScrollPane(memberTable));

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public static DefaultTableModel buildTableModel(ResultSet rs) throws SQLException{
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
    JPanel getPanel1(){
        return panel2;
    }

    Boolean deleteMember(){
        try {
            String memberID = memberIDTextField.getText();

            try{
                Integer.parseInt(memberID);
            }catch (Exception e){
                JOptionPane.showMessageDialog(null, "It must be an integer");
            }

            Statement statement = ConnectDB.conn.createStatement();

            String queryClubMember = "SELECT * FROM club_members WHERE cid = "+ memberID+";";

            ResultSet rs = statement.executeQuery(queryClubMember );

            //check the member exist or not
            if(rs.isBeforeFirst()){

            String query = "SELECT * FROM sale_transaction WHERE cid = "+ memberID+";";
            ResultSet rs1  =   statement.executeQuery(query);

            // check the member have transaction or not
            if(!rs1.isBeforeFirst()){

                 query = "DELETE FROM club_members WHERE cid = "+ memberID+" ;";
               statement.executeUpdate(query);
                JOptionPane.showMessageDialog(null, "Member Deleted");
                return false;

            } else {
                JOptionPane.showMessageDialog(null, "Member could not be deleted");
            }

            }else{
                JOptionPane.showMessageDialog(null, "Member does not exist");
            }


            }catch(Exception e){
            JOptionPane.showMessageDialog(null, e);
        }
           return false;
    }




}
