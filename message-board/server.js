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
    console.log(`Server running at http://localhost:${port}`);
});
