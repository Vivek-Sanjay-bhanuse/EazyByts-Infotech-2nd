<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books Available for Purchase</title>
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
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
        .buy-button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 1rem;
            margin: 0.5rem 0;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Available Books</h1>
        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Genre</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Published Date</th>
                    <th>ISBN</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        String dbDriver = "org.postgresql.Driver";
                        String dbURL = "jdbc:postgresql://localhost:5432/unique_book_center"; // Replace with your database name
                        String dbUsername = "postgres"; // Replace with your PostgreSQL username
                        String dbPassword = "root"; // Replace with your PostgreSQL password

                        Class.forName(dbDriver);
                        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                        String query = "SELECT * FROM books";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();
                    %>
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("book_id") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("author") %></td>
                        <td><%= rs.getString("genre") %></td>
                        <td><%= rs.getDouble("price") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td><%= rs.getDate("published_date") %></td>
                        <td><%= rs.getString("isbn") %></td>
                        <td>
                            <form action="purchaseBook.jsp" method="get">
                                <input type="hidden" name="bookId" value="<%= rs.getInt("book_id") %>">
                                <button type="submit" class="buy-button">Buy Now</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    <%
                    } catch (Exception e) {
                        e.printStackTrace();
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
