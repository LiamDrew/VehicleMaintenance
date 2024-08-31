/*
 * Model of WBF vehicle maintenance database
 * Author: Liam Drew 
 * 2/21/2024
*/

DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS service_records;

-- NOTE: I'm getting rid of the autoincrementing primary key in order to make the queries more readable
--       Below is what it looked like before.
-- CREATE TABLE vehicles (vehicle_id INTEGER PRIMARY KEY AUTOINCREMENT, make TEXT, model TEXT, type text, vin TEXT, year INT);

/*
+---------------------------------------------------------------------------------+
|                                      vehicles                                   |
+---------------------------------------------------------------------------------+
| vehicle_id | make | model | type | vin | year | current_mileage | current_hours |
+---------------------------------------------------------------------------------+
*/
CREATE TABLE vehicles (vehicle_id TEXT, make TEXT, model TEXT, type TEXT, vin TEXT, year INT, current_mileage INT, current_hours INT);

-- Current hours 5100
INSERT INTO vehicles (vehicle_id, make, model, type, vin, year, current_mileage, current_hours) VALUES ('JD6220', 'John Deere', '6220', 'Tractor', 'AB12', 2000, NULL, 5100);

-- Current hours 4500
-- Current miles 3200
INSERT INTO vehicles (vehicle_id, make, model, type, vin, year, current_mileage, current_hours) VALUES ('CAT906M', 'Cat', '906M', 'Loader', '5', 2021, 3200, 3000);


-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('CAT930G', 'Cat', '930G', 'Loader', '5', 1990);
-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('CATidk', 'Cat', 'idk', 'Excavator', '5', 1990);
-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('JD2555','John Deere', '2555', 'Tractor', 'AC23', 1970);
-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('JD2355', 'John Deere', '2355', 'Tractor', '523J', 1975);
-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('JD2350', 'John Deere', '23509', 'Tractor', 'ABMLK4', 1990);
-- INSERT INTO vehicles (vehicle_id, make, model, type, vin, year) VALUES ('JD4250', 'John Deere', '4250', 'Tractor', 'ABM4', 1990);



-- NOTE: I know it is redundant to store the same information in the service_id and the vehicle_id, but it makes things easier to read
--       Also, only one of the three service interval columns will be used.
/*
+--------------------------------------------------------------------------------------------------------+
|                                 services                                                              |
+--------------------------------------------------------------------------------------------------------+
| service_id | vehicle_id | service_name | recommended_months_between_service | recommended_miles_between_service | recommended_hours_between_service |
+--------------------------------------------------------------------------------------------------------+
*/
CREATE TABLE services (service_id TEXT, vehicle_id TEXT, service_name TEXT, months_between_service INT, miles_between_service INT, hours_between_service INT);

-- John Deere 6220 
-------------------------------------------------------------------------------------------------------------------------------------
-- Every 250 Hours if conditions are not met, and every 500 hours if conditions are met
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Oil_Change_JD6220',  'JD6220', 'Oil_Change', 12, NULL, 500);

-- Hydraulic fluid and transmission fluid change
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220',  'JD6220', 'Hydraulic_And_Transmission_Oil_Change', NULL, NULL, 750);

-- Carbon filter change
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Carbon_Filter_Change_JD6220', 'JD6220', 'Carbon_Filter_Change', 12, NULL, 500);

-- Cabin Air filters
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Cab_Air_Filters_Change_JD6220', 'JD6220', 'Cab_Air_Filters_Change', 24, NULL, 1500);


-- Fuel filters
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', 'Fuel_Filters_Change', NULL, NULL, 500);

-- Replace Engine Air Filters
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Engine_Air_Filters_Change_JD6220', 'JD6220', 'Engine_Air_Filters_Change', 24, NULL, 1500);

-- Clean Air Filters
INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Clean_Engine_And_Cab_Air_Filters_JD6220', 'JD6220', 'Clean_Engine_And_Cab_Air_Filters', NULL, NULL, 500);


