
# SchoolDB Project

This project sets up a PostgreSQL database for managing information about schools and kindergartens, their classes, students (children), and parents. The project includes installation, data modeling, data anonymization, and backup/restore validation.

---

## Installation & Initialization

### 1. Install PostgreSQL
1.0-install-postgres.sh


### 2. Enter PostgreSQL Console as `postgres` User
1.1-enter-postgres-as-postgres-user.sh


### 3. Create Database `SchoolDB` and connect to it
1.2-create-connect-SchoolDB.sql

---

## Create Schema & Insert Data

### 4. Create Tables
1.3-create-tables.sql

### 5. Insert Realistic Sample Data
1.4-fill-in-tables-with-realistic.data.sql

---

## Queries & Screenshots

### 6. Query: Children with Institutions and Class Directions
1.5-query-1.sql
1.6-screenshot-1.png

### 7. Query: Parents and their Children with Tuition Fee
1.7-query-2.sql
1.8-screenshot-2.png

### 8. Query: Institutions with Student Count
1.9-query-3.sql
1.A-screenshot-3.png

---

## Backup & Restore

### 9. Perform Backup and Restore
1.B-backup-resore-SchoolDB.sh

### 10. Run Check Script
1.C-data-chek.sql
1.D-data-check-screenshot.png

---

##  Data Anonymization

### 11. Anonymize Data
2.1-anonymyze.sql

### 12. View Anonymization Results
2.2-result-screenshot.png

---

## Files Structure Summary

- `.sh` files — Shell scripts for setup/backup.
- `.sql` files — SQL for schema, insertions, queries, anonymization.
- `.png` — Screenshot evidence for each step.

---

## 📌 Author
Prepared on: 2025-04-25
By: Andrii Fil (IT Administrator, DevOps trainee)

