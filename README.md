# Big3 Construction Company — Database Project

**Team:** Team4 
**Date:** February 19, 2025  

---

## How to Run in DBeaver

### Step 1 — Open DBeaver and connect to your MySQL server

### Step 2 — Run the SQL files in order

Open each file in DBeaver and click the **Execute Script** button (or press `Ctrl+Alt+X`):

1. `01_create_tables.sql` — Creates the database and all tables
2. `02_insert_data.sql` — Inserts all data from the original spreadsheet
3. `03_verification_queries.sql` — Runs verification and sample queries

>  Always run the files in this exact order. Running `02` before `01` will fail because the tables won't exist yet.

---

## Database Summary

| Table | Description |
|---|---|
| `clients` | 4 unique clients |
| `supervisors` | 3 supervisors |
| `projects` | 7 projects (P001–P007) |
| `workers` | 5 workers |
| `worker_skills` | Worker skills (atomic, normalized) |
| `worker_certifications` | Worker certifications (atomic, normalized) |
| `project_workers` | Assignment of workers to projects |
| `suppliers` | 6 suppliers |
| `supplier_phones` | Supplier phone numbers (one row per phone) |
| `materials` | 8 materials |
| `project_supplier_materials` | What each supplier provides to each project |
| `equipment` | 6 equipment types |
| `project_equipment` | Equipment used per project with rental cost |

---

## Normalization Summary

| Stage | Key Change |
|---|---|
| 1NF | Split all pipe-separated values (skills, phones, materials, equipment) into atomic rows |
| 2NF | Moved project info, client info, worker info into separate tables — removed partial dependencies |
| 3NF | Removed transitive dependencies (e.g., ClientCity → ClientName, not ProjectID) |
| BCNF | All determinants are candidate keys |
| 4NF | Separated independent multi-valued facts: worker_skills and worker_certifications are separate tables |
| 5NF | Decomposed ternary relationship (project + supplier + material) into project_supplier_materials |
