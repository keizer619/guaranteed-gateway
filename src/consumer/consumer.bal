import ballerina/log;
import ballerina/nats;
import ballerina/http;
import ballerina/lang.'string as str;

nats:Connection conn = new("localhost:4222");

listener nats:StreamingListener lis = new(conn);

@nats:StreamingSubscriptionConfig {
    subject: "demo"
}
service demoService on lis {
    resource function onMessage(nats:StreamingMessage message) {
        http:Client clientEndpoint = new("http://localhost:9090/backend");
        http:Request req = new;
        string|error extractedMessage = str:fromBytes(message.getData());

        if(extractedMessage is string) {
            req.setPayload(<@untainted> extractedMessage);
            var response = clientEndpoint->post("/store", req);
        }

        
        
    }

    resource function onError(nats:StreamingMessage message, nats:Error errorVal) {
        error e = errorVal;
        log:printError("Error occurred: ", err = e);
    }
}

