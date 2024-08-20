<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Book</title>
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
        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        label {
            font-weight: bold;
        }
        input, button {
            padding: 0.5rem;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Purchase Book</h1>
        <%
            class Book {
                private int bookId;
                private String title;
                private String author;
                private String genre;
                private double price;
                private int quantity;
                private Date publishedDate;
                private String isbn;

                public Book(int bookId, String title, String author, String genre, double price, int quantity, Date publishedDate, String isbn) {
                    this.bookId = bookId;
                    this.title = title;
                    this.author = author;
                    this.genre = genre;
                    this.price = price;
                    this.quantity = quantity;
                    this.publishedDate = publishedDate;
                    this.isbn = isbn;
                }

                public int getBookId() { return bookId; }
                public String getTitle() { return title; }
                public String getAuthor() { return author; }
                public String getGenre() { return genre; }
                public double getPrice() { return price; }
                public int getQuantity() { return quantity; }
                public Date getPublishedDate() { return publishedDate; }
                public String getIsbn() { return isbn; }
            }

            String bookId = request.getParameter("bookId");
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            Book book = null;

            try {
                String dbDriver = "org.postgresql.Driver";
                String dbURL = "jdbc:postgresql://localhost:5432/unique_book_center";
                String dbUsername = "postgres";
                String dbPassword = "root";

                Class.forName(dbDriver);
                conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                String query = "SELECT * FROM books WHERE book_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, Integer.parseInt(bookId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    book = new Book(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("genre"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getDate("published_date"),
                        rs.getString("isbn")
                    );
                }
            %>
            <%
                if (book != null) {
            %>
            <form action="processPurchase.jsp" method="post">
                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                <input type="hidden" name="price" value="<%= book.getPrice() %>">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>

                <label for="upiId">UPI ID:</label>
                <input type="text" id="upiId" name="upiId" required>

                <button type="submit">Submit Purchase</button>
            </form>
            <% 
                } else { 
                    out.println("<p>Book not found.</p>");
                }
            %>
            <%
                // Close resources
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>There was an error processing the request. Please try again later.</p>");
            }
            %>
        </div>
    </body>
</html>
