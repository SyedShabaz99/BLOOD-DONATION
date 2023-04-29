CREATE DATABASE blooddonation;
USE blooddonation;
CREATE TABLE people(pid VARCHAR(10),fname VARCHAR(232),lname VARCHAR(200),age INT,gender VARCHAR(10),PRIMARY KEY(pid));
INSERT INTO people(pid,fname,lname,age,gender) VALUES("p1","tom","scott",25,"M"),
("p2","derek","muller",25,"M"),
("p3","michael","stevens",20,"M"),
("p4","alex","mccolgan",29,"M"),
("p5","hank","green",35,"M"),
("p6","nice","peter",45,"M"),
("p7","epic","lloyd",55,"M"),
("p8","kyle","hill",50,"M"),
("p9","steve","mould",45,"M"),
("p10","arvin","ash",23,"M"),
("p11","jared","owen",24,"M"),
("p12","steve","taylor",36,"M"),
("p13","james","orgill",65,"M"),
("p14","grady","hillhouse",47,"M"),
("p15","diana","cowern",38,"F");
ALTER TABLE people ADD CHECK (age>18 AND age<75);
SELECT * FROM people;



-- personal_details
CREATE TABLE personal_details(pdid VARCHAR(10),pid VARCHAR(10),FOREIGN KEY(pid) REFERENCES 
people(pid),phone_number VARCHAR(20),email_id VARCHAR(35));
INSERT INTO personal_details(pdid,pid,phone_number,email_id) VALUES("pd1","p1","9182000000","m@gmail.com"),
("pd2","p2","9182000000","m@gmail.com"),
("pd3","p3","9182000000","m@gmail.com"),
("pd4","p4","9182000000","m@gmail.com"),
("pd5","p5","9182000000","m@gmail.com"),
("pd6","p6","9182000000","m@gmail.com"),
("pd7","p7","9182000000","m@gmail.com"),
("pd8","p8","9182000000","m@gmail.com"),
("pd9","p9","9182000000","m@gmail.com"),
("pd10","p10","9182000000","m@gmail.com"),
("pd11","p11","9182000000","m@gmail.com"),
("pd12","p12","9182000000","m@gmail.com"),
("pd13","p13","9182000000","m@gmail.com"),
("pd14","p14","9182000000","m@gmail.com"),
("pd15","p15","9182000000","m@gmail.com");
SELECT * FROM personal_details;



-- donor table
CREATE TABLE donor(pid VARCHAR(10),blood_type VARCHAR(232),weight_in_kg FLOAT,height_in_cm FLOAT,PRIMARY KEY(pid));
INSERT INTO donor(pid,blood_type,weight_in_kg,height_in_cm) VALUES("p1","O+",65,175),
("p2","O-",55,170),
("p4","A+",75,171),
("p6","B+",85,172),
("p8","AB+",95,173),
("p10","AB-",58,174),
("p14","B-",68,176),
("p12","A-",78,177);
SELECT * FROM donor;




-- patient table
CREATE TABLE patient(pid VARCHAR(10),blood_type VARCHAR(232),need_status VARCHAR(10),weight_in_kg FLOAT,PRIMARY KEY(pid));
INSERT INTO patient(pid,blood_type,need_status,weight_in_kg) VALUES("p3","O+","low",60),
("p5","O-","high",70),
("p7","A+","low",80),
("p9","B+","low",90),
("p11","AB+","low",100);
SELECT * FROM patient;



-- doctor table
CREATE TABLE doctor(pid VARCHAR(10),years_of_experience INT, number_of_transfusions INT,PRIMARY KEY(pid));
INSERT INTO doctor(pid,years_of_experience,number_of_transfusions) VALUES("p13",5,5000),("p15",2,1500);
SELECT * FROM doctor;


