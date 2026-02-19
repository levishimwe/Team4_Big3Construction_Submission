
--  Populates all tables with data from the original Big3 Construction spreadsheet.
--  Run AFTER 01_create_tables.sql

USE big3_construction;


-- 1. CLIENTS  4 unique clients
INSERT INTO clients (client_name, client_phone, client_email, client_city) VALUES
    ('Metro Corp',       '617-555-1000', 'contact@metrocorp.com',        'Boston'),
    ('City Transit Auth','617-555-1100', 'info@cta.gov',                 'Boston'),
    ('Retail Ventures',  '401-555-1200', 'contact@retailventures.com',   'Providence'),
    ('FutureTech Ltd',   '212-555-1300', 'admin@futuretech.com',         'New York');


-- 2. SUPERVISORS  (3 unique supervisors)
INSERT INTO supervisors (supervisor_name, supervisor_phone) VALUES
    ('John Carter', '617-555-2000'),
    ('Sarah Lee',   '617-555-2100'),
    ('David Kim',   '401-555-2200');


-- 3. PROJECTS  7 projects
-- client_id:     1=Metro Corp, 2=City Transit Auth, 3=Retail Ventures, 4=FutureTech Ltd
-- supervisor_id: 1=John Carter, 2=Sarah Lee, 3=David Kim
INSERT INTO projects (project_id, project_name, project_type, start_date, end_date,
                      site_address, site_city, site_state, client_id, supervisor_id) VALUES
    ('P001', 'Downtown Plaza',        'Commercial',    '2024-01-10', '2024-08-20', '123 Main St',        'Boston',      'MA', 1, 1),
    ('P002', 'Harbor Bridge',         'Infrastructure','2024-02-01', '2025-01-30', '78 Harbor Rd',       'Boston',      'MA', 2, 2),
    ('P003', 'Riverside Apartments',  'Residential',   '2024-03-15', '2024-11-15', '45 River Dr',        'Providence',  'RI', 3, 3),
    ('P004', 'Green Tech Campus',     'Commercial',    '2024-04-01', '2025-02-28', '900 Innovation Way', 'New York',    'NY', 4, 1),
    ('P005', 'Sunset Mall Expansion', 'Commercial',    '2024-05-10', '2024-12-20', '300 Sunset Blvd',   'Los Angeles', 'CA', 1, 2),
    ('P006', 'Lakeside Villas',       'Residential',   '2024-06-01', '2024-12-01', '88 Lakeview Rd',    'Orlando',     'FL', 3, 3),
    ('P007', 'Airport Terminal Upgrade','Infrastructure','2024-07-15','2025-06-30', '1 Airport Way',     'Chicago',     'IL', 2, 2);


-- 4. WORKERS  (5 unique workers)
INSERT INTO workers (worker_name, worker_phone, hourly_rate) VALUES
    ('Mike Ross',      '617-555-3001', 45.00),
    ('Rachel Zane',    '617-555-3002', 50.00),
    ('Harvey Specter', '617-555-3003', 70.00),
    ('Tom Hardy',      '617-555-3004', 48.00),
    ('Louis Litt',     '617-555-3005', 55.00);


-- 5. WORKER SKILLS
-- worker_id: 1=Mike Ross, 2=Rachel Zane, 3=Harvey Specter, 4=Tom Hardy, 5=Louis Litt

INSERT INTO worker_skills (worker_id, skill) VALUES
    -- Mike Ross
    (1, 'Carpentry'),
    (1, 'Framing'),
    (1, 'Concrete'),
    -- Rachel Zane
    (2, 'Electrical'),
    (2, 'Wiring'),
    (2, 'Inspection'),
    -- Harvey Specter
    (3, 'Project Management'),
    (3, 'Planning'),
    (3, 'Management'),
    -- Tom Hardy
    (4, 'Welding'),
    (4, 'Steel Fixing'),
    (4, 'Carpentry'),
    (4, 'Concrete'),
    -- Louis Litt
    (5, 'Accounting'),
    (5, 'Procurement');


-- 6. WORKER CERTIFICATIONS
INSERT INTO worker_certifications (worker_id, certification) VALUES
    -- Mike Ross
    (1, 'OSHA'),
    (1, 'First Aid'),
    -- Rachel Zane
    (2, 'OSHA'),
    (2, 'Electrical License'),
    (2, 'First Aid'),
    -- Harvey Specter
    (3, 'PMP'),
    (3, 'OSHA'),
    -- Tom Hardy
    (4, 'OSHA'),
    (4, 'Welding Cert'),
    -- Louis Litt
    (5, 'MBA'),
    (5, 'First Aid'),
    (5, 'OSHA');


-- 7. PROJECT WORKERS  worker assignments per project

