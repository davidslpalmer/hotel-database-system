# Hotel Management Database System

## 📌 Project Overview
This project encompasses the full life-cycle design and implementation of a relational database for a hotel chain. The project was developed in three iterative stages: Conceptual Design, Logical Design, and Physical Implementation. 

The purpose of the database is to manage daily hotel operations, including room bookings, guest management, employee roles, room services, and invoicing.

---

## 🏗️ System Architecture & Design Phases

### Stage 1: Conceptual Design
Based on the business domain requirements, a conceptual model was designed using Entity-Relationship Diagram (ERD) syntax. The model maps out the core business entities and their relationships:
* **Core Entities:** Hotel, Room, RoomType, Guest, Booking, Employee, Role, City, Service, Invoice/Payment, and PayMethod.
* **Relationships & Junction Tables:** Handled complex many-to-many relationships such as `Guest_Booking`, `Room_Booking`, and `Room_Service`.
* *Deliverable:* Complete ER-Diagram (`01-Conceptual-Design/ER-Diagram.pdf`).

### Stage 2: Logical Design
The conceptual ERD was translated into formal relational schemas. To ensure data integrity and minimize redundancy, all schemas were normalized to satisfy the **First, Second, and Third Normal Forms (1NF, 2NF, 3NF)**.
* *Example Schema:* `Booking (BookingID (PK), GuestID (FK), HotelID (FK), Check-inDate, Check-OutDate, BookingType, Discount)`.
* *Deliverable:* Normalized Relational Schemas (`02-Logical-Design/Relational-Schemas.pdf`).

### Stage 3: Physical Implementation
The logical schemas were instantiated into a physical **SQLite** database. Test data was generated and inserted to simulate a real-world hotel environment.
* **SQL Queries:** 10 advanced SQL queries were developed to extract analytical and operational data, such as:
  * Calculating total service costs for specific booking types (using `JOIN` and `SUM`).
  * Finding the average room cost per room type and payment method.
  * Identifying the hotel with the highest average room cost using `HAVING` and aggregate functions.
* *Deliverables:* SQLite Database file and SQL Query scripts (`03-Physical-Implementation/hotel_database.db` & `SQL-Queries.sql`).

---

## 🛠️ Technologies Used
* **Conceptual Modeling:** ERD (Entity-Relationship Diagrams)
* **Database Management System (DBMS):** SQLite
* **Query Language:** SQL

---
*Project developed by Adam Larsson, David Palmér, and Filip Sundberg*