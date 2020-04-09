package sparkexample;

import static spark.Spark.get;
import datadog.trace.api.Trace;

public class Hello {

    @Trace(operationName = "hello", resourceName = "root")
    public static void main(String[] args) {
        get("/", (req, res) -> {
            return "hello from sparkjava.com";
        });
    }

}