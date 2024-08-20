<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* Base styles */
        :root {
            --primary-color: #007bff;
            --secondary-color: #6c757d;
            --background-color: #f8f9fa;
            --container-background: #ffffff;
            --text-color: #343a40;
            --link-color: #007bff;
            --link-hover-color: #0056b3;
            --button-bg-color: #007bff;
            --button-hover-bg-color: #0056b3;
            --button-text-color: #ffffff;
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
            flex-direction: column;
        }

        /* Heading styles */
        h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        /* Container styles */
        div {
            text-align: center;
        }

        /* Link styles */
        a {
            display: inline-block;
            background-color: var(--primary-color);
            color: var(--button-text-color);
            padding: 0.75rem 1.5rem;
            margin: 0.5rem;
            border-radius: 4px;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: var(--link-hover-color);
        }

        /* Message styles */
        p {
            color: green;
            font-weight: bold;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <div>
        <a href="addBook.jsp">Add New Book</a>
        <a href="updateBook.jsp">Update Book Details</a>
        <a href="viewBooks.jsp">View Books</a>
        <a href="addDelivery.jsp">Add New Delivery</a>
        <a href="viewSales.jsp">View Most Sold Books</a>
        <a href="viewTransactions.jsp">View Transaction History</a>
    </div>
    <% if (request.getParameter("message") != null) { %>
        <p><%= request.getParameter("message") %></p>
    <% } %>
</body>
</html>