-- pre-exam table
CREATE TABLE pre_exam(peid VARCHAR(10),hemoglobin_gDL DECIMAL(5,2),temperature_in_F DECIMAL(5,2),blood_pressure VARCHAR(20),pulse_rate_BPM INT,PRIMARY KEY(peid));
INSERT INTO pre_exam(peid,hemoglobin_gDL,temperature_in_F,blood_pressure,pulse_rate_BPM) VALUES("pe1",15.2,98.6,"120/80",70),
("pe2",15.2,98.6,"120/90",71),
("pe3",15.1,98.1,"120/90",72),
("pe4",15.2,98.2,"120/90",73),
("pe5",15.3,98.3,"120/90",74),
("pe6",15.4,98.4,"120/90",75),
("pe7",15.5,98.5,"120/90",76),
("pe8",15.6,98.6,"120/80",77),
("pe9",15.6,98.7,"120/80",78),
("pe10",15.2,98.8,"160/80",79),
("pe11",15.7,98.9,"150/80",80),
("pe12",15.8,99,"140/80",81),
("pe13",15.9,98.6,"130/80",82),
("pe14",15.0,98.6,"130/80",83),
("pe15",15.9,98.6,"130/80",84);
SELECT * FROM pre_exam;


-- donation table
CREATE TABLE donation(did VARCHAR(10),pid VARCHAR(10),FOREIGN KEY(pid) REFERENCES donor(pid),peid VARCHAR(10),
FOREIGN KEY(peid) REFERENCES pre_exam(peid),doctor_id VARCHAR(10),FOREIGN KEY(doctor_id) REFERENCES people(pid),
amount_donated_CC DECIMAL(5,2),donation_type VARCHAR(20),PRIMARY KEY(did));
INSERT INTO donation(did,pid,peid,doctor_id,amount_donated_CC,donation_type) VALUES("d1","p4","pe1","p13",946,"plasma"),
("d2","p1","pe2","p13",473,"blood"),
("d3","p2","pe3","p13",473,"blood"),
("d4","p4","pe4","p15",946,"plasma"),
("d5","p6","pe5","p13",946,"platelets"),
("d6","p8","pe6","p13",473,"platelets"),
("d7","p10","pe7","p15",946,"blood"),
("d8","p12","pe8","p15",473,"plasma"),
("d9","p14","pe9","p15",946,"platelets"),
("d10","p10","pe10","p15",473,"blood");
SELECT * FROM donation;


-- transfusion table
CREATE TABLE transfusion(tid VARCHAR(10),pid VARCHAR(10) REFERENCES donor(pid),peid VARCHAR(10),
FOREIGN KEY(peid) REFERENCES pre_exam(peid),doctors_id VARCHAR(10),FOREIGN KEY(doctors_id) REFERENCES people(pid),amount_received_CC DECIMAL(5,2),PRIMARY KEY(tid));
INSERT INTO transfusion(tid,pid,peid,doctors_id,amount_received_CC) VALUES("t1","p3","pe11","p13",946),
("t2","p5","pe12","p15",946),
("t3","p7","pe13","p13",946),
("t4","p9","pe14","p15",946),
("t5","p11","pe15","p13",946);
SELECT * FROM transfusion;
DROP TABLE transfusion;



-- bloodbags
CREATE TABLE bloodbags(bbid VARCHAR(10),quantity_CC DECIMAL(5,2),blood_type VARCHAR(20),donation_type VARCHAR(20),PRIMARY KEY(bbid));
INSERT INTO bloodbags(bbid,quantity_CC,blood_type,donation_type) VALUES("bb1",473,"O+","blood"),
("bb2",473,"O+","blood"),
("bb3",473,"O-","plasma"),
("bb4",473,"O-","blood"),
("bb5",473,"A+","blood"),
("bb6",473,"A+","platelets"),
("bb7",473,"A+","blood"),
("bb8",473,"O+","platelets"),
("bb9",473,"A-","blood"),
("bb10",473,"B+","plasma"),
("bb11",473,"B+","plasma"),
("bb12",473,"B-","blood"),
("bb13",473,"AB+","blood"),
("bb14",473,"AB+","plasma"),
("bb15",473,"AB-","platelets");
SELECT * FROM bloodbags;



-- locations
CREATE TABLE locations(lid VARCHAR(10),hospital_name VARCHAR(100),city VARCHAR(20),PRIMARY KEY(lid));
INSERT INTO locations(lid,hospital_name,city) VALUES("L1","manipal hospitals","bengaluru"),
("L2","aiims hospital","delhi");
SELECT * FROM locations;


