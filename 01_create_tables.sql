
-- Description: Creates all normalized tables (5NF design)

CREATE DATABASE IF NOT EXISTS big3_construction;
USE big3_construction;


-- 1. CLIENTS
CREATE TABLE clients (
    client_id   INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL UNIQUE,
    client_phone VARCHAR(20)  NOT NULL,
    client_email VARCHAR(100),
    client_city  VARCHAR(50),
    CONSTRAINT chk_client_phone CHECK (client_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);


-- 2. SUPERVISORS
CREATE TABLE supervisors (
    supervisor_id   INT AUTO_INCREMENT PRIMARY KEY,
    supervisor_name VARCHAR(100) NOT NULL UNIQUE,
    supervisor_phone VARCHAR(20) NOT NULL,
    CONSTRAINT chk_sup_phone CHECK (supervisor_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$')
);


-- 3. PROJECTS
CREATE TABLE projects (
    project_id   VARCHAR(10)  PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    project_type VARCHAR(50)  NOT NULL,
    start_date   DATE         NOT NULL,
    end_date     DATE         NOT NULL,
    site_address VARCHAR(200) NOT NULL,
    site_city    VARCHAR(50)  NOT NULL,
    site_state   CHAR(2)      NOT NULL,
    client_id    INT          NOT NULL,
    supervisor_id INT         NOT NULL,
    CONSTRAINT chk_project_id   CHECK (project_id LIKE 'P%'),
    CONSTRAINT chk_project_dates CHECK (end_date > start_date),
    CONSTRAINT fk_project_client     FOREIGN KEY (client_id)     REFERENCES clients(client_id),
    CONSTRAINT fk_project_supervisor FOREIGN KEY (supervisor_id) REFERENCES supervisors(supervisor_id)
);


-- 4. WORKERS
CREATE TABLE workers (
    worker_id   INT AUTO_INCREMENT PRIMARY KEY,
    worker_name VARCHAR(100) NOT NULL UNIQUE,
    worker_phone VARCHAR(20) NOT NULL,
    hourly_rate  DECIMAL(8,2) NOT NULL,
    CONSTRAINT chk_worker_phone CHECK (worker_phone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
    CONSTRAINT chk_hourly_rate  CHECK (hourly_rate > 0)
);


-- 5. WORKER SKILLS  4NF: independent multi-valued fact
CREATE TABLE worker_skills (
    worker_id INT          NOT NULL,
    skill     VARCHAR(100) NOT NULL,
    PRIMARY KEY (worker_id, skill),
    CONSTRAINT fk_ws_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
);


-- 6. WORKER CERTIFICATIONS  4NF: independent multi-valued fact
CREATE TABLE worker_certifications (
    worker_id       INT          NOT NULL,
    certification   VARCHAR(100) NOT NULL,
    PRIMARY KEY (worker_id, certification),
    CONSTRAINT fk_wc_worker FOREIGN KEY (worker_id) REFERENCES workers(worker_id)
);


-- 7. PROJECT WORKERS  which workers are assigned to which project

CREATE TABLE project_workers (
    project_id VARCHAR(10) NOT NULL,
    worker_id  INT         NOT NULL,
    PRIMARY KEY (project_id, worker_id),
    CONSTRAINT fk_pw_project FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_pw_worker  FOREIGN KEY (worker_id)  REFERENCES workers(worker_id)
);


-- 8. SUPPLIERS
CREATE TABLE suppliers (
    supplier_id   INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    supplier_city VARCHAR(50)  NOT NULL
);


-- 9. SUPPLIER PHONES  4NF: a supplier can have multiple phones
CREATE TABLE supplier_phones (
    supplier_id   INT         NOT NULL,
    phone_number  VARCHAR(20) NOT NULL,
    PRIMARY KEY (supplier_id, phone_number),
    CONSTRAINT chk_sup_ph CHECK (phone_number REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
    CONSTRAINT fk_sp_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);


-- 10. MATERIALS
CREATE TABLE materials (
    material_id   INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(100) NOT NULL UNIQUE
);


-- 11. PROJECT SUPPLIER MATERIALS
--     5NF: ternary relationship — project, supplier, material, unit cost
CREATE TABLE project_supplier_materials (
    project_id    VARCHAR(10)  NOT NULL,
    supplier_id   INT          NOT NULL,
    material_id   INT          NOT NULL,
    unit_cost     DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (project_id, supplier_id, material_id),
    CONSTRAINT chk_unit_cost CHECK (unit_cost > 0),
    CONSTRAINT fk_psm_project  FOREIGN KEY (project_id)  REFERENCES projects(project_id),
    CONSTRAINT fk_psm_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CONSTRAINT fk_psm_material FOREIGN KEY (material_id) REFERENCES materials(material_id)
);


-- 12. EQUIPMENT
CREATE TABLE equipment (
    equipment_id   INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(100) NOT NULL UNIQUE
);


-- 13. PROJECT EQUIPMENT
--     which equipment is used on which project, with rental cost

CREATE TABLE project_equipment (
    project_id    VARCHAR(10)   NOT NULL,
    equipment_id  INT           NOT NULL,
    rental_cost   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (project_id, equipment_id),
    CONSTRAINT chk_rental_cost CHECK (rental_cost > 0),
    CONSTRAINT fk_pe_project   FOREIGN KEY (project_id)   REFERENCES projects(project_id),
    CONSTRAINT fk_pe_equipment FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);


