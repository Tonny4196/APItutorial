const pugLoader = require("./config/webpack/loaders/pug.js");

module.exports = {
  module: {
    rules: [pugLoader],
  },
};
