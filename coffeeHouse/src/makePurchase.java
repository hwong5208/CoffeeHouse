import javafx.scene.control.TextInputDialog;

import javax.swing.*;
import javax.swing.plaf.nimbus.State;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class makePurchase extends Window {

    // transaction item set to keep track of quantity of items
    public Map<String, Integer> transaction_items = new HashMap<>();


    // SQL connection
    public Connection conn = ConnectDB.getConnection();

    private JButton completePurchase = new JButton("Complete Transaction");
    private JButton addItem = new JButton("Add Item");
    private JButton removeItem = new JButton("Remove Item");
    private JButton cancelTransaction = new JButton("Cancel Transaction");
    // TODO Need to connect to these two windows
    // private JButton newClubMember = new JButton("New Club Member");
    private JButton lookUpMember = new JButton("Look Up Club Member");
    //
    private JLabel insertClubId = new JLabel("Insert Club id:");

    // Debit & Credit
    private JRadioButton debit = new JRadioButton("Debit");
    private JRadioButton credit = new JRadioButton("Credit");
    private JRadioButton cash = new JRadioButton("Cash");

    // Total Price
    private JPanel amountPanel = new JPanel();
    private JLabel amount_label = new JLabel("Total Price:");
    private JLabel amount = new JLabel();


    // Clube Member Id
    private JTextField club_id = new JTextField(20);

    private String[] items = {"Coffee", "Espresso", "Americano", "Macchiato", "Cappucino",
            "Flat White", "Latte", "Mocha", "Hot Chocolate", "Black Tea",
            "Green Tea", "Salad", "Soup", "Grilled Cheese Sandwich",
            "Turkey Sandwich", "Vegetarian Sandwich"};
    // Combo Box
    private String[] column_names = {"Item name", "Price"};
    private DefaultTableModel cartItmes = new DefaultTableModel(column_names,0);
    private JTable cartTable = new JTable(cartItmes);
    private JScrollPane scrollPane = new JScrollPane(cartTable);

    // HashMap<Integer, String> cartItems = new HashMap<>();
    Double total_amount = 0.00;

    JComboBox itemList = new JComboBox(items);


    public makePurchase() {
        super(new GridBagLayout());


        amount.setText(total_amount.toString()+" $");
        amountPanel.add(amount_label);
        amountPanel.add(amount);




        GridBagConstraints constraints = new GridBagConstraints();

        constraints.insets = new Insets(10, 10, 10, 10);

        constraints.anchor = GridBagConstraints.WEST;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.weightx = 0;

        JPanel right = new JPanel(new GridBagLayout());
        JPanel left = new JPanel(new GridBagLayout());

        add(left);
        add(right);

        constraints.gridx = 1;
        constraints.gridy = 1;
        left.add(itemList, constraints);

        constraints.gridx = 3;
        constraints.gridy = 1;
        left.add(addItem, constraints);

        constraints.gridx = 3;
        constraints.gridy = 2;
        left.add(removeItem, constraints);


        constraints.gridx = 3;
        constraints.gridy = 3;
        left.add(cancelTransaction, constraints);

        constraints.gridx = 3;
        constraints.gridy = 4;
        left.add(completePurchase, constraints);


        constraints.gridx = 1;
        constraints.gridy = 9;
        left.add(insertClubId, constraints);
        constraints.gridx = 1;
        constraints.gridy = 10;
        left.add(club_id, constraints);

        constraints.gridx = 1;
        constraints.gridy = 11;
        left.add(lookUpMember, constraints);

//        constraints.gridx = 1;
//        constraints.gridy = 12;
//        left.add(newClubMember, constraints);


        constraints.gridx = 3;
        constraints.gridy = 11;
        left.add(debit, constraints);
        constraints.gridx = 3;
        constraints.gridy = 12;
        left.add(credit, constraints);
        constraints.gridx = 3;
        constraints.gridy = 13;
        left.add(cash, constraints);
        cash.setSelected(true);


        constraints.gridx = 0;
        constraints.gridy = 0;
        scrollPane.setPreferredSize(new Dimension(400, 400));
        right.add(scrollPane, constraints);

        constraints.gridx = 0;
        constraints.gridy = 1;
        right.add(amountPanel);


        // completing purchase.
        completePurchase.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                if (total_amount > 0.00) {


                    //Boolean correctCID = checkCID(insertClubId.getText());
                    String cust_id = club_id.getText();

                    System.out.print(cust_id);
                    cust_id.trim();

                    if (club_id.getText().isEmpty()) {

                        makeTransaction(total_amount, Integer.valueOf(LogInWindow.getUserID()), -1);
                        updateInventory(transaction_items);
                        JOptionPane.showMessageDialog(null, "Transaction Complete","Success!", JOptionPane.INFORMATION_MESSAGE);
                        Main.getHomeWindow();
                        Main.switchWindow(Main.getHomeWindow());
                        amount.setText("0.0 $");
                        transaction_items.clear();

                        if (cartItmes.getRowCount() > 0) {
                            for (int i = cartItmes.getRowCount() - 1; i > -1; i--) {
                                cartItmes.removeRow(i);
                            }

                        }
                    } else {
                        try {


                            System.out.print(cust_id);
                            String query = "SELECT cid \n" +
                                    "FROM club_members\n" +
                                    "WHERE cid = ?";


                            PreparedStatement st = conn.prepareStatement(query);
                            st.setString(1, cust_id);

                            ResultSet rs = st.executeQuery();
                            // Check whether cust id Exists
                            if (rs.next()) {
                                makeTransaction(total_amount, Integer.valueOf(LogInWindow.getUserID()), Integer.valueOf(cust_id));
                                updateInventory(transaction_items);
                                transaction_items.clear();
                                JOptionPane.showMessageDialog(null, "Transaction Complete","Success!", JOptionPane.INFORMATION_MESSAGE);
                                Main.getHomeWindow();
                                Main.switchWindow(Main.getHomeWindow());
                                amount.setText("0.0 $");
                                if (cartItmes.getRowCount() > 0) {
                                    for (int i = cartItmes.getRowCount() - 1; i > -1; i--) {
                                        cartItmes.removeRow(i);
                                    }
                                }

                            } else {
                                // TODO: Invalid Customer Id
                                JOptionPane.showMessageDialog(null, "Wrong Club Member ID!");
                            }


                        } catch (Exception s) {
                            System.err.println("Got an exception!");
                            System.err.println(s.getMessage());
                        }

                    }
                } else {

                    JOptionPane.showMessageDialog(null,"Please add items to make a purchase!", "Warning", JOptionPane.ERROR_MESSAGE);

                }

            }
        });

        addItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {


                String selected = itemList.getSelectedItem().toString();
                if (transaction_items.containsKey(selected)){
                    // Add the increase the quantity of an item
                    transaction_items.put(selected,transaction_items.get(selected)+1);
                    System.out.print(transaction_items.get(selected));
                } else{
                    transaction_items.put(selected,1);
                    System.out.print(transaction_items.get(selected));
                }

                try {
                    String query = "SELECT price\n" +
                            "FROM item \n" +
                            "WHERE iname= ?";


                    PreparedStatement st = conn.prepareStatement(query);
                    st.setString(1, selected);
                    ResultSet rs = st.executeQuery();


                    while (rs.next()) {
                        Float p = rs.getFloat("price");
                        String price = p.toString();
                        cartItmes.addRow(new Object[]{selected, price + " $"});
                        total_amount += Double.valueOf(price);
                        amount.setText(total_amount + "$");

                    }


                } catch (Exception s) {
                    System.err.println("Got an exception!");
                    System.err.println(s.getMessage());
                }


            }
        });

        removeItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try{
                    int row = cartTable.getSelectedRow();
                    Object price = cartTable.getValueAt(cartTable.getSelectedRow(),1);
                    Object name = cartTable.getValueAt(cartTable.getSelectedRow(),0);
                    String name_string = name.toString();
                    transaction_items.remove(name_string);
                    String price_string = price.toString();
                    Double pdouble = Double.valueOf(price_string.substring(0,price_string.length() - 2));
                    total_amount -= pdouble;
                    amount.setText(total_amount.toString() + " $");
                    cartItmes.removeRow(row);
                } catch (Exception s){

                }

            }
        });

        cancelTransaction.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.getHomeWindow();
                Main.switchWindow(Main.getHomeWindow());

                amount.setText("0.0 $");

                if (cartItmes.getRowCount() > 0) {
                    for (int i = cartItmes.getRowCount() - 1; i > -1; i--) {
                        cartItmes.removeRow(i);
                    }
                }
            }
        });

