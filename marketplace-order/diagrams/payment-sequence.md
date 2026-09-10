# Payment Sequence

1. Customer initiates payment for the order.
2. Order Service sends a payment request to Payment Service with an `Idempotency-Key`.
3. Payment Service processes the payment.
4. On success, Payment Service produces `PaymentSucceeded`.
5. The event is delivered through Kafka to Order Service.
6. Order Service checks `event_id` in `processed_events`.
7. If the event is new, Order Service changes the order status to `PAID` and records the event in the same transaction.
8. If the event was already processed, Order Service performs no duplicate business operation and acknowledges the event.

Important: a missing synchronous response does not prove that payment failed.
