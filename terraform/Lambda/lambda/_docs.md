## Observability
1. Enable X-ray for tracing using input parameter.
2. Throttles Alarm - This reports alarm whenever the lambda is being throttle. By default if more than 5% are throttle, then the alarm goes off. This can be changed by passing input parameter.
3. DeadLetterError Alarm -  For asynchronous invocation, the number of times Lambda attempts to send an event to a dead-letter queue but fails. This alarm gets set when there is any failure.