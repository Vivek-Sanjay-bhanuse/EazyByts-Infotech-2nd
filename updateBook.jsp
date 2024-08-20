<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book Details</title>
    <style>
        /* Base styles */
        :root {
            --primary-color: #007bff;
            --secondary-color: #6c757d;
            --background-color: #f8f9fa;
            --container-background: #ffffff;
            --text-color: #343a40;
            --input-border-color: #ced4da;
            --input-focus-color: #80bdff;
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
        }

        /* Container for centering and styling */
        .container {
            background-color: var(--container-background);
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        /* Heading styles */
        h1 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            text-align: center;
        }

        /* Form styles */
        form {
            display: grid;
            gap: 1rem;
        }

        label {
            display: block;
            font-weight: bold;
            color: var(--text-color);
        }

        input[type="number"],
        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--input-border-color);
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="number"]:focus,
        input[type="text"]:focus,
        input[type="date"]:focus {
            border-color: var(--input-focus-color);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
        }

        button {
            background-color: var(--button-bg-color);
            color: var(--button-text-color);
            border: none;
            padding: 0.75rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button:hover {
            background-color: var(--button-hover-bg-color);
        }

        button:focus {
            outline: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Book Details</h1>
        <form action="bookManager" method="post">
            <input type="hidden" name="action" value="update">
            <label for="bookId">Book ID:</label>
            <input type="number" id="bookId" name="bookId" required>
            <label for="title">Title:</label>
            <input type="text" id="title" name="title">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author">
            <label for="genre">Genre:</label>
            <input type="text" id="genre" name="genre">
            <label for="price">Price:</label>
            <input type="number" step="0.01" id="price" name="price">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity">
            <label for="publishedDate">Published Date:</label>
            <input type="date" id="publishedDate" name="publishedDate">
            <label for="isbn">ISBN:</label>
            <input type="text" id="isbn" name="isbn">
            <button type="submit">Update Book</button>
        </form>
    </div>
</body>
</html>
