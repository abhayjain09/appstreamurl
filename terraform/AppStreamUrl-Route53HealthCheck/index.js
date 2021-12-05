const aws = require('aws-sdk');
const util = require('util');
exports.handler = async (event) => {
    var region = aws.config.region;
    var message,response;    
    var injectFailure = false;
    if (process.env.InjectFailure)
        injectFailure = (process.env.InjectFailure.toLowerCase() == 'true');

    if(!injectFailure){
        message = util.format("AppStreamUrl Route53 health check lambda saying Hello from region %s", region)
        console.log(message);
        response = {
            statusCode: 200,
            body: JSON.stringify(message),
        };
    }else{        

        var message = "I am asked to become a tea pot";
        console.log(message);        
        response = {
            statusCode: 418,
            body: JSON.stringify(message),
        };
    }

    return response;
};