-- inventory
CREATE TABLE inventory(bbid VARCHAR(20) REFERENCES bloodbags(bbid),lid VARCHAR(20),FOREIGN KEY(lid) REFERENCES locations(lid),availability VARCHAR(20),PRIMARY KEY(bbid,lid));
INSERT INTO inventory(bbid,lid,availability) VALUES("bb1","L1","true"),
("bb2","L1","true"),
("bb3","L1","false"),
("bb4","L1","false"),
("bb5","L1","false"),
("bb6","L2","true"),
("bb7","L2","true"),
("bb8","L2","true"),
("bb9","L2","true"),
("bb10","L2","false");
SELECT * FROM inventory;


-- requests table
CREATE TABLE requests(rid VARCHAR(10),lid VARCHAR(10),FOREIGN KEY(lid) REFERENCES locations(lid),
requested_blood_type VARCHAR(10),requested_date DATE,quantity_requested_in_pints INT,PRIMARY KEY(rid));
INSERT INTO requests(rid,lid,requested_blood_type,requested_date,quantity_requested_in_pints) 
VALUES("r1","L1","A+","2020-03-23",1),
("r2","L1","O+","2020-03-23",1),
("r3","L1","AB+","2020-03-23",2),
("r4","L2","A-","2020-03-23",3),
("r5","L2","AB-","2020-03-23",1),
("r6","L2","B-","2020-03-23",1);
SELECT * FROM requests;

-- donation records
CREATE TABLE donation_records(did VARCHAR(50),FOREIGN KEY(did) REFERENCES donation(did),lid VARCHAR(20),
FOREIGN KEY(lid) REFERENCES locations(lid),donation_date DATE,bbid VARCHAR(10),FOREIGN KEY(bbid) REFERENCES bloodbags(bbid),PRIMARY KEY(did));
INSERT INTO donation_records(did,lid,donation_date,bbid) VALUES("d1","L1","2020-03-20","bb3"),
("d2","L1","2020-03-20","bb1"),
("d3","L1","2020-03-20","bb2"),
("d4","L1","2020-03-20","bb4"),
("d5","L1","2020-03-20","bb5"),
("d6","L2","2020-03-20","bb6"),
("d7","L2","2020-03-20","bb7"),
("d8","L2","2020-03-20","bb8"),
("d9","L2","2020-03-20","bb8"),
("d10","L2","2020-03-20","bb9");
SELECT * FROM donation_records;


-- transusion records
CREATE TABLE transfusion_records(tid VARCHAR(50),FOREIGN KEY(tid) REFERENCES transfusion(tid),lid VARCHAR(20),
FOREIGN KEY(lid) REFERENCES locations(lid),transfusion_date DATE,bbid VARCHAR(10),FOREIGN KEY(bbid) REFERENCES bloodbags(bbid),PRIMARY KEY(tid));
INSERT INTO transfusion_records(tid,lid,transfusion_date,bbid) VALUES("t1","L1","2020-04-23","bb1"),
("t2","L2","2020-04-23","bb7"),
("t3","L2","2020-04-23","bb8"),
("t4","L1","2020-04-23","bb5"),
("t5","L1","2020-04-23","bb4");
SELECT * FROM transfusion_records;