-- now for the loader

INSERT INTO services (service_id, vehicle_id, service_name, months_between_service, miles_between_service, hours_between_service) 
    VALUES ('Oil_Change_CAT906M', 'CAT906M', 'Oil_Change', NULL, NULL, 500);

/*
-- NOTE: I made part number a text field to support alphanumeric part numbers
+--------------------------------------------------------------------------------------------------------+
|                                 parts                                                                  |
+--------------------------------------------------------------------------------------------------------+
| part_id | service_id | vehicle_id | part_number | part_description | part_hyperlink |
+--------------------------------------------------------------------------------------------------------+
*/
CREATE TABLE parts (part_id INTEGER PRIMARY KEY AUTOINCREMENT, service_id TEXT, vehicle_id TEXT, part_number TEXT, quantity TEXT, part_description TEXT, part_hyperlink TEXT);

-- John Deere 6220 
-------------------------------------------------------------------------------------------------------------------------------------
--Motor Oil and Filter Change
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Oil_Change_JD6220', 'JD6220', 'RE504836', '1', 'Oil Filter','https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Oil_Change_JD6220', 'JD6220', '12345678', '4.2 Gallons (16L)', 'Plus-50', 'https://www.google.com/');

-- Hydraulic and Transmission Oil and Filters Change
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220', 'JD6220', 'AR69444', '13.2 Gal (50L)', 'Hy-Gard Transmission Oil','https://shop.deere.com/us/product/AR69444%3A-Transmission-and-Hydraulic-Oil%2C-Hy-Gard%E2%84%A2%2C-18-9-Liter-(5-Gallon)/p/AR69444');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220', 'JD6220', 'AL118036', '1', 'Hydraulic Oil Filter', 'https://shop.deere.com/us/product/AL156625%3A-Hydraulic-Oil-Filter/p/AL156625');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220', 'JD6220', 'AL156625', '1', 'Transmission Oil Filter', 'https://shop.deere.com/us/product/AL156625%3A-Hydraulic-Oil-Filter/p/AL156625');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220', 'JD6220', 'AL203061', '1', 'Hydraulic Filter Element', 'https://shop.deere.com/us/product/AL156625%3A-Hydraulic-Oil-Filter/p/AL156625');

-- Carbon Filter Change
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Carbon_Filter_Change_JD6220', 'JD6220', 'AL158986', '1', 'Carbon Filter', 'https://www.google.com/');

-- Cab Air Filter Change
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Cab_Air_Filters_Change_JD6220', 'JD6220', 'AL177184', '2', 'Standard Air Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Cab_Air_Filters_Change_JD6220', 'JD6220', 'AL155288', '2', 'Recirculation Air Filter', 'https://www.google.com/');

-- Fuel Filter Service
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', 'AL153517', '1', 'Inline Fuel Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', 'RE62419', '1', 'Fuel Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', 'RE509031', '1', 'Final Fuel Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', 'RE509208', '1', 'Primary Fuel Filter', 'https://www.google.com/');

-- Engine Air Filter Service
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Engine_Air_Filters_Change_JD6220', 'JD6220', 'AL172780', '1', 'Primary Air Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) 
    VALUES ('Engine_Air_Filters_Change_JD6220', 'JD6220', 'AL153517', '1', 'Secondary Air Filter', 'https://www.google.com/');



-- Cat 906M
-------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) VALUES ('Oil_Change_CAT906M', 'CAT906M', '90832149', '1', 'Oil Filter', 'https://www.google.com/');
INSERT INTO parts (service_id, vehicle_id, part_number, quantity, part_description, part_hyperlink) VALUES ('Oil_Change_CAT906M', 'CAT906M', '132492140', '15 Gallons', '10w-40 Oil', 'https://www.google.com/');

