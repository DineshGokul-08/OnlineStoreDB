# OnlineStoreDB

Online Store Database Project Overview

Online Store Database (OnlineStoreDB) is a database system designed to efficiently manage e-commerce-related information. This database helps track products, categories, customers, orders, and reviews, ensuring seamless operations and data retrieval. It supports functionalities such as adding products, updating stock levels, retrieving order details, and performing analysis with aggregate functions.


---

Database Setup

A structured relational database is created to store online store data. It includes tables for products, categories, customers, orders, and order details, ensuring efficient data management and retrieval.


---

Features

1. Product Management

The system allows users to add, update, and retrieve product details. Each product is linked to a specific category for better organization and searchability.

2. Customer Management

Customers' details, including names, contact information, and purchase history, are stored in a separate table. This enables tracking customer interactions and order history efficiently.

3. Order Management

The system keeps track of customer orders, ensuring that all purchases are properly recorded. Each order is linked to a customer and includes details about the purchased products.

4. Inventory Management

Stock levels are dynamically updated whenever a new order is placed. This ensures accurate tracking of available inventory and prevents overselling.

5. Advanced Queries

Various SQL queries enable users to fetch specific information, such as:

Listing orders along with customer names and order dates.

Displaying products purchased in each order.

Identifying the most popular products based on order frequency.

Aggregating data to count total sales per product and calculate total revenue per category.


6. Stored Procedures

Stored procedures automate complex tasks, such as fetching the total number of orders per customer, to streamline data retrieval and management.

7. Triggers

A trigger automatically updates product stock levels whenever a new order is placed. This ensures data consistency and prevents manual stock adjustments.


---

Sample Queries

Some of the key queries used in the system include:

Fetching all orders and their respective customers.

Listing products along with their categories.

Identifying top-selling products based on total sales.



---

View Creation

A database view is created to display the best-selling products, making it easier to retrieve specific data without running complex queries repeatedly.


---

Stored Procedure Execution

Stored procedures are used for automating repetitive tasks, such as counting total orders by customer, to improve efficiency.


---

Checking Available Procedures and Triggers

Users can retrieve a list of stored procedures and triggers to understand the automated processes running within the database.


---

Conclusion

OnlineStoreDB provides a well-structured approach to managing an e-commerce platform. It enables easy data retrieval, modification, and analysis through SQL queries, views, stored procedures, and triggers. The project demonstrates effective database normalization and relational data management for an online store application.


---
