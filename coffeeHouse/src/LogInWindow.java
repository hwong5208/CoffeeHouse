import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class LogInWindow extends Window {

    private JLabel title = new JLabel("Employee Login");
    private JLabel IdLabel = new JLabel("Employee ID: ");
    private JLabel passwordLabel = new JLabel("Password: ");
    private JTextField userField = new JTextField(10);
    private JPasswordField passwordField = new JPasswordField(10);
    private JButton loginbutton = new JButton("Login");


    //added for EnrollMember Eid;
    public static String userID ;
    private static boolean isManager;

    // get our mysql database connection
    Connection conn = ConnectDB.getConnection();

    // returns the user id to determine wether you are manage ror not
    private static String fetchUserEID(String uid){
        // TODO: technically this should be used in the function below to know which type of user we are dealing with
        return null;
    }

    public LogInWindow() {
        super(new GridBagLayout());
        GridBagConstraints constraints = new GridBagConstraints();
        // this specifies the padding of top, left, and bottom
        constraints.insets = new Insets(10,10,10,10);


        // setting up the UI for login

        JPanel middle = new JPanel(new GridBagLayout());
        add(middle);

        // The title
        constraints.gridx = 0;
        constraints.gridy = 0;
        constraints.gridwidth = 2;
        constraints.anchor = GridBagConstraints.CENTER;
        middle.add(title, constraints);

        // label for insert employee id

        constraints.gridwidth = 1;
        constraints.anchor = GridBagConstraints.WEST;

        constraints.gridx = 0;
        constraints.gridy = 1;
        middle.add(IdLabel, constraints);
        constraints.gridy = 2;
        middle.add(passwordLabel, constraints);

        // password
        constraints.gridx = 1;
        constraints.gridy = 1;
        middle.add(userField, constraints);
        constraints.gridy = 2;
        middle.add(passwordField, constraints);

        // log in button
        constraints.gridx = 1;
        constraints.gridy = 3;
        middle.add(loginbutton, constraints);

        loginbutton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                userID = new String(userField.getText());
                isManager = false;

                String ePass = new String(passwordField.getPassword());
                boolean isClerk = false;

                try
                {
                    // SQL SELECT query.
                    String query = "SELECT m.eid AS m_eid," +
                            "e.eid AS eid\n" +
                            "FROM employee e\n" +
                            "LEFT JOIN manager m\n" +
                            "  ON m.eid = e.eid\n" +
                            "WHERE e.eid = " + userID + "\n" +
                            "AND e.epass = SHA1('" + ePass + "')";

                    System.out.println(query );

                    // create the java statement
                    Statement st = conn.createStatement();

                    // execute the query, and get a java resultset
                    ResultSet rs = st.executeQuery(query);

                    // iterate through the java resultset
                    while (rs.next())
                    {
                        int m_eid = rs.getInt("m_eid");
                        int eid = rs.getInt("eid");

                        if (m_eid == eid) {
                            isManager = true;
                        } else if (eid == Integer.parseInt(userID)) {
                            isClerk = true;
                        }
                    }
                    st.close();
                }
                catch (Exception s)
                {
                    System.err.println("Got an exception! ");
                    System.err.println(s.getMessage());
                }

                if (isManager){
                    Main.setUser(Main.User.MANAGER); // manager
                    Main.getHomeWindow().refresh();
                    Main.switchWindow(Main.getHomeWindow());
                    passwordField.setText("");
                } else if (isClerk){
                    Main.setUser(Main.User.CLERK); // clerk
                    Main.getHomeWindow().refresh();
                    Main.switchWindow(Main.getHomeWindow());
                    passwordField.setText("");
                } else { // Case where the user id does not exist.
                    Object[] o = {"Ok"};
                    Object o1 = "Employee ID or Password Invalid. Please try again!";
                    JOptionPane.showOptionDialog(null,o1, "Employee ID or Password Incorrect",
                            JOptionPane.ERROR_MESSAGE, JOptionPane.OK_OPTION, null, o, o[0]);
                    passwordField.setText("");
                }
            }
        });
    }

    public static String getUserID(){

        return userID;
    }

    public static boolean  getIsManager(){
        return isManager;
    }
    public void refresh(){
    }
}
