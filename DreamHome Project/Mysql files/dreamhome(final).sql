create database if not exists dreamhomefinal;
use dreamhomefinal;

-- branch details which are to be included
CREATE TABLE branch
(branchNo char(5) PRIMARY KEY,
 street varchar(35),
 city varchar(10) not null,
 postcode varchar(10) not null,
 telNo numeric(20) not null,
 supervisor_staffNo varchar(20),
 manager_staffNo char(10)
);
select * from branch;
INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH',0403355755,null,'SL21');
INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU',0403355777,null,null);
INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX',0403355733,'SG14','SG5');
INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ',0403355744,null,null);
INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU',0403355722,null,null);

-- details of staff who joined
CREATE TABLE staff
(staffNo char(5) PRIMARY KEY,
 fName varchar(20),
 position varchar(10),
 sex char(1),
 telephone varchar(15),
 DOB date,
 salary int,
 branchNo char(5),
 foreign key (branchNo) references branch(branchNo)
);

alter table staff modify column fName varchar(20);
desc staff;

INSERT INTO staff VALUES('SL21','John White','Manager','M','123456789','1965-10-01',30000,'B005');
INSERT INTO staff VALUES('SG37','Ann Beech','Assistant','F','987654321','1980-11-10',12000,'B003');
INSERT INTO staff VALUES('SG14','David Ford','Supervisor','M','3334455555','1978-03-24',18000,'B003');
INSERT INTO staff VALUES('SA9','Mary Howe','Assistant','F','6547893213','1990-02-19',9000,'B007');
INSERT INTO staff VALUES('SG5','Susan Brand','Manager','F','4567891230','1960-06-03',24000,'B003');
INSERT INTO staff VALUES('SL41','Julie Lee','Assistant','F','9517532580','1985-06-13',9000,'B005');

-- details of the owner who want to rent out property
CREATE TABLE privateOwner
(ownerNo char(5) PRIMARY KEY,
 fName varchar(10),
 address varchar(50),
 telNo char(15),
 email varchar(50),
 password varchar(40)
);

alter table privateowner modify column fName varchar(20);

INSERT INTO privateOwner VALUES('CO46','Joe Keogh','2 Fergus Dr. Aberdeen AB2 ','01224-861212', 'jkeogh@lhh.com', null);
INSERT INTO privateOwner VALUES('CO87','Carol Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419', 'cfarrel@gmail.com', null);
INSERT INTO privateOwner VALUES('CO40','Tina Murphy','63 Well St. Glasgow G42','0141-943-1728', 'tinam@hotmail.com', null);
INSERT INTO privateOwner VALUES('CO93','Tony Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025', 'tony.shaw@ark.com', null);

-- properties available to rent out 
CREATE TABLE propertyForRent
(propertyNo char(5) PRIMARY KEY,
 street varchar(35),
 city varchar(10),
 postcode varchar(10),
 type varchar(10),
 rooms smallint,
 rent int,
 ownerNo char(5) not null,
 staffNo char(5),
 branchNo char(5),
 foreign key(branchNo) references branch(branchNo),
 foreign key(ownerNo) references privateowner(ownerNo),
 foreign key(staffNo) references staff(staffNo)
);

INSERT INTO propertyForRent VALUES('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO propertyForRent VALUES('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005' );
INSERT INTO propertyForRent VALUES('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40', NULL, 'B003');
INSERT INTO propertyForRent VALUES('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003' );
INSERT INTO propertyForRent VALUES('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO propertyForRent VALUES('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003' );

-- registration for the clients who want to rent out house
CREATE TABLE clientregistration
(
clientNo char(5) PRIMARY KEY,
 fName varchar(20),
 branchNo char(5),
 baddress varchar(50),
 regBy varchar(20),
 regDate date,
 type char(10),
 maxRent int,
 foreign key(branchNo) references branch(branchNo)
);

INSERT INTO clientregistration values ('CR76','Elena','B003','163 Main St, Glasgow','Aizawa','2015-01-23','Flat',700);
INSERT INTO clientregistration values ('CR56','Edward','B005','22 Deer Rd, London','Alphonse','2014-04-13','House',850);
INSERT INTO clientregistration values ('CR74','Nathan','B003','163 Main St, Glasgow','Jake','2013-11-16','Flat',600);
INSERT INTO clientregistration values ('CR62','Ariana','B007','16 Argyll St, Aberdeen','Angela','2014-03-07','House',1600);
INSERT INTO clientregistration values ('CR54','Belinda','B002','56 Clover Dr, London','Rachael','2013-06-13','House',900);

-- details of properties viewed by clients
CREATE TABLE  viewing
(clientNo char(5) not null,
 propertyNo char(5) not null,
 viewDate date,
 comment varchar(15),
 foreign key(clientNo) references clientregistration(clientNo),
 foreign key(propertyNo) references propertyforrent(propertyNo)
);

INSERT INTO viewing VALUES('CR56','PA14','2015-05-24','too small');
INSERT INTO viewing VALUES('CR76','PG4','2015-04-20','too remote');
INSERT INTO viewing VALUES('CR56','PG4','2015-05-26','');
INSERT INTO viewing VALUES('CR62','PA14','2015-05-14','no dining room');
INSERT INTO viewing VALUES('CR56','PG36','2015-04-28','');

-- Houses that are rented out
create table lease
(
leaseId int primary key,
clientNo varchar(30),
Rent int not null,
Deposit Boolean,
paymentMethod varchar(30),
propertyNo varchar(30),
rentStartDt varchar(20),
rentEndDt varchar(20),
DurationInYears float,
FOREIGN KEY (propertyNo) references propertyforrent(propertyNo),
foreign key(clientNo) references clientregistration(clientNo)
);

SET FOREIGN_KEY_CHECKS=0;
insert into lease values (1,'CR56',450,TRUE,'cash','PG36','01/06/2004','31/05/2005',1);
insert into lease values (2,'CR74',1800,TRUE,'cheque','PL94','01/03/2003','31/04/2006',3);

show tables;
select * from branch;
select * from staff;
select * from privateowner;
select * from propertyforrent;
select * from clientregistration;
select * from viewing;
select * from lease;