-- Queries
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- Q1) Display the details of all donors ?
SELECT CONCAT(fname," ",lname) AS donor_name,age,blood_type,height_in_cm,weight_in_kg,gender 
FROM people JOIN donor ON people.pid = donor.pid;
-- Q2) Display the details of all patients ?
SELECT CONCAT(fname," ",lname) AS patient_name,age,blood_type,weight_in_kg,gender 
FROM people JOIN patient ON people.pid = patient.pid; 
-- Q3) Display the details of all doctors ?
SELECT CONCAT(fname," ",lname) AS doctor_name,age,years_of_experience,number_of_transfusions,gender 
FROM people JOIN doctor ON people.pid = doctor.pid; 
-- Q4) Display the details of patients who need blood immediately ?
SELECT CONCAT(fname," ",lname) AS patient_name,age,blood_type,weight_in_kg,gender FROM people 
JOIN patient ON people.pid = patient.pid WHERE need_status = "high"; 
-- Q5) Display the details of donors required before donation i.e pre_exam results?
SELECT CONCAT(fname," ",lname) AS donor_name,hemoglobin_gDL,temperature_in_F,blood_pressure,pulse_rate_BPM 
FROM donation JOIN pre_exam ON donation.peid = pre_exam.peid 
JOIN people ON people.pid=donation.pid; 
-- Q6) Display the details of patients required before transfusion i.e pre_exam results?
SELECT CONCAT(fname," ",lname) AS recepient_name,hemoglobin_gDL,temperature_in_F,blood_pressure,pulse_rate_BPM 
FROM transfusion JOIN pre_exam ON transfusion.peid = pre_exam.peid 
JOIN people ON people.pid=transfusion.pid; 
-- Q7) Display the full name of donors along with their bloog group,amount donated,donation type and name of doctor who extracted blood ?
SELECT CONCAT(people.fname," ",people.lname) AS donor_name,amount_donated_CC,donation_type,blood_type,CONCAT(p.fname," ",p.lname) AS doctor_name 
FROM donation JOIN people ON people.pid = donation.pid 
JOIN donor ON donor.pid=people.pid 
JOIN people AS p ON p.pid=donation.doctor_id; 
-- Q8) Display the full name of recepients along with their blood type,amount received and name of doctor who did the transfusion ?
SELECT CONCAT(people.fname," ",people.lname) AS recepient_name,amount_received_CC,blood_type,CONCAT(p.fname," ",p.lname) AS doctor_name 
FROM transfusion JOIN people ON people.pid = transfusion.pid 
JOIN patient ON patient.pid=people.pid 
JOIN people AS p ON p.pid=transfusion.doctors_id; 
-- Q9)  if availability is true then how much blood of a specific type is available at a particular location ?
SELECT blood_type,quantity_CC * COUNT(blood_type) AS total_quantity_available,hospital_name,city,availability 
FROM inventory JOIN locations ON inventory.lid=locations.lid 
JOIN bloodbags ON bloodbags.bbid=inventory.bbid 
 WHERE availability="true" GROUP BY blood_type;
-- Q10) display who requested a specific blood type along with the requested quantity and date ?
SELECT rid,requested_blood_type,requested_date,quantity_requested_in_pints,hospital_name AS requested_by,city 
FROM requests JOIN locations ON requests.lid=locations.lid;
-- Q11) dispaly the details of donors with recent donation dates and next safe date for donation ?
SELECT CONCAT(fname," ",lname) AS donor_name,donation_date,DATE_ADD(donation_date, INTERVAL + 4 MONTH) AS next_safe_date 
FROM donation JOIN donation_records ON donation.did = donation_records.did 
JOIN people ON people.pid=donation.pid;
-- Q12) display total times a donor has donated and the total amount in CC order by the total amount in descending order ?
SELECT p.pid,concat(p.fname,p.lname) as donor_name,COUNT(d.pid) AS times_donated,SUM(d.amount_donated_CC) AS totalAmount 
FROM people p JOIN donation d ON p.pid=d.pid 
GROUP BY p.pid ORDER BY totalAmount DESC;
-- Q13) display details of all donations and where they donated ?
SELECT CONCAT(fname," ",lname) AS donor_name,amount_donated_CC,donation_date,hospital_name,city,blood_type 
FROM donation JOIN donation_records ON donation_records.did=donation.did 
JOIN people ON people.pid=donation.pid 
JOIN locations ON locations.lid=donation_records.lid 
JOIN bloodbags ON donation_records.bbid=bloodbags.bbid;
-- Q14) display details of all transfusions and where they receieved ?
SELECT CONCAT(fname," ",lname) AS recepient_name,amount_received_CC,transfusion_date,hospital_name,city,blood_type 
FROM transfusion JOIN transfusion_records ON transfusion_records.tid=transfusion.tid 
JOIN people ON people.pid=transfusion.pid 
JOIN locations ON locations.lid=transfusion_records.lid 
JOIN bloodbags ON transfusion_records.bbid=bloodbags.bbid;




