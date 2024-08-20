<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Books</title>
    <style>
        /* Base styles */
        :root {
            --primary-color: #007bff;
            --secondary-color: #6c757d;
            --background-color: #f8f9fa;
            --container-background: #ffffff;
            --text-color: #343a40;
            --table-header-bg-color: #007bff;
            --table-header-text-color: #ffffff;
            --table-row-bg-color: #ffffff;
            --table-row-hover-bg-color: #f1f1f1;
        }

        /* General body styles */
        body {
            font-family: Arial, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Container for centering and styling */
        .container {
            background-color: var(--container-background);
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
        }

        /* Heading styles */
        h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            text-align: center;
        }

        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        thead {
            background-color: var(--table-header-bg-color);
            color: var(--table-header-text-color);
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid var(--secondary-color);
        }

        tbody tr:hover {
            background-color: var(--table-row-hover-bg-color);
        }

        th {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Books in Store</h1>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                String dbDriver = "org.postgresql.Driver";
                String dbURL = "jdbc:postgresql://localhost:5432/unique_book_center"; // Replace with your database name
                String dbUsername = "postgres"; // Replace with your PostgreSQL username
                String dbPassword = "root"; // Replace with your PostgreSQL password

                // Load and register PostgreSQL JDBC driver
                Class.forName(dbDriver);
                conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);   
                String sql = "SELECT * FROM books";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
        %>
        
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
                </tr>
            </thead>
            <tbody>
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
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <%
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <p>Error fetching book data. Please try again later.</p>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
