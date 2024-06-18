// In config/webpack/environment.js
const { environment } = require('@rails/webpacker');

// Example of setting an entry point explicitly
environment.entry = {
  application: './app/javascript/packs/application.js'
};

module.exports = environment;
