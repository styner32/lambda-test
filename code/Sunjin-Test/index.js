var AWS = require('aws-sdk');
var dynamodb = new AWS.DynamoDB();

exports.handler = function(event, context, callback) {
  var username;
  if (context.clientContext) {
    username = context.clientContext.username;
  }

  if (event) {
    console.log(event);
  }

  dynamodb.scan({
    "TableName": "Sunjin-Todos"
    }, function(err, data) {
      if (err) {
        callback(err);
      } else {
        var i, todo;
        var result = {
          "username": username,
          "todos": []
        };

        if (data.Items instanceof Array) {
          for ( i = 0; i < data.Items.length; i++ ) {
            todo = data.Items[i];
            result.todos.push({
              "id": todo.ID.S,
              "title": todo.Title.S,
              "completed": todo.Completed.BOOL
            });
          }
        }

        callback(null, result);
    }
  });
};
