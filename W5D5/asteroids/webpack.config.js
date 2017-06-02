var path = require("path");

module.exports = {
  entry: "./asteroids.js",

  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: "bundle.js"
  }
};
