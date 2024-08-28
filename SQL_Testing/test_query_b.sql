DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS service_records;

-- Create the vehicles table
CREATE TABLE vehicles (
    vehicle_id TEXT PRIMARY KEY,
    vehicle_nickname TEXT,
    make TEXT,
    model TEXT,
    type TEXT,
    vin TEXT,
    year INT,
    current_mileage INT,
    current_hours INT
);

-- Create the services table
CREATE TABLE services (
    service_id TEXT PRIMARY KEY,
    vehicle_id TEXT,
    service_name TEXT,
    months_between_service INT,
    miles_between_service INT,
    hours_between_service INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);

-- Create the parts table
CREATE TABLE parts (
    part_id TEXT PRIMARY KEY,
    service_id TEXT,
    vehicle_id TEXT,
    part_number TEXT,
    quantity INT,
    part_description TEXT,
    part_hyperlink TEXT,
    FOREIGN KEY (service_id) REFERENCES services (service_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);

-- Create the service_records table
CREATE TABLE service_records (
    service_record_id TEXT PRIMARY KEY,
    service_id TEXT,
    vehicle_id TEXT,
    service_date DATE,
    service_mileage INT,
    service_hours INT,
    FOREIGN KEY (service_id) REFERENCES services (service_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);

-- Populate the vehicles table
INSERT INTO vehicles (vehicle_id, vehicle_nickname, make, model, type, vin, year, current_mileage, current_hours) 
VALUES 
('JD6220', 'The Tractor', 'John Deere', '6220', 'Tractor', 'AB12', 2000, 12000, NULL),
('CAT906M', 'The Loader', 'Cat', '906M', 'Loader', '5', 2021, NULL, 8000),
('JD7200', 'The Big Tractor', 'John Deere', '7200', 'Tractor', 'CD34', 2010, 16000, NULL),
('CAT924K', 'The Wheel Loader', 'Cat', '924K', 'Loader', '9', 2015, NULL, 9000);

-- Populate the services table
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
VALUES 
('JD6220_OilChange', 'JD6220', 'Oil Change', NULL, 5000, NULL),
('CAT906M_AirFilterChange', 'CAT906M', 'Air Filter Change', NULL, NULL, 2000),
('JD7200_OilChange', 'JD7200', 'Oil Change', NULL, 5000, NULL),
('CAT924K_OilChange', 'CAT924K', 'Oil Change', NULL, NULL, 4000);

-- Populate the service_records table
INSERT INTO service_records (service_record_id, service_id, vehicle_id, service_date, service_mileage, service_hours) 
VALUES 
('JD6220_OilChange_1', 'JD6220_OilChange', 'JD6220', NULL, 7000, NULL),
('CAT906M_AirFilterChange_1', 'CAT906M_AirFilterChange', 'CAT906M', NULL, NULL, 6000),
('JD7200_OilChange_1', 'JD7200_OilChange', 'JD7200', NULL, 11000, NULL),
('CAT924K_OilChange_1', 'CAT924K_OilChange', 'CAT924K', NULL, NULL, 5000);

SELECT v.vehicle_id, s.service_name, 
       CASE 
           WHEN s.months_between_service IS NOT NULL 
               THEN 'Overdue by ' || CAST(((strftime('%Y', 'now') - strftime('%Y', sr.service_date)) * 12 + strftime('%m', 'now') - strftime('%m', sr.service_date)) - s.months_between_service AS TEXT) || ' months'
           WHEN s.miles_between_service IS NOT NULL 
               THEN 'Overdue by ' || CAST(v.current_mileage - sr.service_mileage - s.miles_between_service AS TEXT) || ' miles'
           WHEN s.hours_between_service IS NOT NULL 
               THEN 'Overdue by ' || CAST(v.current_hours - sr.service_hours - s.hours_between_service AS TEXT) || ' hours'
       END AS overdue_by
FROM vehicles v
JOIN services s ON v.vehicle_id = s.vehicle_id
LEFT JOIN (
    SELECT service_id, vehicle_id, MAX(service_date) AS service_date, MAX(service_mileage) AS service_mileage, MAX(service_hours) AS service_hours
    FROM service_records
    GROUP BY service_id, vehicle_id
) sr ON s.service_id = sr.service_id AND v.vehicle_id = sr.vehicle_id
WHERE (s.months_between_service IS NOT NULL AND ((strftime('%Y', 'now') - strftime('%Y', sr.service_date)) * 12 + strftime('%m', 'now') - strftime('%m', sr.service_date)) > s.months_between_service)
   OR (s.miles_between_service IS NOT NULL AND v.current_mileage - sr.service_mileage > s.miles_between_service)
   OR (s.hours_between_service IS NOT NULL AND v.current_hours - sr.service_hours > s.hours_between_service);