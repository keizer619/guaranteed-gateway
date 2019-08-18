import ballerina/io;
import ballerina/log;
import ballerina/nats;
import ballerina/http;

service gateway on new http:Listener(9091) {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/hello"
    }
    resource function hello(http:Caller caller, http:Request req) {
    var payload = req.getTextPayload();
        http:Response res = new;
        if (payload is string) {
            string message = "";
            string subject = "demo";

            nats:Connection conn = new("nats://localhost:4222");

            nats:StreamingProducer publisher = new(conn);

            var result = publisher->publish(subject, <@untainted> payload);
            if (result is nats:Error) {
                error e = result;
                log:printError("Error occurred while closing the connection", err = e);
            } else {
                log:printInfo("GUID " + result + " received for the produced message.");
            }
        } else {
            res.statusCode = 500;
            res.setPayload(<@untainted> <string>payload.detail()?.message);
        }

        var result = caller->respond(res);
        if (result is error) {
           log:printError("Error in responding", result);
        }
    }
}