import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class orderSupplies extends Window {
    /*
    Frame for ordering new supplies
     */

    SpinnerModel model = new SpinnerNumberModel(0.0, 0.0, 1000, 10);
    JSpinner spinner = new JSpinner(model);

    JScrollPane beverages = new JScrollPane();
    JScrollPane storesupplies;
    JComboBox supplies;

    Map<String, Integer> map = new HashMap<>();

    ArrayList<String> list_beverages = new ArrayList();

    JButton placeOrder = new JButton("Place Order");
    JButton cancelOrder = new JButton ("Cancel Order");


    public orderSupplies() {
        super(new GridBagLayout());
        list_beverages.toArray();
        String q0 = "select sname from supplies";


        try {
            PreparedStatement p1 = ConnectDB.conn.prepareStatement(q0);
            ResultSet rs = p1.executeQuery();

            while (rs.next()){
                list_beverages.add(rs.getString("sname"));

                // System.out.print(rs.getString("sname"));
            }
            JList list = new JList(list_beverages.toArray());
            storesupplies = new JScrollPane(list);
            supplies = new JComboBox(list_beverages.toArray());


        } catch (Exception e){
            e.getMessage();
        }


        GridBagConstraints constraints = new GridBagConstraints();
        constraints.insets = new Insets(10,10,10,10);
        constraints.anchor = GridBagConstraints.WEST;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        constraints.weightx = 0;

        JPanel right = new JPanel(new GridBagLayout());
        JPanel left  = new JPanel(new GridBagLayout());

        add(left);
        add(right);


        constraints.gridx = 1;
        constraints.gridy = 1;
        left.add(supplies, constraints);

        constraints.gridx = 2;
        constraints.gridy = 1;
        left.add(spinner, constraints);





        constraints.gridx = 1;
        constraints.gridy = 1;
        right.add(placeOrder, constraints);

        constraints.gridx = 1;
        constraints.gridy = 2;
        right.add(cancelOrder, constraints);

        String  s = "SELECT qty, cost, supplies_id  from supplies where sname = ?";
        String  s1 = "UPDATE supplies SET qty = ? where sname = ? ";
        String  s2 = "SELECT supllier_id from supplies where sname=?";
        String  s3 = "INSERT into orders values (?,?,?, ?, CURRENT_DATE ,?)";
        String s4 = "SELECT MAX(oid) from orders";


        placeOrder.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // System.out.print("coffee beans");
                Integer qty;
                Integer eid = Integer.valueOf(LogInWindow.getUserID());
                Integer updated_qty = Math.round(Float.valueOf(spinner.getValue().toString()));
                Float price;
                Float total_price;
                Integer supplies_id;
                Integer oid;
                Integer oid_touse;
                String item = supplies.getSelectedItem().toString();

                System.out.print(item);
                System.out.print(updated_qty);


                try{

                    PreparedStatement p = ConnectDB.conn.prepareStatement(s);
                    PreparedStatement p1 = ConnectDB.conn.prepareStatement(s1);
                    // PreparedStatement p2 = ConnectDB.conn.prepareStatement(s2);
                    PreparedStatement p3 = ConnectDB.conn.prepareStatement(s3);
                    PreparedStatement p4 = ConnectDB.conn.prepareStatement(s4);

                    p.setString(1,item);

                    ResultSet rs = p.executeQuery();
                    if (rs.next()){
                        qty = rs.getInt("qty");
                        qty += updated_qty;
                        price = rs.getFloat("cost");

                        supplies_id = rs.getInt("supplies_id");

                        total_price = price*updated_qty;
                        p1.setInt(1, qty);
                        p1.setString(2, item);
                        p1.execute();





                        System.out.print(supplies_id);

                        ResultSet rs2 = p4.executeQuery();
                        if (rs2.next()){
                            oid = rs2.getInt(1);
                            System.out.println(oid);
                            oid_touse = oid + 1;
                            System.out.println(oid_touse);
                            System.out.println(supplies_id);
                            System.out.println(eid);
                            System.out.println(total_price);
                            System.out.println(qty);
                            p3.setInt(1, oid_touse);
                            p3.setInt(2, supplies_id);
                            p3.setInt(3, eid);
                            p3.setFloat(4, total_price);
                            p3.setInt(5, updated_qty);
                            p3.execute();

                        }
                    }

                } catch (Exception f){
                    f.getMessage();
                }


            }
        });

        cancelOrder.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.getHomeWindow();
                Main.switchWindow(Main.getHomeWindow());
            }
        });




    }
}
