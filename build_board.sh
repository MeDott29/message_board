#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for Node.js
if ! command_exists node; then
    echo "Node.js is not installed. Please install Node.js and try again."
    exit 1
fi

# Check for npm
if ! command_exists npm; then
    echo "npm is not installed. Please install npm and try again."
    exit 1
fi

# Create project directory
PROJECT_DIR="message-board"
mkdir -p $PROJECT_DIR/public
cd $PROJECT_DIR || exit

# Initialize a new Node.js project
echo "Initializing Node.js project..."
npm init -y

# Install Express
echo "Installing Express.js..."
npm install express body-parser

# Create server.js file
echo "Creating server.js..."
cat <<EOL > server.js
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

let messages = [];

// Middleware
app.use(bodyParser.json());
app.use(express.static('public')); // Serve HTML and JS

// Get all messages
app.get('/messages', (req, res) => {
    res.json(messages);
});

// Post a new message
app.post('/messages', (req, res) => {
    const { content } = req.body;

    if (content && content.trim()) {
        messages.push({ content });
        res.status(201).json({ success: true });
    } else {
        res.status(400).json({ error: 'Message content cannot be empty' });
    }
});

app.listen(port, () => {
    console.log(\`Server running at http://localhost:\${port}\`);
});
EOL

# Create public/index.html file
echo "Creating public/index.html..."
cat <<EOL > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Message Board</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        .message-board {
            max-width: 600px;
            margin: auto;
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .message {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
        }

        form {
            margin-bottom: 20px;
        }

        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            font-size: 16px;
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="message-board">
        <h1>Message Board</h1>
        
        <div id="messages">
            <!-- Messages will be loaded here -->
        </div>
        
        <form id="messageForm">
            <textarea id="messageText" placeholder="Write your message..."></textarea>
            <button type="submit" id="submitBtn">Post Message</button>
        </form>
    </div>

    <script>
        async function fetchMessages() {
            const response = await fetch('/messages');
            const messages = await response.json();

            const messagesDiv = document.getElementById('messages');
            messagesDiv.innerHTML = ''; // Clear existing messages

            messages.forEach(message => {
                const messageDiv = document.createElement('div');
                messageDiv.classList.add('message');
                messageDiv.textContent = message.content;
                messagesDiv.appendChild(messageDiv);
            });
        }

        async function postMessage(content) {
            await fetch('/messages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ content }),
            });

            fetchMessages(); // Reload messages
        }

        document.getElementById('messageForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const messageText = document.getElementById('messageText').value;

            if (messageText.trim()) {
                postMessage(messageText);
                document.getElementById('messageText').value = ''; // Clear input field
            }
        });

        // Load messages when the page loads
        fetchMessages();
    </script>
</body>
</html>
EOL

# Run the server
echo "Setup complete. Starting the server..."
node server.js