/*
+--------------------------------------------------------------------------------------------------------+
|                                 service_records                                                        |
+--------------------------------------------------------------------------------------------------------+
| service_record_id | service_id | vehicle_id | service_date | service_mileage | service_hours |
+--------------------------------------------------------------------------------------------------------+
*/
CREATE TABLE service_records(service_record_id INTEGER PRIMARY KEY AUTOINCREMENT, service_id TEXT, vehicle_id TEXT, service_date DATE, service_mileage INT, service_hours INT);

-- John Deere 6220 
-------------------------------------------------------------------------------------------------------------------------------------
-- Oil Changes
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Oil_Change_JD6220', 'JD6220', '2024-02-01', NULL, 4500);
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Oil_Change_JD6220', 'JD6220', '2023-08-18', NULL, 4100);

-- Hydraulic and Transmission Oil Changes
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Hydraulic_And_Transmission_Oil_Change_JD6220', 'JD6220', '2023-02-05', NULL, 4200);

-- Carbon Filter Change
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Carbon_Filter_Change_JD6220', 'JD6220', '2023-02-06', NULL, 4700);

-- Fuel Filter Change
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Fuel_Filters_Change_JD6220', 'JD6220', '2023-07-06', NULL, 4300);

-- Replace Engine Air Filters
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Engine_Air_Filters_Change_JD6220', 'JD6220', '2023-07-06', NULL, 4300);

-- Clean Air Filters
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) 
    VALUES ('Clean_Engine_And_Cab_Air_Filters_JD6220', 'JD6220', '2023-07-06', NULL, 4300);


-- Cat 906M
-------------------------------------------------------------------------------------------------------------------------------------
-- Cat 906M Little Loader Oil Changes
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) VALUES ('Oil_Change_CAT906M', 'CAT906M', '2024-01-01', 2900, 2400);
INSERT INTO service_records(service_id, vehicle_id, service_date, service_mileage, service_hours) VALUES ('Oil_Change_CAT906M', 'CAT906M', '2023-04-07', 2200, 1900);


-- Queries


