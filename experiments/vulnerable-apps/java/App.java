import java.sql.*;

public class App {
    public static void main(String[] args) throws Exception {
        String user = args[0];
        String query = "SELECT * FROM users WHERE name = '" + user + "'";
        Statement stmt = DriverManager.getConnection("jdbc:sqlite:test.db").createStatement();
        stmt.execute(query);
    }
}