//        newClubMember.addActionListener(new ActionListener() {
//            @Override
//            public void actionPerformed(ActionEvent e) {
//
//                try{
//                    String q0 = "SELECT MAX(tid) from sale_transaction";
//                    PreparedStatement st0 = conn.prepareStatement(q0);
//                    ResultSet set0 = st0.executeQuery(q0);
//                    if (set0.next()){
//                        Integer tid = set0.getInt(1);
//                        System.out.print(tid);
//                    }
//
//                } catch (Exception s){
//                    System.err.println(s.getMessage());
//                }
//            }
//        });

        // Radio Button
        debit.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                credit.setSelected(false);
                cash.setSelected(false);

            }
        });
        credit.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                debit.setSelected(false);
                cash.setSelected(false);}
        });

        cash.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                debit.setSelected(false);
                credit.setSelected(false);
            }
        });

        lookUpMember.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JLabel email = new JLabel("please input your phone number");



                boolean inputAccepted = false;
                while (!inputAccepted){
                    try {
                        Object[] o0 = {"Cancel", "Submit"};
                        String s = JOptionPane.showInputDialog( null, email, "Look Up Clubmember", JOptionPane.CANCEL_OPTION);

                        if (s == null){
                            inputAccepted = true;
                            return;
                        }

                        String query = "select cid from club_members where phone = ?";
                        PreparedStatement ps = conn.prepareStatement(query);
                        ps.setString(1,s);

                        ResultSet rs = ps.executeQuery();
                        if (rs.next()){
                            club_id.setText(rs.getString("cid"));
                            inputAccepted = true;
                        } else {
                            int can = JOptionPane.YES_NO_CANCEL_OPTION;
                            Object[] o = {"Try Again!", "Cancel"};
                            int cance = JOptionPane.showOptionDialog(null, "Wrong phone number!", "Warning", JOptionPane.YES_NO_CANCEL_OPTION,
                                    JOptionPane.ERROR_MESSAGE, null, o , "Cancel");

                            if (cance == JOptionPane.YES_OPTION){

                            } else {
                                inputAccepted = true;
                            }

                        }
                    } catch (Exception j) {
                        System.err.println(j.getMessage());
                    }
                }


            }
        });

