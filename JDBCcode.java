import java.sql.*;
public class JDBCcode {

	 public static Connection connectDB () throws Exception  
	 {  
	  
	  Connection con=null;   
	  final String url="jdbc:postgresql://localhost:5432/unique_book_center";  
	  final String username="postgres";  
	  final String password="root";  
	     
	   
	  Class.forName("org.postgresql.Driver"); 
	   
	  con=DriverManager.getConnection(url,username,password); 
	  //System.out.println("Connection established.....");
	  return con;
	 }
}