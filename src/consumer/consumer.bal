import ballerina/encoding;
import ballerina/log;
import ballerina/nats;
import ballerina/http;

nats:Connection conn = new("localhost:4222");

listener nats:StreamingListener lis = new(conn);

@nats:StreamingSubscriptionConfig {
    subject: "demo"
}
service demoService on lis {
    resource function onMessage(nats:StreamingMessage message) {
        http:Client clientEndpoint = new("http://localhost:9090/backend/store");
        http:Request req = new;

        string extractedMessage = encoding:byteArrayToString(message.getData());
        log:printInfo(extractedMessage);

        json payload = { message: extractedMessage };
        req.setPayload(payload);
        var response = clientEndpoint->post("/post", req);
        
        if (response is http:Response) {
            var msg = response.getJsonPayload();
            if (msg is error){
                log:printInfo(msg.toString());
            } else {
                log:printInfo(msg.toString());
            } 
        }
    }

    resource function onError(nats:StreamingMessage message, nats:Error errorVal) {
        error e = errorVal;
        log:printError("Error occurred: ", err = e);
    }
}

