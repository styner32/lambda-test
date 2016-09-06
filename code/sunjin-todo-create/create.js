var AWS = require('aws-sdk');
var dynamodb = new AWS.DynamoDB();

exports.handler = function(event, context) {
  var tableName = "Sunjin-Todos";
  var todos = event["body-json"];
  var i, todo;
  var handleResponse = function(err) {
    if (err) {
      context.done('putting item into dynamodb failed: ' + err );
    } else {
      context.done(null, {updated: true});
    }
  };

  if ( todos instanceof Array ) {
    for ( i = 0; i < todos.length; ++i ) {
      todo = todos[i];

      dynamodb.putItem({
        "TableName": tableName,
        "Item" : {
          "ID": { "S": todo.id.toString() },
          "Title": { "S": todo.title },
          "Completed": {"BOOL": todo.completed }
        }
      }, handleResponse);
    }
  } else {
    context.done('todos is empty or invalid');
  }
};
