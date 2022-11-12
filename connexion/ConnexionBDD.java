package cny.connexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionBDD {
	private static Connection conn = null;
	
	public static Connection getConn() throws ClassNotFoundException, SQLException {
		if(conn==null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try {conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cny_ecommerce","root","eisti0001");}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
}
