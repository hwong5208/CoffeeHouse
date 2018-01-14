import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hwong on 3/27/2017.
 */
public class EnrollMember extends Window {


    public JPanel panel1;
    private JFormattedTextField PhonenameTextField1;
    private JFormattedTextField CnameTextField;
    private JFormattedTextField PointformattedTextField;
    private JButton cancelButton;
    private JButton submitButton1;
    private JFormattedTextField EmailTextField;
    private JTextField oldPhoneNumber;
    private JTextField newPhoneNumber;
    private JButton updateButton;

    private int preCID;
    private Integer CID;

    public EnrollMember(){
        super(new GridBagLayout());

        panel1.setVisible(true);

        cancelButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                Main.removeEnollMember();
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
        submitButton1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
            print();
                getPreviousCid();

                if(addMember()){
                    JOptionPane.showMessageDialog(null, "Club member was added\n" + "Club member ID : " + CID);
                };

            }
        });


        updateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
              if(updatePhoneNumber()){
                  JOptionPane.showMessageDialog(null, "Update Successful");
              }else{
                  JOptionPane.showMessageDialog(null, "Update fail");
              }
            }
        });
    }


    Boolean updatePhoneNumber(){
        try {
            String oldPhone = oldPhoneNumber.getText();
            String newPhone = newPhoneNumber.getText();

            if(!validatePhoneNumber(oldPhone)){
                throw new Exception("Wrong phone type: old Phone");
            }

            if(!validatePhoneNumber(newPhone)){
                throw new Exception("Wrong phone type: old Phone");
            }

            Statement statement = ConnectDB.conn.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM club_members WHERE phone = '" + oldPhone+"'");

            if(!rs.isBeforeFirst()){
                JOptionPane.showMessageDialog(null, "Old not found!");
                return false;

            } else {

                String update = "UPDATE  club_members SET phone = '" + newPhone + "' where phone ='" + oldPhone + "';";
                statement.executeUpdate(update);

            }
            return true;
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, e);
        }
        return false;
    }

    void print(){
        System.out.println("Cname: "+CnameTextField.getText());
        System.out.println("Email: "+EmailTextField.getText());
        System.out.println("Eid:"+ LogInWindow.getUserID());
    }

    void getPreviousCid(){

        try {
             preCID = 0;
            Statement stmt3 = ConnectDB.conn.createStatement();
            ResultSet rs3 = stmt3.executeQuery("SELECT MAX(cid) FROM club_members;");
            while(rs3.next()){
                preCID = rs3.getInt(1);
            }
            System.out.println("CID :"+ preCID);
        }catch(SQLException e){
            System.out.println(e);
        }
    }


    Boolean addMember() {

        // create a Statement from the connection


        try {
            Statement statement = ConnectDB.conn.createStatement();

             CID = preCID+1;
            String Cname = CnameTextField.getText();
            String phone = PhonenameTextField1.getText();
            String email = EmailTextField.getText();
            Integer point;

           if( !validateLetters(Cname)){
               throw new Exception(" Wrong name type");
           };

           if(!validateEmail(email)){
               throw new Exception(" Wrong email type");
           }

           if(!validatePhoneNumber(phone)){
               throw new Exception("Wrong phone type");
           }

            if(Cname.equals("")|phone.equals("")|email.equals("") ){
                throw new Exception(" Name , Phone number , Email cannot be empty");
            }

            try {
                 point = Integer.parseInt(PointformattedTextField.getText());
            }catch(Exception e){
                throw new Exception(" Point must be an integer");
            }

            Integer Eid = Integer.parseInt(LogInWindow.getUserID());




        //    String insert = "INSERT INTO club_members "+ "VALUES (" +CID+","+Cname+","+phone+","+email+","+Eid+")";
// insert the data
          // String insert = "INSERT INTO club_members VALUES (" +CID+','+Cname+','+phone+','+"'"+email+"'"+','+point+','+Eid+")";
            statement.executeUpdate("INSERT INTO club_members VALUES (" +CID+",'"+Cname+"','"+phone+"','"+email+"',"+point+","+Eid+")");
            return true;
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, e);
        }
        return false;
    }

    JPanel getPanel1(){
        return panel1;
    }

    public static boolean validateLetters(String txt) {

        String regx ="^[A-Za-z\\s]+$";
        Pattern pattern = Pattern.compile(regx,Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(txt);
        return matcher.find();
    }


    public static boolean validateEmail(final String hex) {

        String EMAIL_PATTERN =
                "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                        + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        Matcher  matcher = Pattern.compile(EMAIL_PATTERN).matcher(hex);
        return matcher.matches();

    }

    public static boolean validatePhoneNumber(String txt) {

        String regx ="^^\\d{10}|^(\\(\\d{3}\\)\\s?)?\\d{3}-\\d{4}$|^\\d{3}([.-])\\d{3}\\2\\d{4}$";
        Pattern pattern = Pattern.compile(regx,Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(txt);
        return matcher.find();
    }




}
