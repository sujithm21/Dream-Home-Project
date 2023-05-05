-- 1st queries list

 -- a) 
select * from branch where city = 'London';

-- b)
select  count(branchNo) from branch where city = 'Glasgow';

-- c)
select * from staff  order by branchNo;

-- d)
select count(staffNo),sum(salary) as total from staff;

-- e)
select count(staffNo),position 
from staff ,branch 
where staff.branchNo=branch.branchNo and  city='Glasgow' group by position;

-- f)
select branchNo,staffNo,fName,Sex,telephone 
from staff 
where position ='Manager' order by branchNo;

-- g)
select staffNo,fName,Sex,telephone 
from staff,branch 
where staff.branchNo=branch.branchNo and position ='Supervisor' order by city;

-- h)
select propertyNo , street,city , type , rent
from propertyforrent
where city = 'Glasgow'
order by rent;

-- i)
select * from propertyforRent 
where StaffNo is not null;

-- j)
select count(s.propertyNo),s.staffNo
from propertyforrent as s,propertyforrent as t
where (s.staffNo,s.propertyNo)=(t.staffNo,t.propertyNo) and s.staffNo is not null
group by s.staffNo;

-- k)
select propertyforrent.ownerNo,propertyNo,type,rooms,rent,street,city,postcode,fname,branchNo
from propertyforrent ,privateowner
where propertyforrent.ownerNo=privateowner.ownerNo
order by branchNo;

-- l)
select count(propertyNo),type 
from propertyforrent group by type;

-- m)
   -- (wrong) select * from privateOwner,propertyforRent where privateOwner.OwnerNo=propertyforRent.OwnerNo and count(propertyNo)>1;   syntax wrong count inside where 

select * from privateowner 
where ownerNo in (
select ownerNo 
from propertyforrent
group by ownerNo  
having count(*)>1);


-- n)
select * 
from propertyforRent 
where type='flat' and rent<500 and rooms =3 and city ='Aberdeen';

select *
from propertyforrent
where type='Flat' and propertyNo in (select propertyNo
									 from propertyforrent
                                     where rent<500 and city='Aberdeen' and rooms>=3);


-- o)
select ClientRegistration.branchNo,ClientNo,fName,type,MaxRent 
from ClientRegistration,Branch 
where ClientRegistration.branchNo=Branch.branchNo;

-- p)

SELECT leaseId
FROM lease
WHERE lease.rentEndDt BETWEEN now() AND date_add(now(),interval 1 month);

-- q)
SELECT leaseId
FROM lease l
WHERE l.rentEndDt BETWEEN now() AND date_add(now(),interval 1 month);

-- r)
select count(leaseID) 
from lease where DurationInYears<1 and 
propertyNo in (select propertyNo from propertyforRent where city ='london');


-- 2nd queries list 

-- a

SELECT staff.staffNo, staff.fName, staff.position, staff.sex, staff.telephone, staff.DOB, staff.salary, staff.branchNo
FROM staff
INNER JOIN branch ON staff.branchNo = branch.branchNo
where staff.position = 'Assistant';

-- b 
select fName 
from staff 
where position = 'Assistant'
-- group by branchNo 
order by fName ASC;

-- c  // deposit ledu ??
select p.propertyNo , p.ownerNo ,p.branchNo			
from propertyforrent p,privateowner o;


-- d
select p.propertyNo ,p.staffNo,p.branchNo
from propertyforrent p,staff s
where p.staffNo = s.staffNo;

-- e // staff names clientreg lo names diff

select r.clientNo , s.fName,s.barnchNo
from clientregistrartion r , staff s
where r.fName = s.fName;


-- f
select * from propertyforrent
where city = 'Glasgow' and rent < 450;

-- g

select DISTINCT r.ownerNo , p.fName, p.telNo
from privateowner p ,propertyforrent r
where p.ownerNo = r.ownerNo;

-- h
select comment , clientNo
from viewing ;

-- i 
select v.comment, v.clientNo , c.fName
from viewing v , clientregistration c
where v.comment is NULL;

-- j

select l.clientNo, p.propertyNo
from lease l , propertyforrent p
where l.propertyNo = p.propertyNo;

-- k

select * from lease 
where rentEndDt like '31_0_2023';

-- l  /// rented out di data ledu

select *
from propertyforrent p ,clientregistration c;


-- m  // prefernce ledu changes cheyyali

select distinct p.branchNo , p.type,p.rent , c.clientNo
from propertyforrent p,clientregistration c
where p.type = c.type and p.rent<c.maxRent and p.branchNo = c.branchNo;

