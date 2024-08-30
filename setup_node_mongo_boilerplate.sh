#!/bin/bash

# Create the directory structure
mkdir -p config controllers models routes

# Create the .env file
touch .env

# Create the .gitignore file
cat <<EOL > .gitignore
node_modules
.env
EOL

# Create the package.json file
npm init -y

# Install dependencies
npm install express mongoose dotenv
npm install --save-dev nodemon

# Create config/db.js
mkdir -p config
cat <<EOL > config/db.js
const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected successfully');
  } catch (err) {
    console.error(err.message);
    process.exit(1);
  }
};

module.exports = connectDB;
EOL

# Create models/exampleModel.js
mkdir -p models
cat <<EOL > models/exampleModel.js
const mongoose = require('mongoose');

const ExampleSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('Example', ExampleSchema);
EOL

# Create controllers/exampleController.js
mkdir -p controllers
cat <<EOL > controllers/exampleController.js
const Example = require('../models/exampleModel');

exports.getExamples = async (req, res) => {
  try {
    const examples = await Example.find();
    res.json(examples);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.createExample = async (req, res) => {
  const example = new Example({
    name: req.body.name,
  });

  try {
    const newExample = await example.save();
    res.status(201).json(newExample);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};
EOL

# Create routes/exampleRoutes.js
mkdir -p routes
cat <<EOL > routes/exampleRoutes.js
const express = require('express');
const router = express.Router();
const exampleController = require('../controllers/exampleController');

router.get('/', exampleController.getExamples);
router.post('/', exampleController.createExample);

module.exports = router;
EOL

# Create server.js
cat <<EOL > server.js
const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./config/db');

// Load environment variables
dotenv.config();

// Connect to MongoDB
connectDB();

const app = express();

// Middleware to parse JSON
app.use(express.json());

// Routes
app.use('/api/examples', require('./routes/exampleRoutes'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
EOL

# Update package.json scripts
npx json -I -f package.json -e 'this.scripts={
  "start": "node server.js",
  "dev": "nodemon server.js"
}'

echo "Directory structure and files created successfully."
