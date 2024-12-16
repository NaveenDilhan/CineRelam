<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Movie - ABC Cinema</title>
    <link rel="stylesheet" href="../css/admin-styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .form-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #007BFF;
            outline: none;
        }

        .form-actions {
            display: flex;
            justify-content: center;
        }

        .form-actions button {
            padding: 10px 20px;
            margin: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-actions button:hover {
            background-color: #0056b3;
        }

        .form-actions .cancel {
            background-color: #dc3545;
        }

        .form-actions .cancel:hover {
            background-color: #a71d2a;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add New Movie</h1>
        <form action="addMovieServlet" method="post">
            <div class="form-group">
                <label for="title">Movie Title</label>
                <input type="text" id="title" name="title" placeholder="Enter movie title" required>
            </div>

            <div class="form-group">
                <label for="genre">Genre</label>
                <select id="genre" name="genre" required>
                    <option value="">Select genre</option>
                    <option value="Action">Action</option>
                    <option value="Comedy">Comedy</option>
                    <option value="Drama">Drama</option>
                    <option value="Horror">Horror</option>
                    <option value="Sci-Fi">Sci-Fi</option>
                </select>
            </div>
            
            <div class="form-group">
    <label for="image">Movie Poster</label>
    <input type="file" id="image" name="image" accept="image/*" required>
               </div>


            <div class="form-group">
                <label for="duration">Duration (in minutes)</label>
                <input type="number" id="duration" name="duration" min="1" placeholder="Enter duration" required>
            </div>

            <div class="form-group">
                <label for="release_date">Release Date</label>
                <input type="date" id="release_date" name="release_date" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" placeholder="Enter movie description" required></textarea>
            </div>

            <div class="form-actions">
                <button type="submit">Add Movie</button>
                <button type="button" class="cancel" onclick="window.location.href='manageMovies.jsp';">Cancel</button>
            </div>
        </form>
    </div>
</body>
</html>