INSERT INTO project_workers (project_id, worker_id) VALUES
    -- P001: Mike Ross, Rachel Zane, Harvey Specter
    ('P001', 1),
    ('P001', 2),
    ('P001', 3),
    -- P002: Mike Ross, Tom Hardy
    ('P002', 1),
    ('P002', 4),
    -- P003: Rachel Zane, Tom Hardy
    ('P003', 2),
    ('P003', 4),
    -- P004: Mike Ross, Louis Litt
    ('P004', 1),
    ('P004', 5),
    -- P005: Harvey Specter, Rachel Zane
    ('P005', 3),
    ('P005', 2),
    -- P006: Tom Hardy, Mike Ross
    ('P006', 4),
    ('P006', 1),
    -- P007: Louis Litt, Harvey Specter
    ('P007', 5),
    ('P007', 3);


-- 8. SUPPLIERS  (6 unique suppliers)

INSERT INTO suppliers (supplier_name, supplier_city) VALUES
    ('BuildPro Supplies',  'Boston'),
    ('SteelWorks Inc',     'Chicago'),
    ('Oceanic Materials',  'Miami'),
    ('Global Glass Co',    'Seattle'),
    ('Pacific Materials',  'San Diego'),
    ('Southern Concrete',  'Atlanta');

-- 9. SUPPLIER PHONES
-- supplier_id: 1=BuildPro, 2=SteelWorks, 3=Oceanic, 4=Global Glass, 5=Pacific, 6=Southern

INSERT INTO supplier_phones (supplier_id, phone_number) VALUES
    (1, '617-555-9000'),
    (1, '617-555-9001'),
    (2, '312-555-8000'),
    (2, '312-555-8001'),
    (3, '305-555-7000'),
    (4, '206-555-6000'),
    (5, '619-555-6500'),
    (6, '404-555-6600');


-- 10. MATERIALS
INSERT INTO materials (material_name) VALUES
    ('Concrete'),
    ('Steel'),
    ('Steel Beams'),
    ('Rebar'),
    ('Bricks'),
    ('Cement'),
    ('Glass Panels'),
    ('Tiles');


-- 11. PROJECT SUPPLIER MATERIALS
-- supplier_id: 1=BuildPro, 2=SteelWorks, 3=Oceanic, 4=Global Glass, 5=Pacific, 6=Southern
-- material_id: 1=Concrete, 2=Steel, 3=Steel Beams, 4=Rebar, 5=Bricks, 6=Cement, 7=Glass Panels, 8=Tiles

INSERT INTO project_supplier_materials (project_id, supplier_id, material_id, unit_cost) VALUES
    -- P001: BuildPro -> Concrete ($120), Steel ($300)
    ('P001', 1, 1, 120.00),
    ('P001', 1, 2, 300.00),
    -- P001: SteelWorks -> Steel Beams ($500)
    ('P001', 2, 3, 500.00),
    -- P002: Oceanic -> Rebar ($200), Concrete ($110)
    ('P002', 3, 4, 200.00),
    ('P002', 3, 1, 110.00),
    -- P003: BuildPro -> Bricks ($2), Cement ($15)
    ('P003', 1, 5, 2.00),
    ('P003', 1, 6, 15.00),
    -- P004: SteelWorks -> Steel Beams ($500), Glass Panels ($250)
    ('P004', 2, 3, 500.00),
    ('P004', 2, 7, 250.00),
    -- P004: Global Glass -> Glass Panels ($250)
    ('P004', 4, 7, 250.00),
    -- P005: Pacific -> Concrete ($130), Tiles ($20)
    ('P005', 5, 1, 130.00),
    ('P005', 5, 8, 20.00),
    -- P006: Southern Concrete -> Concrete ($115)
    ('P006', 6, 1, 115.00),
    -- P007: SteelWorks -> Steel Beams ($520), Concrete ($140)
    ('P007', 2, 3, 520.00),
    ('P007', 2, 1, 140.00),
    -- P007: Oceanic -> Rebar ($210)
    ('P007', 3, 4, 210.00);


-- 12. EQUIPMENT

INSERT INTO equipment (equipment_name) VALUES
    ('Crane'),
    ('Bulldozer'),
    ('Excavator'),
    ('Mixer'),
    ('Forklift'),
    ('Lift');


-- 13. PROJECT EQUIPMENT
-- equipment_id: 1=Crane, 2=Bulldozer, 3=Excavator, 4=Mixer, 5=Forklift, 6=Lift

INSERT INTO project_equipment (project_id, equipment_id, rental_cost) VALUES
    -- P001: Crane ($5000), Bulldozer ($3000)
    ('P001', 1, 5000.00),
    ('P001', 2, 3000.00),
    -- P002: Excavator ($4000), Crane ($5500)
    ('P002', 3, 4000.00),
    ('P002', 1, 5500.00),
    -- P003: Mixer ($800), Forklift ($1200)
    ('P003', 4, 800.00),
    ('P003', 5, 1200.00),
    -- P004: Crane ($6000), Lift ($2000)
    ('P004', 1, 6000.00),
    ('P004', 6, 2000.00),
    -- P005: Bulldozer ($3200), Mixer ($1000)
    ('P005', 2, 3200.00),
    ('P005', 4, 1000.00),
    -- P006: Mixer ($900)
    ('P006', 4, 900.00),
    -- P007: Crane ($6500), Excavator ($4200)
    ('P007', 1, 6500.00),
    ('P007', 3, 4200.00);


