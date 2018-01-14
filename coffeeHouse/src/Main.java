
import javax.swing.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import java.sql.*;


public class Main {

    private static JFrame mainFrame;

    // type of windows ( I think this is all we need)
    private static Window homeWindow;
    private static EnrollMember newClubMemberWindow;
    private static Window logInWindow;
    private static checkMember lookUpClubmemberWindow;
    private static Window makePurchaseWindow;
    private static Window orderSuppliesWindow;
    private static Window salesReportWindow;
    private static CheckInventory checkInventoryWindow;
    private static UpdatePassword updatePasswordWindow;
    private static deleteOrderSupplies deleteOrderSuppliesWindow;

    private JLabel title = new JLabel("Name");


    public static enum User {
        MANAGER, CLERK
    }

    private static User user;


    public static void main(String[] args) {

        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {

        }

        mainFrame = new JFrame("Coffee House");

        initializeFrames();
        initializeWindows(); // What are these...

        // LogInFrame mf = new LogInFrame();
    }


    private static void initializeFrames() {

        logInWindow = new LogInWindow();
        homeWindow = new Home();

        makePurchaseWindow = new makePurchase();
        orderSuppliesWindow = new orderSupplies();
        newClubMemberWindow = new EnrollMember();
        lookUpClubmemberWindow = new checkMember();
        salesReportWindow = new salesReport();
        checkInventoryWindow = new CheckInventory();
        updatePasswordWindow = new UpdatePassword();
        deleteOrderSuppliesWindow = new deleteOrderSupplies();
    }

    private static void initializeWindows() {
        mainFrame.setSize(1024, 768);
        mainFrame.setLocationRelativeTo(null);
        mainFrame.setContentPane(logInWindow);

        mainFrame.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                mainFrame.setVisible(true);
            }
        });

    }

    public static void switchWindow(JPanel panel){
        mainFrame.setContentPane(panel);
        mainFrame.revalidate();
        mainFrame.repaint();
    }

    // Find the type of user.
    // setting the user based on manager or clerk.
    public static void setUser(User u){
        if (u.equals(User.MANAGER)){
            user = User.MANAGER;

        } else {
            user = User.CLERK;
        }
    }

    public static User getUser() {return user;}


    // get different windows
    public static Window getHomeWindow() {return  homeWindow;}

    public static Window getNewClubMemberWindow() {
        //mainFrame.add(new EnrollMember().panel1);
        mainFrame.add(newClubMemberWindow.getPanel1());
        return newClubMemberWindow;}
    public static void removeEnollMember(){
        mainFrame.remove(newClubMemberWindow.getPanel1());
    }

    public static Window getLogInWindow() { return logInWindow;}

    public static Window getMakePurchaseWindow() {return makePurchaseWindow;}

    public static Window getCheckInventoryWindow() {
        //mainFrame.add(new EnrollMember().panel1);
        mainFrame.add(checkInventoryWindow.getPane1());
        return newClubMemberWindow;
    }
    public static void removeCheckInventoryWindow(){
        mainFrame.remove(checkInventoryWindow.getPane1());
    }

    public static Window getLookUpClubmemberWindow() {

        mainFrame.add(lookUpClubmemberWindow.getPanel1());
        return lookUpClubmemberWindow;}

    public static Window removeLookUpClubmemberWindow() {

        mainFrame.remove(lookUpClubmemberWindow.getPanel1());
        return lookUpClubmemberWindow;
    }

    public static Window orderSuppliesWindow() {return orderSuppliesWindow;}
    public static Window getSalesReportWindow() {return salesReportWindow;}

    public static Window getOrderSuppliesWindoworderSuppliesWindow() {
        return orderSuppliesWindow;}

    public static Window updatePasswordWindow() {
        return updatePasswordWindow;
    }

    public static Window getDeleteSuppliesWindow() {
        //mainFrame.add(new EnrollMember().panel1);
        mainFrame.add(deleteOrderSuppliesWindow.getPanel1());
        return deleteOrderSuppliesWindow;
    }
    public static void removeDeleteOrderSuppliesWindow(){
        mainFrame.remove(deleteOrderSuppliesWindow.getPanel1());
    }

}
