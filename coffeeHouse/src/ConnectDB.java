import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
;

/**
 * Created by billy on 2017-03-23.
 */

public class ConnectDB {
    static Connection conn=null;

    public static Connection getConnection()
    {
        if (conn != null) return conn;
        // get db, user, pass from settings file
        try {
            Properties properties = new Properties();
            properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("config.properties"));
            String url = properties.getProperty("jdbc.url");
            String driver = properties.getProperty("jdbc.driver");
            String username = properties.getProperty("jdbc.username");
            String password = properties.getProperty("jdbc.password");

            return getConnection(driver, url, username, password);
        } catch (IOException ie) {
            ie.printStackTrace();
        }
        return null;
    }

    private static Connection getConnection(String driver, String url, String username,String password)
    {
        try
        {
            // create our mysql database connection
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
            System.out.format("Created connection");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        return conn;
    }


}
