
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    dob DATE,
    gender CHAR(1),
    plan_type VARCHAR(30),
    county VARCHAR(50),
    enrollment_start DATE,
    enrollment_end DATE NULL,
    pcp_id VARCHAR(20)
);


-- inserting values

INSERT INTO Members
(member_id, member_name, dob, gender, plan_type, county, enrollment_start, enrollment_end, pcp_id)
VALUES
(1001,'John Smith','1985-04-12','M','Medicaid','Harris','2024-01-01',NULL,'PCP101'),
(1002,'Mary Johnson','1992-08-20','F','Medicaid','Fort Bend','2024-02-15',NULL,'PCP102'),
(1003,'David Lee','1978-11-05','M','CHIP','Harris','2024-01-10','2024-12-31','PCP103'),
(1004,'Priya Kumar','2001-03-18','F','Medicaid','Brazoria','2024-03-01',NULL,'PCP101'),
(1005,'Ahmed Khan','1969-07-22','M','Medicaid','Harris','2024-01-20',NULL,'PCP104'),
(1006,'Sophia Martin','1988-09-14','F','CHIP','Montgomery','2024-04-01',NULL,'PCP105'),
(1007,'Carlos Gomez','1995-12-30','M','Medicaid','Fort Bend','2024-01-05','2024-06-30','PCP102'),
(1008,'Emily Davis','1975-06-25','F','Medicaid','Harris','2024-02-01',NULL,'PCP101'),
(1009,'Michael Brown','1983-01-11','M','Commercial','Galveston','2024-01-15',NULL,'PCP106'),
(1010,'Jessica Wilson','1990-10-08','F','Commercial','Harris','2024-03-10',NULL,'PCP107'),
(1011,'Daniel Moore','1987-02-19','M','Medicaid','Montgomery','2024-01-12',NULL,'PCP103'),
(1012,'Olivia Taylor','1998-07-03','F','CHIP','Harris','2024-02-10',NULL,'PCP105'),
(1013,'Ethan Anderson','1972-09-17','M','Commercial','Brazoria','2024-01-22',NULL,'PCP108'),
(1014,'Isabella Thomas','1984-06-11','F','Medicaid','Fort Bend','2024-02-20',NULL,'PCP104'),
(1015,'Noah Jackson','1996-04-28','M','Commercial','Harris','2024-03-05',NULL,'PCP106'),
(1016,'Ava White','1979-12-01','F','Medicaid','Galveston','2024-01-08',NULL,'PCP107'),
(1017,'Liam Harris','1986-08-14','M','Commercial','Montgomery','2024-04-01',NULL,'PCP108'),
(1018,'Mia Clark','1993-05-30','F','CHIP','Harris','2024-03-12',NULL,'PCP105'),
(1019,'William Lewis','1968-10-09','M','Medicaid','Fort Bend','2024-01-03',NULL,'PCP102'),
(1020,'Charlotte Walker','1991-01-24','F','Commercial','Harris','2024-02-18',NULL,'PCP101'),
(1021,'Benjamin Hall','1982-03-16','M','Commercial','Brazoria','2024-01-17',NULL,'PCP106'),
(1022,'Amelia Allen','1997-09-07','F','CHIP','Montgomery','2024-03-20',NULL,'PCP103'),
(1023,'Lucas Young','1976-11-22','M','Medicaid','Harris','2024-02-01',NULL,'PCP104'),
(1024,'Harper King','1989-07-19','F','Commercial','Fort Bend','2024-02-15',NULL,'PCP108'),
(1025,'Henry Wright','1981-05-08','M','Medicaid','Galveston','2024-03-02',NULL,'PCP107'),
(1026,'Evelyn Scott','1994-02-13','F','Commercial','Harris','2024-01-29',NULL,'PCP101'),
(1027,'Alexander Green','1974-08-26','M','Medicaid','Montgomery','2024-01-11',NULL,'PCP105'),
(1028,'Abigail Baker','1999-12-18','F','CHIP','Brazoria','2024-04-04',NULL,'PCP102'),
(1029,'Matthew Adams','1980-10-31','M','Commercial','Harris','2024-02-06',NULL,'PCP106'),
(1030,'Ella Nelson','1995-03-04','F','Medicaid','Fort Bend','2024-01-26',NULL,'PCP104'),
(1031,'Joseph Carter','1988-06-15','M','Commercial','Harris','2024-02-12',NULL,'PCP107'),
(1032,'Grace Mitchell','1992-09-27','F','CHIP','Montgomery','2024-03-15',NULL,'PCP108'),
(1033,'Samuel Perez','1971-04-09','M','Medicaid','Harris','2024-01-18',NULL,'PCP103'),
(1034,'Chloe Roberts','1996-01-21','F','Commercial','Galveston','2024-03-07',NULL,'PCP106'),
(1035,'David Turner','1985-11-14','M','Medicaid','Fort Bend','2024-02-22',NULL,'PCP104'),
(1036,'Lily Phillips','1993-08-05','F','Commercial','Harris','2024-01-30',NULL,'PCP105'),
(1037,'Andrew Campbell','1978-12-12','M','Commercial','Brazoria','2024-02-08',NULL,'PCP101'),
(1038,'Zoe Parker','1998-05-25','F','CHIP','Montgomery','2024-03-28',NULL,'PCP102'),
(1039,'Christopher Evans','1984-07-09','M','Medicaid','Harris','2024-01-14',NULL,'PCP108'),
(1040,'Hannah Edwards','1991-10-02','F','Commercial','Fort Bend','2024-02-16',NULL,'PCP103'),
(1041,'Nathan Collins','1977-06-20','M','Medicaid','Galveston','2024-03-09',NULL,'PCP107'),
(1042,'Sofia Stewart','1994-11-18','F','Commercial','Harris','2024-02-24',NULL,'PCP106'),
(1043,'Ryan Sanchez','1983-01-29','M','Medicaid','Montgomery','2024-01-27',NULL,'PCP101'),
(1044,'Victoria Morris','1990-08-11','F','Commercial','Brazoria','2024-03-11',NULL,'PCP105'),
(1045,'Brandon Rogers','1979-09-23','M','Medicaid','Harris','2024-02-04',NULL,'PCP102'),
(1046,'Natalie Reed','1997-12-06','F','CHIP','Fort Bend','2024-04-02',NULL,'PCP108'),
(1047,'Justin Cook','1986-04-17','M','Commercial','Galveston','2024-01-21',NULL,'PCP103'),
(1048,'Leah Morgan','1995-06-28','F','Medicaid','Harris','2024-02-11',NULL,'PCP104'),
(1049,'Aaron Bell','1981-03-10','M','Commercial','Montgomery','2024-03-06',NULL,'PCP106'),
(1050,'Claire Murphy','1993-10-15','F','Medicaid','Harris','2024-01-31',NULL,'PCP105');

select * from Members