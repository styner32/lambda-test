const square = require('./square.js');

exports.handler = function(event, context) {
  var resp = {message: 'hello'};
  console.log('hello');
  Object.assign(resp, context.clientContext);
  resp.square = square(10);
  context.done(null, resp);
};
