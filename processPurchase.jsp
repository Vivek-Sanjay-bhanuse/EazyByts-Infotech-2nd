<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Confirmation</title>
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
            text-align: center;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Purchase Confirmation</h1>
        <%
            String bookId = request.getParameter("bookId");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String upiId = request.getParameter("upiId");
            double price = Double.parseDouble(request.getParameter("price"));

            Connection conn = null;
            PreparedStatement pstmtInsertPurchase = null;
            PreparedStatement pstmtUpdateStock = null;
            PreparedStatement pstmtInsertSale = null;
            PreparedStatement pstmtInsertTransaction = null;

            try {
                String dbDriver = "org.postgresql.Driver";
                String dbURL = "jdbc:postgresql://localhost:5432/unique_book_center";
                String dbUsername = "postgres";
                String dbPassword = "root";

                Class.forName(dbDriver);
                conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                // Insert purchase into the database
                String insertPurchase = "INSERT INTO purchases (book_id, customer_name, customer_email, customer_phone, upi_id, price, purchase_date) VALUES (?, ?, ?, ?, ?, ?, NOW())";
                pstmtInsertPurchase = conn.prepareStatement(insertPurchase);
                pstmtInsertPurchase.setInt(1, Integer.parseInt(bookId));
                pstmtInsertPurchase.setString(2, name);
                pstmtInsertPurchase.setString(3, email);
                pstmtInsertPurchase.setString(4, phone);
                pstmtInsertPurchase.setString(5, upiId);
                pstmtInsertPurchase.setDouble(6, price);
                pstmtInsertPurchase.executeUpdate();

                // Update book stock
                String updateStock = "UPDATE books SET quantity = quantity - 1 WHERE book_id = ?";
                pstmtUpdateStock = conn.prepareStatement(updateStock);
                pstmtUpdateStock.setInt(1, Integer.parseInt(bookId));
                pstmtUpdateStock.executeUpdate();

                // Get the next sale_id
                ResultSet rs = conn.createStatement().executeQuery("SELECT COALESCE(MAX(sale_id), 0) + 1 AS next_sale_id FROM sales");
                int nextSaleId = 0;
                if (rs.next()) {
                    nextSaleId = rs.getInt("next_sale_id");
                }

                // Insert sale record
                String insertSale = "INSERT INTO sales (sale_id, book_id, quantity) VALUES (?, ?, 1)";
                pstmtInsertSale = conn.prepareStatement(insertSale);
                pstmtInsertSale.setInt(1, nextSaleId);
                pstmtInsertSale.setInt(2, Integer.parseInt(bookId));
                pstmtInsertSale.executeUpdate();

                // Insert transaction record
                String insertTransaction = "INSERT INTO transactions (sale_id, payment_date, payment_method, payment_amount) VALUES (?, NOW(), 'UPI', ?)";
                pstmtInsertTransaction = conn.prepareStatement(insertTransaction);
                pstmtInsertTransaction.setInt(1, nextSaleId);
                pstmtInsertTransaction.setDouble(2, price);
                pstmtInsertTransaction.executeUpdate();

                out.println("<p>Thank you for your purchase, " + name + "! Your transaction was successful.</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>There was an error processing your purchase. Please try again later.</p>");
            } finally {
                try {
                    if (pstmtInsertPurchase != null) pstmtInsertPurchase.close();
                    if (pstmtUpdateStock != null) pstmtUpdateStock.close();
                    if (pstmtInsertSale != null) pstmtInsertSale.close();
                    if (pstmtInsertTransaction != null) pstmtInsertTransaction.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
