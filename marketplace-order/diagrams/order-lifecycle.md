# Order Lifecycle

CREATED -> RESERVED -> PAID -> IN_DELIVERY -> DELIVERED -> RECEIVED

Alternative terminal state: RESERVED -> CANCELLED.

After PAID, cancellation starts a refund process.

Important distinction:
- DELIVERED = order physically delivered to pickup point or address.
- RECEIVED = customer actually received/picked up the order.