-- good query commented out for now.
-- SELECT 
--     v.vehicle_id, 
--     v.make, 
--     v.model,
--     s.service_name,
--     p.part_number,
--     p.quantity,
--     p.part_description,
--     p.part_hyperlink,
--     CASE
--         WHEN (julianday('now') - julianday(COALESCE(sr.last_service_date, '1900-01-01'))) > s.months_between_service * 30 THEN 'Date (' || CAST((julianday('now') - julianday(COALESCE(sr.last_service_date, '1900-01-01'))) - (s.months_between_service * 30) AS INT) || ' days overdue)'
--         WHEN (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service THEN 'Mileage (' || ((v.current_mileage - COALESCE(sr.last_service_mileage, 0)) - s.miles_between_service) || ' miles overdue)'
--         WHEN (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service THEN 'Hours (' || ((v.current_hours - COALESCE(sr.last_service_hours, 0)) - s.hours_between_service) || ' hours overdue)'
--         ELSE 'Not due'
--     END AS Due_Based_On
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN (
--     SELECT service_id, vehicle_id, MAX(service_date) AS last_service_date, MAX(service_mileage) AS last_service_mileage, MAX(service_hours) AS last_service_hours
--     FROM service_records
--     GROUP BY service_id, vehicle_id
-- ) sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- LEFT JOIN parts p ON s.service_id = p.service_id AND s.vehicle_id = p.vehicle_id
-- WHERE
--     (julianday('now') - julianday(COALESCE(sr.last_service_date, '1900-01-01'))) > s.months_between_service * 30
--     OR (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service
--     OR (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service
-- ORDER BY v.vehicle_id, s.service_name, p.part_number;


--bunch of garbage below:


-- SELECT * FROM vehicles

-- Finds vehicles due for service:
-- SELECT DISTINCT v.vehicle_id, v.make, v.model
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN (
--     SELECT service_id, vehicle_id, MAX(service_date) AS last_service_date, MAX(service_mileage) AS last_service_mileage, MAX(service_hours) AS last_service_hours
--     FROM service_records
--     GROUP BY service_id, vehicle_id
-- ) sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- WHERE
--     (strftime('%m', 'now') + (strftime('%Y', 'now') - strftime('%Y', sr.last_service_date)) * 12 - strftime('%m', sr.last_service_date)) > s.months_between_service
--     OR (v.current_mileage - sr.last_service_mileage) > s.miles_between_service
--     OR (v.current_hours - sr.last_service_hours) > s.hours_between_service;

-- Finds the services due for each vehicle due for service:
-- SELECT 
--     v.vehicle_id, 
--     v.make, 
--     v.model,
--     s.service_name,
--     CASE
--         WHEN (strftime('%m', 'now') + (strftime('%Y', 'now') - strftime('%Y', IFNULL(sr.last_service_date, '1900-01-01'))) * 12 - strftime('%m', IFNULL(sr.last_service_date, '1900-01-01'))) > s.months_between_service THEN 'Date'
--         WHEN (v.current_mileage - IFNULL(sr.last_service_mileage,0)) > s.miles_between_service THEN 'Mileage'
--         WHEN (v.current_hours - IFNULL(sr.last_service_hours,0)) > s.hours_between_service THEN 'Hours'
--         ELSE 'Unknown'
--     END AS Due_Based_On
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN (
--     SELECT service_id, vehicle_id, MAX(service_date) AS last_service_date, MAX(service_mileage) AS last_service_mileage, MAX(service_hours) AS last_service_hours
--     FROM service_records
--     GROUP BY service_id, vehicle_id
-- ) sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- WHERE
--     (strftime('%m', 'now') + (strftime('%Y', 'now') - strftime('%Y', IFNULL(sr.last_service_date, '1900-01-01'))) * 12 - strftime('%m', IFNULL(sr.last_service_date, '1900-01-01'))) > s.months_between_service
--     OR (v.current_mileage - IFNULL(sr.last_service_mileage,0)) > s.miles_between_service
--     OR (v.current_hours - IFNULL(sr.last_service_hours,0)) > s.hours_between_service
-- ORDER BY v.vehicle_id, s.service_name;

-- SELECT 
--     v.vehicle_id, 
--     v.make, 
--     v.model,
--     s.service_name,
--     p.part_number,
--     p.quantity,
--     p.part_description,
--     p.part_hyperlink,
--     CASE
--         WHEN (strftime('%Y', 'now') - strftime('%Y', COALESCE(sr.last_service_date, '1900-01-01'))) * 12 + strftime('%m', 'now') - strftime('%m', COALESCE(sr.last_service_date, '1900-01-01')) > s.months_between_service THEN 'Date'
--         WHEN (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service THEN 'Mileage'
--         WHEN (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service THEN 'Hours'
--         ELSE 'Not due'
--     END AS Due_Based_On
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN (
--     SELECT service_id, vehicle_id, MAX(service_date) AS last_service_date, MAX(service_mileage) AS last_service_mileage, MAX(service_hours) AS last_service_hours
--     FROM service_records
--     GROUP BY service_id, vehicle_id
-- ) sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- LEFT JOIN parts p ON s.service_id = p.service_id AND s.vehicle_id = p.vehicle_id
-- WHERE
--     (strftime('%Y', 'now') - strftime('%Y', COALESCE(sr.last_service_date, '1900-01-01'))) * 12 + strftime('%m', 'now') - strftime('%m', COALESCE(sr.last_service_date, '1900-01-01')) > s.months_between_service
--     OR (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service
--     OR (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service
-- ORDER BY v.vehicle_id, s.service_name, p.part_number;

-- THIS ONE WORKS:
-- SELECT 
--     v.vehicle_id, 
--     v.make, 
--     v.model,
--     s.service_name,
--     p.part_number,
--     p.quantity,
--     p.part_description,
--     p.part_hyperlink,
--     CASE
--         WHEN (strftime('%Y', 'now') - strftime('%Y', COALESCE(sr.last_service_date, '1900-01-01'))) * 12 + strftime('%m', 'now') - strftime('%m', COALESCE(sr.last_service_date, '1900-01-01')) > s.months_between_service
--             THEN 'Date' || ' (' || ((strftime('%Y', 'now') - strftime('%Y', COALESCE(sr.last_service_date, '1900-01-01'))) * 12 + strftime('%m', 'now') - strftime('%m', COALESCE(sr.last_service_date, '1900-01-01')) - s.months_between_service) || ' months overdue)'
--         WHEN (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service
--             THEN 'Mileage' || ' (' || (v.current_mileage - COALESCE(sr.last_service_mileage, 0) - s.miles_between_service) || ' miles overdue)'
--         WHEN (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service
--             THEN 'Hours' || ' (' || (v.current_hours - COALESCE(sr.last_service_hours, 0) - s.hours_between_service) || ' hours overdue)'
--         ELSE 'Not due'
--     END AS Due_Based_On
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN (
--     SELECT service_id, vehicle_id, MAX(service_date) AS last_service_date, MAX(service_mileage) AS last_service_mileage, MAX(service_hours) AS last_service_hours
--     FROM service_records
--     GROUP BY service_id, vehicle_id
-- ) sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- LEFT JOIN parts p ON s.service_id = p.service_id AND s.vehicle_id = p.vehicle_id
-- WHERE
--     (strftime('%Y', 'now') - strftime('%Y', COALESCE(sr.last_service_date, '1900-01-01'))) * 12 + strftime('%m', 'now') - strftime('%m', COALESCE(sr.last_service_date, '1900-01-01')) > s.months_between_service
--     OR (v.current_mileage - COALESCE(sr.last_service_mileage, 0)) > s.miles_between_service
--     OR (v.current_hours - COALESCE(sr.last_service_hours, 0)) > s.hours_between_service
-- ORDER BY v.vehicle_id, s.service_name, p.part_number;


-- SELECT 
--     v.vehicle_id, 
--     v.make, 
--     v.model,
--     s.service_name,
--     p.part_number,
--     p.quantity,
--     p.part_description,
--     p.part_hyperlink,
--     CASE
--         WHEN (strftime('%m', 'now') + (strftime('%Y', 'now') - strftime('%Y', IFNULL(sr.last_service_date, '1900-01-01'))) * 12 - strftime('%m', IFNULL(sr.last_service_date, '1900-01-01'))) > s.months_between_service THEN 'Date'
--         WHEN (v.current_mileage - IFNULL(sr.last_service_mileage,0)) > s.miles_between_service THEN 'Mileage'
--         WHEN (v.current_hours - IFNULL(sr.last_service_hours,0)) > s.hours_between_service THEN 'Hours'
--         ELSE 'Unknown'
--     END AS Due_Based_On
-- FROM vehicles v
-- JOIN services s ON v.vehicle_id = s.vehicle_id
-- LEFT JOIN service_records sr ON s.service_id = sr.service_id AND s.vehicle_id = sr.vehicle_id
-- LEFT JOIN parts p ON s.service_id = p.service_id AND s.vehicle_id = p.vehicle_id
-- WHERE
--     (strftime('%m', 'now') + (strftime('%Y', 'now') - strftime('%Y', IFNULL(sr.last_service_date, '1900-01-01'))) * 12 - strftime('%m', IFNULL(sr.last_service_date, '1900-01-01'))) > s.months_between_service
--     OR (v.current_mileage - IFNULL(sr.last_service_mileage,0)) > s.miles_between_service
--     OR (v.current_hours - IFNULL(sr.last_service_hours,0)) > s.hours_between_service
-- GROUP BY v.vehicle_id, s.service_name, p.part_id
-- ORDER BY v.vehicle_id, s.service_name, p.part_number;