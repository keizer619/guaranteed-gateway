import ballerina/http;

public function main() {
        http:Client clientEndpoint = new("http://localhost:9091/gateway/");
        http:Request req = new;
        req.setPayload("tharik");
        var response = clientEndpoint->post("/hello", req);
}
