import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
 
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        response.getWriter().println("Print Hello ");
        try {
            Connection conn = JDBCcode.connectDB();
            String query = "INSERT INTO Admin (username, password, email) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password); // Hash password in a real application
            pst.setString(3, email);
            pst.executeUpdate();
            response.sendRedirect("login.html");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(e);
        }
    }
}
