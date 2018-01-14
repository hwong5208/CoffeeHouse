import com.sun.org.apache.bcel.internal.generic.POP;
import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.imageio.plugins.jpeg.JPEGHuffmanTable;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.sql.*;
import javax.swing.table.*;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class salesReport extends Window {

    private JTable table;

    private JLabel yearLabel = new JLabel("Year: ");
    private JLabel monthLabel = new JLabel("Month: ");
    private JLabel dayLabel = new JLabel("Day: ");

    private String[] yearStrings = { "2017", "2016" };
    private String[] monthStrings = {"all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    private String[] dayStrings = {"all", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13",
    "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"};

    private JComboBox yearField = new JComboBox(yearStrings);
    private JComboBox monthField = new JComboBox(monthStrings);
    private JComboBox dayField = new JComboBox(dayStrings);

    private JCheckBox returnItemId = new JCheckBox("Return and Order by Item Ids");

    private JButton salesReport = new JButton("Sales Report");
    private JButton back = new JButton("Return To Home Page");
    private JButton peakHoursReport = new JButton("Peak Hours Report");
    private JButton mostPopularItem = new JButton("Most Popular Item(s)");
    private JButton leastPopularItem = new JButton("Least Popular Item(s)");
    private JButton itemsSoldEveryDay = new JButton("Item(s) Sold Every Day");

    class DateQueries {
        String year;
        String month;
        String day;
        String monthQuery = "\n";
        String dayQuery = "\n";

        DateQueries() {
            year = yearField.getSelectedItem().toString();
            month = monthField.getSelectedItem().toString();
            day = dayField.getSelectedItem().toString();

            if (!month.equals("all")) {
                monthQuery = "AND MONTH(ST.ttime) = " + month + "\n";
            };
            if (!day.equals("all")) {
                dayQuery = "AND DAY(ST.ttime) = " + day + "\n";
            };
        }

        DateQueries getDateQueriesObject() {
            DateQueries dateQueriesObj = new DateQueries();
            return dateQueriesObj;
        }
    }

    public salesReport() {
        super(new GridBagLayout());
        GridBagConstraints constraints = new GridBagConstraints();
        // this specifies the padding of top, left, and bottom
        constraints.insets = new Insets(10,10,10,10);

        returnItemId.setSelected(false);

        JPanel left = new JPanel(new GridBagLayout());
        JPanel middle = new JPanel(new GridBagLayout());
        JPanel right = new JPanel(new GridBagLayout());

        add(left, constraints);
        add(middle, constraints);
        add(right, constraints);

        right.add(back, constraints);

        left.add(yearLabel, constraints);
        left.add(monthLabel, constraints);
        left.add(dayLabel, constraints);

        constraints.gridy = 1;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        left.add(yearField, constraints);
        left.add(monthField, constraints);
        left.add(dayField, constraints);

        constraints.gridy = 0;
        middle.add(peakHoursReport, constraints);
        constraints.gridy = 1;
        middle.add(returnItemId, constraints);
        constraints.gridy = 2;
        middle.add(salesReport, constraints);
        constraints.gridy = 3;
        middle.add(mostPopularItem, constraints);
        constraints.gridy = 4;
        middle.add(leastPopularItem, constraints);
        constraints.gridy = 5;
        middle.add(itemsSoldEveryDay, constraints);

        peakHoursReport.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {printPeakHoursReport();}
        });

        salesReport.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printSalesReport();
            }
        });

        mostPopularItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printMostPopularOrUnpopularItem(Boolean.TRUE);
            }
        });

        leastPopularItem.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printMostPopularOrUnpopularItem(Boolean.FALSE);
            }
        });

        itemsSoldEveryDay.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                printItemSoldEveryDay();
            }
        });

        back.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getHomeWindow());
            }
        });

    }

    private void printPeakHoursReport() {
        DateQueries dateQueries = new DateQueries().getDateQueriesObject();

        String peakHoursQuery = "(SELECT\n" +
                "  Hour(ST.ttime) as Hour24HFormat,\n" +
                "  CAST(COUNT(ST.tid) AS CHAR) as NumTransactions,\n" +
                "  CONCAT('$', FORMAT(SUM(I.price * TT.qty), 2)) as Amount\n" +
                "FROM sale_transaction as ST\n" +
                "JOIN transaction_items as TT\n" +
                "  on ST.tid = TT.tid\n" +
                "JOIN item as I\n" +
                "  on TT.item_id = I.item_id\n" +
                "WHERE\n" +
                "  YEAR(ST.ttime) = " + dateQueries.year +"\n" +
                dateQueries.monthQuery +
                dateQueries.dayQuery +
                "GROUP BY\n" +
                "  Hour(ST.ttime))\n";

        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery(peakHoursQuery);

            table = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table), "Peak Hours", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
        }
        catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    private void printSalesReport() {
        String returnItemIdQuery = "\n";
        String orderBy = "I.iname";
        if (returnItemId.isSelected()) {
            returnItemIdQuery = "I.item_id as Item_Ids, \n";
            orderBy = "I.item_id";
        };

        DateQueries dateQueries = new DateQueries().getDateQueriesObject();

        String salesReportQuery = "(SELECT " +
                returnItemIdQuery +
                "I.iname as Item_Name,\n" +
                "  CONCAT('$', FORMAT(I.price, 2)) as Price,\n" +
                "  CAST(SUM(TT.qty) AS CHAR) as Total_Units,\n" +
                "  CONCAT('$', FORMAT(SUM(I.price * TT.qty), 2)) as Total_Amount\n" +
                "FROM sale_transaction as ST\n" +
                "  JOIN transaction_items as TT\n" +
                "    on ST.tid = TT.tid\n" +
                "  JOIN item as I\n" +
                "    on I.item_id = TT.item_id\n" +
                "WHERE YEAR(ST.ttime) = " + dateQueries.year + "\n" +
                dateQueries.monthQuery +
                dateQueries.dayQuery +
                "GROUP BY I.item_id\n" +
                " ORDER BY " + orderBy + ")\n";

        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery(salesReportQuery);

            table = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table), "Sales Report", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
        }
        catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    private void printMostPopularOrUnpopularItem(boolean Popular) {
        String mostPopularOrUnpopularQuery = "(SELECT MAX(A.TotalQty) as TotalQty\n";
        String tableTitle = "Most Popular Item(s)";
        String returnItemIdQuery = "\n";
        String orderBy = "iname";

        if (!Popular) {
            mostPopularOrUnpopularQuery = "(SELECT MIN(A.TotalQty) as TotalQty\n";
            tableTitle = "Least Popular Item(s)";
        };
        if (returnItemId.isSelected()) {
            returnItemIdQuery = "B.item_id as Item_Ids, \n";
            orderBy = "item_id";
        };

        DateQueries dateQueries = new DateQueries().getDateQueriesObject();

        String mostPopularItemQuery = "SELECT " +
                returnItemIdQuery +
                "B.iname, B.TotalQty\n" +
                "FROM (SELECT\n" +
                "I.item_id, I.iname, SUM(T.qty) as TotalQty\n" +
                "FROM sale_transaction as ST\n" +
                "JOIN transaction_items as T\n" +
                "ON ST.tid = T.tid\n" +
                "JOIN item as I\n" +
                "ON T.item_id = I.item_id\n" +
                "  WHERE YEAR(ST.ttime) = 2017\n" +
                dateQueries.monthQuery +
                dateQueries.dayQuery +
                "GROUP BY I.item_id, I.iname\n" +
                "ORDER BY " + orderBy + ") AS B\n" +
                "WHERE B.TotalQty =\n" +
                mostPopularOrUnpopularQuery +
                "FROM\n" +
                "(SELECT\n" +
                "I.item_id, I.iname, SUM(T.qty) as TotalQty\n" +
                "FROM sale_transaction as ST\n" +
                "JOIN transaction_items as T\n" +
                "ON ST.tid = T.tid\n" +
                "JOIN item as I\n" +
                "ON T.item_id = I.item_id\n" +
                "  WHERE YEAR(ST.ttime) = " + dateQueries.year + "\n" +
                dateQueries.monthQuery +
                dateQueries.dayQuery +
                "GROUP BY I.item_id, I.iname\n" +
                "ORDER BY " + orderBy +") AS A)" +
                "ORDER BY B." + orderBy + "\n";

        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery(mostPopularItemQuery);

            table = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table), tableTitle, JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
        }
        catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    private void printItemSoldEveryDay() {
        DateQueries dateQueries = new DateQueries().getDateQueriesObject();

        String itemSoldEverydayQuery = "SELECT item_id, iname\n" +
                " FROM item i\n" +
                " WHERE NOT EXISTS (SELECT DISTINCT(std.date)\n" +
                " FROM sale_transaction_date std\n" +
                " WHERE std.date NOT IN\n" +
                "(SELECT distinct(std2.date)\n" +
                " FROM transaction_items t, sale_transaction_date std2\n" +
                " WHERE i.item_id = t.item_id AND std2.tid = t.tid))\n";

        try {
            Statement stmt = ConnectDB.conn.createStatement();
            ResultSet rs = stmt.executeQuery(itemSoldEverydayQuery);

            table = new JTable(checkMember.buildTableModel(rs));
            UIManager.put("OptionPane.minimumSize", new Dimension(1200,600));

            Image image = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
            JPanel gui = new JPanel(new BorderLayout());

            JLabel clouds = new JLabel(new ImageIcon(new BufferedImage(250, 100,
                    BufferedImage.TYPE_INT_RGB)));
            gui.add(clouds);

            JOptionPane.showMessageDialog(null,new JScrollPane(table), "Item(s) Sold Every Day", JOptionPane.DEFAULT_OPTION, new ImageIcon(image));
        }
        catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }
}
