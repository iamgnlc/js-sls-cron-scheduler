const fetch = require('node-fetch');

module.exports = async (endpoint) => {
  try {
    const response = await fetch(endpoint);
    return response.json();
  } catch (error) {
    return { error };
  }
};
