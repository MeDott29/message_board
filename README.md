# Simple Message Board

This project implements a simple message board web application using Node.js, Express.js, and HTML.  Users can post and view messages.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Node.js and npm (or yarn) installed on your system.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd simple-message-board
   ```
3. Run the build script:
   ```bash
   ./build_board.sh
   ```
   This script will:
     * Create the project directory structure.
     * Initialize a Node.js project.
     * Install necessary dependencies (Express.js and body-parser).
     * Create the server.js file (backend) and public/index.html file (frontend).
     * Start the server.

### Running the application

Once the build script completes, the message board will be accessible at `http://localhost:3000` in your web browser.


## Built With

* [Node.js](https://nodejs.org/) - JavaScript runtime environment
* [Express.js](https://expressjs.com/) - Web application framework for Node.js
* [body-parser](https://www.npmjs.com/package/body-parser) - Node.js body parsing middleware


## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

