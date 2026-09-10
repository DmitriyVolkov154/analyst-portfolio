# Kafka Payment Flow

Payment Service -> PaymentSucceeded -> Kafka -> Order Service

## Recovery scenario

If Order Service is temporarily unavailable, events remain in Kafka until the consumer recovers. After recovery, Order Service processes the backlog.

## Duplicate scenario

Kafka may deliver an event more than once. `event_id` and `processed_events` are used to prevent repeated business effects.

## Atomic processing

The order status update and insertion into `processed_events` are committed in one transaction.