//        newClubMember.addActionListener(new ActionListener() {
//            @Override
//            public void actionPerformed(ActionEvent e) {
//                Main.switchWindow(Main.getNewClubMemberWindow());
//
//            }
//        });




    }





        /*
         * insert into sale_transaction values
                (0018, 3.50, '2017-01-01 16:11:45', 'cash', 2, 9);
         */

    //

    public void makeTransaction(Double total_price, Integer eid, Integer cid ){
        String q1 = "INSERT into sale_transaction \n"+
                "values (?,?,CURRENT_TIMESTAMP,?,?,?)";
        String q2 = "INSERT into transaction_items \n"+
                "values (?,?,?)";
        String q3 = "SELECT item_id\n" +
                "FROM item \n" +
                "WHERE iname= ?";


        try {
            String q0 = "SELECT MAX(tid) from sale_transaction";
            PreparedStatement st0 = conn.prepareStatement(q0);
            ResultSet set0 = st0.executeQuery(q0);
            if (set0.next()){
                Integer tid = set0.getInt(1);
                Integer tid_touse = tid + 1;



                PreparedStatement st1 = conn.prepareStatement(q1);

                if (debit.isSelected()){ // debot
                    st1.setInt(1, tid_touse);
                    st1.setFloat(2, total_price.floatValue());
                    st1.setString(3,"debit");
                    st1.setInt(4, eid);
                    if (cid.equals(-1)){
                        System.out.print(cid);
                        st1.setNull(5, Types.INTEGER);
                    } else {
                        st1.setInt(5,cid);
                    }

                    // st1.setInt(5,cid);
                    st1.execute();



                } else if (credit.isSelected()){ // credit

                    st1.setInt(1,tid_touse);
                    st1.setFloat(2, total_price.floatValue());
                    st1.setString(3,"credit");
                    st1.setInt(4, eid);
                    if (cid.equals(-1)){
                        st1.setNull(5, Types.INTEGER);
                    } else {
                        st1.setInt(5, cid);
                    }
                    st1.execute();
                } else if (cash.isSelected()){ // cash
                    st1.setInt(1,tid_touse);
                    st1.setFloat(2, total_price.floatValue());
                    st1.setString(3,"cash");
                    st1.setInt(4, eid);
                    if (cid.equals(-1)){
                        st1.setNull(5, Types.INTEGER);
                    } else {
                        st1.setInt(5, cid);
                    }
                    st1.execute();

                }

                PreparedStatement st2 = conn.prepareStatement(q2); //insert
                PreparedStatement st3 = conn.prepareStatement(q3); // get item_id

                Integer item_id;



                for (Map.Entry<String, Integer> entry: transaction_items.entrySet()){
                    System.out.print(entry.getValue());
                    st3.setString(1,entry.getKey());
                    ResultSet set2 = st3.executeQuery();


                    if (set2.next()){
                        item_id = set2.getInt(1);
                        st2.setInt(1, tid_touse);
                        st2.setInt(2, item_id);
                        st2.setInt(3, entry.getValue());
                        st2.execute();
                    }


                }




            }

        } catch (Exception s){
            System.err.println(s.getMessage());
        }





    }

    public void updateInventory(Map<String,Integer> m){

        String query1 = "UPDATE supplies SET qty = qty - ? where supplies_id = ?";
        String query2 = "SELECT supplies_id, itype from item where iname = ?";
        String itype;
        Integer supplies_id;
        Integer qty_toSubtract;
        String iname;
        for (Map.Entry<String, Integer> entry: m.entrySet()){
            qty_toSubtract = entry.getValue();
            iname = entry.getKey();
            try{
                PreparedStatement p1 = conn.prepareStatement(query1);
                PreparedStatement p2 = conn.prepareStatement(query2);
                p2.setString(1,iname);
                ResultSet rs = p2.executeQuery();
                System.out.println(iname);
                System.out.println(qty_toSubtract);
                if (rs.next()){
                    supplies_id = rs.getInt("supplies_id");
                    itype = rs.getString("itype");
                    p1.setInt(1,qty_toSubtract);
                    p1.setInt(2, supplies_id);
                    p1.execute();
                    if (itype.equals("beverage")){
                        p1.setInt(2,20);
                        p1.execute();
                        p1.setInt(2,21);
                        p1.execute();
                    } else {
                        p1.setInt(2,22);
                        p1.execute();
                    }
                }

            }catch (Exception e){
                e.getMessage();
            }


        }
    }
}

