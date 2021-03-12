require('colors');

module.exports = (functionName, result = null, showTimestamp = false) => {
  let log = [];

  if (showTimestamp) {
    const timestamp = new Date().toISOString();
    log.push(timestamp);
  }

  log = log.concat([functionName.brightCyan, result]);

  console.log(...log);
};
