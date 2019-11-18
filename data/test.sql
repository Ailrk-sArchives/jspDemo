use db_Lab7;

/* SELECT ordersummary.orderId, orderDate, ordersummary.customerId, firstName, lastName, totalAmount */
/* FROM ordersummary, customer */
/* where ordersummary.customerId = customer.customerId; */

select orderId, productId, quantity, price
from orderproduct;
