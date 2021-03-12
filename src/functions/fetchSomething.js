'use strict';

const fetchResult = require('../utils/fetchResult.js');
const logger = require('../utils/logger.js');

const endpoint = process.env.ENDPOINT;

module.exports.run = async (_event, context) => {
  const result = await fetchResult(endpoint);

  logger(context.functionName, result);

  return;
};
