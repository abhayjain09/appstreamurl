const AWS = require('aws-sdk');
const appstream = new AWS.AppStream;
exports.handler = (event, context, callback) => {
console.log('event',event);
console.log('context',context);
console.log('callback',callback);
    if (!event.requestContext.authorizer) {
        errorResponse('Authorization not configured', context.awsRequestId, callback);
        return;
    }

var params = {
   FleetName:'examplecorp-fleet-001',
   StackName:'examplecorp-stack-001',
   UserId: 'abhay09jain@gmail.com',
   Validity: 5
};

createas2streamingurl(params,context.awsRequestId,callback);
};
function errorResponse(errorMessage, awsRequestId, callback) {
    callback(null, {
      statusCode: 500,
      body: JSON.stringify({
        Error: errorMessage,
        Reference: awsRequestId,
      }),
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    });
  }
function createas2streamingurl(params,awsRequestId,callback){
    var request = appstream.createStreamingURL(params);
    request.
    on('success', function(response) {
        console.log('Success! AS2 Streaming URL created.');
        console.log('params,awsRequestId,callback',params,awsRequestId,callback);
        var output = response.data;
        var url = output.StreamingURL;
        console.log('url, output', url, output)
        callback(null, {
            statusCode: 201,
            body: JSON.stringify({
                Url: url,
                Reference: awsRequestId,
            }),
            headers: {
                'Access-Control-Allow-Origin': '*',
            },
        });
      }).
    on('error', function(response) {
      console.log('Error! ' + JSON.stringify(response.data));
      errorResponse('Error creating AS2 streaming URL.', awsRequestId, callback);
    }).
    send();
}