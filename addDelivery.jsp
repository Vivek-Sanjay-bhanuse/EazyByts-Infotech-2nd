<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Delivery</title>
    <style>
        /* Base styles */
        :root {
            --primary-color: #007bff;
            --secondary-color: #6c757d;
            --background-color: #f0f2f5;
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
            background: linear-gradient(135deg, #e2e2e2 0%, #ffffff 100%);
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
            max-width: 500px;
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
        input[type="date"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--input-border-color);
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="number"]:focus,
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
        <h1>Add New Delivery</h1>
        <form action="deliveryManager" method="post">
            <label for="bookId">Book ID:</label>
            <input type="number" id="bookId" name="bookId" required>
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required>
            <label for="deliveryDate">Delivery Date:</label>
            <input type="date" id="deliveryDate" name="deliveryDate" required>
            <button type="submit">Add Delivery</button>
        </form>
    </div>
</body>
</html>
