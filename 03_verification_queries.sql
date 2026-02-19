
-- Description: Verification and sample queries
--              Run AFTER 01_create_tables.sql and 02_insert_data.sql


USE big3_construction;


-- TASK 2.3: DATA COMPLETENESS CHECK


SELECT 'Projects'             AS entity, COUNT(*) AS total FROM projects
UNION ALL
SELECT 'Clients',               COUNT(*) FROM clients
UNION ALL
SELECT 'Supervisors',           COUNT(*) FROM supervisors
UNION ALL
SELECT 'Workers',               COUNT(*) FROM workers
UNION ALL
SELECT 'Worker Skills',         COUNT(*) FROM worker_skills
UNION ALL
SELECT 'Worker Certifications', COUNT(*) FROM worker_certifications
UNION ALL
SELECT 'Project Workers',       COUNT(*) FROM project_workers
UNION ALL
SELECT 'Suppliers',             COUNT(*) FROM suppliers
UNION ALL
SELECT 'Supplier Phones',       COUNT(*) FROM supplier_phones
UNION ALL
SELECT 'Materials',             COUNT(*) FROM materials
UNION ALL
SELECT 'Project Supplier Materials', COUNT(*) FROM project_supplier_materials
UNION ALL
SELECT 'Equipment',             COUNT(*) FROM equipment
UNION ALL
SELECT 'Project Equipment',     COUNT(*) FROM project_equipment;



-- TASK 2.4: SAMPLE QUERIES DEMONSTRATING NORMALIZATION BENEFITS



-- Query 1: Update a supplier's city in ONE place
--          In the old spreadsheet, this would require
--           updating every row that mentioned that supplier

UPDATE suppliers
SET supplier_city = 'Cambridge'
WHERE supplier_name = 'BuildPro Supplies';

-- Verify the update
SELECT supplier_name, supplier_city
FROM suppliers
WHERE supplier_name = 'BuildPro Supplies';

-- Revert for consistency
UPDATE suppliers SET supplier_city = 'Boston' WHERE supplier_name = 'BuildPro Supplies';



-- Query 2: Full project report — joining all major tables
--          Name, client, supervisor, city, type, dates

SELECT
    p.project_id,
    p.project_name,
    p.project_type,
    p.site_city,
    p.site_state,
    p.start_date,
    p.end_date,
    c.client_name,
    s.supervisor_name
FROM projects p
JOIN clients     c ON p.client_id     = c.client_id
JOIN supervisors s ON p.supervisor_id = s.supervisor_id
ORDER BY p.project_id;



-- Query 3: All workers on each project with their skills
--          In the old spreadsheet, skills were pipe-separated
--           and impossible to query cleanly

SELECT
    p.project_id,
    p.project_name,
    w.worker_name,
    w.hourly_rate,
    ws.skill
FROM projects       p
JOIN project_workers pw ON p.project_id  = pw.project_id
JOIN workers         w  ON pw.worker_id  = w.worker_id
JOIN worker_skills   ws ON w.worker_id   = ws.worker_id
ORDER BY p.project_id, w.worker_name, ws.skill;



-- Query 4: Find ALL projects that use Concrete
--          In the old spreadsheet, you'd have to search
--           through comma-separated values manually

SELECT DISTINCT
    p.project_id,
    p.project_name,
    p.site_city,
    m.material_name,
    psm.unit_cost
FROM projects                  p
JOIN project_supplier_materials psm ON p.project_id   = psm.project_id
JOIN materials                  m   ON psm.material_id = m.material_id
WHERE m.material_name = 'Concrete'
ORDER BY p.project_id;



-- Query 5: Total rental cost per project
--          Demonstrates aggregation across normalized tables

SELECT
    p.project_id,
    p.project_name,
    SUM(pe.rental_cost) AS total_equipment_rental_cost
FROM projects        p
JOIN project_equipment pe ON p.project_id = pe.project_id
GROUP BY p.project_id, p.project_name
ORDER BY total_equipment_rental_cost DESC;



-- Query 6: Workers who hold OSHA certification
--          Easy with normalized certifications table

SELECT
    w.worker_name,
    w.hourly_rate,
    wc.certification
FROM workers              w
JOIN worker_certifications wc ON w.worker_id = wc.worker_id
WHERE wc.certification = 'OSHA'
ORDER BY w.worker_name;



-- Query 7: Number of projects per client
--          No duplication — each project stored once

SELECT
    c.client_name,
    COUNT(p.project_id) AS number_of_projects
FROM clients  c
JOIN projects p ON c.client_id = p.client_id
GROUP BY c.client_name
ORDER BY number_of_projects DESC;


