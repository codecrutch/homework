var path = require("path");

module.exports = {
  context: __dirname,
  entry: "./lib/main.js",
  output: {
    path: path.join(__dirname, 'lib'),
    filename: "jquery_lite.js",
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  },
  devtool: 'source-maps',
};
