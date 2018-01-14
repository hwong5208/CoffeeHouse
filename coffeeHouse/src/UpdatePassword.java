import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by billy on 2017-03-30.
 */
public class UpdatePassword extends Window {

    private JLabel oldPasswordLabel = new JLabel("Enter Current Password: ");
    private JLabel newPassword1Label = new JLabel("Enter New Password: ");
    private JLabel newPassword2Label = new JLabel("Enter New Password Again: ");

    private JPasswordField oldPassword = new JPasswordField(10);
    private JPasswordField newPassword1 = new JPasswordField(10);
    private JPasswordField newPassword2 = new JPasswordField(10);

    private JButton back = new JButton("Back To Home Page");
    private JButton update = new JButton("Update Password");

    public UpdatePassword() {
        super(new GridBagLayout());

        GridBagConstraints constraints = new GridBagConstraints();
        // this specifies the padding of top, left, and bottom
        constraints.insets = new Insets(10,10,10,10);

        JPanel left = new JPanel(new GridBagLayout());
        JPanel right = new JPanel(new GridBagLayout());

        add(left, constraints);
        add(right, constraints);

        constraints.gridy = 0;
        left.add(oldPasswordLabel, constraints);
        right.add(oldPassword, constraints);

        constraints.gridy = 1;
        left.add(newPassword1Label, constraints);
        right.add(newPassword1, constraints);

        constraints.gridy = 2;
        left.add(back, constraints);
        right.add(update, constraints);

        update.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {updatePassword();}
        });

        back.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.switchWindow(Main.getHomeWindow());
            }
        });
    }

    private void updatePassword() {

    }
}
