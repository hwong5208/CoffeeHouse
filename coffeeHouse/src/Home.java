import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class Home extends Window {


    private JButton purchase = new JButton("Make Purchase");
    private JButton enroll_member = new JButton( "Enroll Club Member");
    private JButton logout = new JButton("Log Out");
    private JButton salesReport = new JButton("Generate Reports");
    private JButton checkPoints = new JButton("Member Information");
    private JButton inventoryCheck = new JButton("Inventory Check");
    private JButton orderSupplies = new JButton("Order Supplies");
    private JButton updatePassword = new JButton("Update Password");
    private JButton deleteOrderSupplies = new JButton("Delete Order Supplies");


    private GridBagConstraints constraints = new GridBagConstraints();

    private JPanel left;
    private JPanel right;
    private JPanel middle;


    public Home() {
        super (new GridLayout(1,3));

        addActions();
        placeButtons();
    }

    private void placeButtons(){
        constraints.anchor = GridBagConstraints.WEST;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.weightx = 0;
        constraints.insets = new Insets(10,10,10,10);



        right = new JPanel(new GridBagLayout());
        middle = new JPanel(new GridBagLayout());
        left = new JPanel(new GridBagLayout());

        add(left);
        add(right);
        add(middle);

        constraints.gridx = 0;
        constraints.gridy = 0;
        left.add(logout, constraints);

        constraints.gridy = 1;
        left.add(updatePassword, constraints);

        constraints.gridx = 0;
        constraints.gridy = 2;
        left.add(purchase, constraints);

        constraints.gridx = 0;
        constraints.gridy = 1;
        middle.add(enroll_member, constraints);

        constraints.gridx = 0;
        constraints.gridy = 0;
        middle.add(deleteOrderSupplies, constraints);

        constraints.gridx = 0;
        constraints.gridy = 2;
        middle.add(inventoryCheck, constraints);




        constraints.gridx = 0;
        constraints.gridy = 0;
        right.add(orderSupplies, constraints);

        constraints.gridx = 0;
        constraints.gridy = 1;
        right.add(salesReport, constraints);

        constraints.gridx = 0;
        constraints.gridy = 2;
        right.add(checkPoints, constraints);


        revalidate();
        repaint();

    }

    private void addActions(){

        purchase.setVisible(true);
        enroll_member.setVisible(true);
        logout.setVisible(true);
        checkPoints.setVisible(true);

//        action4.setVisible(false);
//        action6.setVisible(false);
//        action7.setVisible(false);

        if (Main.getUser() == Main.User.MANAGER){
            salesReport.setVisible(true);
            orderSupplies.setVisible(true);
            inventoryCheck.setVisible(true);
        } else if (Main.getUser() == Main.User.CLERK){
            salesReport.setVisible(false);
            orderSupplies.setVisible(false);
            inventoryCheck.setVisible(false);
        }

        logout.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getLogInWindow());

            }
        });

        salesReport.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getSalesReportWindow());
            }
        });

        updatePassword.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.updatePasswordWindow());
            }
        });

        enroll_member.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getNewClubMemberWindow());

            }
        });

        inventoryCheck.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getCheckInventoryWindow());

            }
        });

        checkPoints.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getLookUpClubmemberWindow());
            }
        });

        purchase.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.getMakePurchaseWindow();
                Main.switchWindow(Main.getMakePurchaseWindow());
            }
        });

        orderSupplies.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.getOrderSuppliesWindoworderSuppliesWindow();
                Main.switchWindow(Main.getOrderSuppliesWindoworderSuppliesWindow());
            }
        });

        deleteOrderSupplies.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.getOrderSuppliesWindoworderSuppliesWindow();
                Main.switchWindow(Main.getDeleteSuppliesWindow());
            }
        });


    }

    @Override
    public void refresh(){
        super.refresh();
        addActions();
    }
}
