<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 2rem auto;
            background: #fff;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sales Report - Most Sold Books (Last Month)</h1>
        <table>
            <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Total Sold</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        String dbDriver = "org.postgresql.Driver";
                        String dbURL = "jdbc:postgresql://localhost:5432/unique_book_center";
                        String dbUsername = "postgres";
                        String dbPassword = "root";

                        Class.forName(dbDriver);
                        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                        String query = "SELECT title, SUM(quantity) AS total_sold " +
                                       "FROM sales " +
                                       "JOIN books ON sales.book_id = books.book_id " +
                                       "WHERE sales.sale_date >= CURRENT_DATE - INTERVAL '1 month' " +
                                       "GROUP BY title " +
                                       "ORDER BY total_sold DESC";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getInt("total_sold") %></td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving sales data.</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
