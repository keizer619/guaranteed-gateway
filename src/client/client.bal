import ballerina/log;
import ballerina/http;

public function main() {
        http:Client clientEndpoint = new("http://localhost:9091/gateway/hello");
        http:Request req = new;
        req.setPayload("tharik");
        var response = clientEndpoint->post("/post", req);
        
        if (response is http:Response) {
            var msg = response.getJsonPayload();
            if (msg is json) {
                log:printInfo(msg.toString());
            } else {
                log:printInfo("error");
            }
        }
}
