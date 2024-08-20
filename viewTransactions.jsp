<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
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
        <h1>Transaction History</h1>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Sale ID</th>
                    <th>Payment Date</th>
                    <th>Payment Method</th>
                    <th>Payment Amount</th>
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

                        String query = "SELECT * FROM transactions";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("transaction_id") %></td>
                    <td><%= rs.getInt("sale_id") %></td>
                    <td><%= rs.getTimestamp("payment_date") %></td>
                    <td><%= rs.getString("payment_method") %></td>
                    <td><%= rs.getDouble("payment_amount") %></td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving transaction data.</p>");
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
