-- CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT);

-- INSERT INTO users (name, email) VALUES ('John Doe', 'john.doe@example.com');

DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS vehicle_services;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS service_parts;
DROP TABLE IF EXISTS vehicle_services_vehicles;

CREATE TABLE vehicles (make TEXT, model TEXT, type text, vin TEXT, year INT);

INSERT INTO vehicles (make, model, type, vin, year) VALUES ('John Deere', '6220', 'Tractor', '1234', 2000);
INSERT INTO vehicles (make, model, type, vin, year) VALUES ('Cat', '906M', 'Loader', '5', 2021);

CREATE TABLE vehicle_services (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id INT,
    service_type VARCHAR(255),
    last_service_date DATE,
    next_service_date DATE,
    due_date DATE
);

-- Create a table for parts used in services
CREATE TABLE parts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    part_number VARCHAR(255),
    description VARCHAR(255)
);

-- Create a table to link parts to services
CREATE TABLE service_parts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id INT,
    part_id INT
);

-- Create a table to link vehicles to services
CREATE TABLE vehicle_services_vehicles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id INT,
    service_id INT
);

INSERT INTO vehicle_services (vehicle_id, service_type, last_service_date, next_service_date, due_date) 
VALUES (1, 'Oil Change', '2020-01-01', '2020-07-01', '2020-07-01');

-- Insert data for John Deere oil filter part
INSERT INTO parts (part_number, description) 
VALUES ('123', 'Oil Filter');

-- Insert data for John Deere oil part
INSERT INTO parts (part_number, description) 
VALUES ('456', '5w-30 Oil');

-- Insert data for John Deere oil change service parts
INSERT INTO service_parts (service_id, part_id) 
VALUES (1, 1), (1, 2);

-- Insert data for John Deere oil change service vehicle
INSERT INTO vehicle_services_vehicles (vehicle_id, service_id) 
VALUES (1, 1);

-- Insert data for Cat oil change service
INSERT INTO vehicle_services (vehicle_id, service_type, last_service_date, next_service_date, due_date) 
VALUES (2, 'Oil Change', '2021-01-01', '2021-04-01', '2021-04-01');

-- Insert data for Cat oil filter part
INSERT INTO parts (part_number, description) 
VALUES ('789', 'Oil Filter');

-- Insert data for Cat oil part
INSERT INTO parts (part_number, description) 
VALUES ('999', '10w-40 Oil');

-- Insert data for Cat oil change service parts
INSERT INTO service_parts (service_id, part_id) 
VALUES (2, 3), (2, 4);

-- Insert data for Cat oil change service vehicle
INSERT INTO vehicle_services_vehicles (vehicle_id, service_id) 
VALUES (2, 2);

-- Query to see what vehicles are due for service
SELECT v.make, v.model, vs.service_type, vs.due_date 
FROM vehicles v 
JOIN vehicle_services_vehicles vsv ON v.id = vsv.vehicle_id 
JOIN vehicle_services vs ON vsv.service_id = vs.id
WHERE vs.due_date <= date('now');



-- SELECT * FROM vehicles;