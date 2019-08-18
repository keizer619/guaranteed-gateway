import ballerina/http;
import ballerina/log;

service backend on new http:Listener(9090) {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/store"
    }
    resource function store(http:Caller caller, http:Request req) {
    var payload = req.getTextPayload();
        http:Response res = new;
        if (payload is string) {
            log:printInfo(payload.toString());
        } 

        var result = caller->respond(res);
        if (result is error) {
           log:printError("Error in responding", result);
        }
    }
}
