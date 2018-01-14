import javax.swing.*;
import java.awt.*;

/**
 * Created by mehryarmaalem on 2017-03-21.
 */
public class Window extends JPanel {

    public Window (LayoutManager layout){
        super(layout);
    }

    public void refresh(){
        revalidate();
        repaint();

    }
}