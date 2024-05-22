-- CREATE TABLES
create table sailor (sid varchar2(4), sname varchar2(15), mname varchar(15), Surname varchar(15), Rating number(2), Age number(3,1));

create table boat (bid number(3), bname varchar2(10), color varchar2(6));

create table reserve (sid varchar2(4), bid number(3), day date);

-- Adding constraints
alter table sailor add constraint sailor_pk primary key (sid);
alter table sailor add constraint start_smalls check (sid like 's%');
alter table sailor add constraint sname_cap check (sname = initcap(sname));

alter table boat add constraint bid_pk primary key(bid);
alter table boat add constraint bid_lower check (bname = lower(bname));
alter table boat add constraint col check (color in ('blue', 'red', 'green'));

alter table reserve add constraint fk_sailor_sid foreign key (sid) references sailor(sid);
alter table reserve add constraint fk_boat_bid foreign key (bid) references boat(bid);
alter table reserve add constraint date_check check (day < date '2000-01-01');
alter table reserve add constraint r_sid_pk primary key(sid, bid);

ALTER TABLE reserve DROP CONSTRAINT r_sid_pk;

-- ENTERING VALUES

insert into sailor values ('s22', 'Fredrico', null, 'Roberts', 7, 45);

insert into sailor values ('s31', 'Lubber', null, 'Sheen', 8, 55.5);
insert into sailor values ('s32', 'Charlotte', null, 'Gordin', 8, 25.5);
insert into sailor values ('s58', 'Mary', 'Beth', 'Lyon', 10, 35);

insert into sailor values ('s64', 'Horatio', null, 'Powel', 7, 35.4);
insert into sailor values ('s71', 'Zorba', null, 'Alex', 10, 16);
insert into sailor values ('s29', 'Brutus', null, 'Slater', 1, 33.8);
insert into sailor values ('s95', 'Deep', 'Graceb', 'Davis', 3, 63.5);
insert into sailor values ('s74', 'Horatio', null, 'Forrest', 9, 35);
insert into sailor values ('s85', 'Sara', 'Art', 'Powel', 3, 25.5);
insert into sailor values ('s80', 'Deep', 'Kumar', 'Kumar', 6, 17);
insert into sailor values ('s87', 'Deep', 'Kumar', 'Jha', 8, 51);

insert into boat values ('101', 'interlake', 'blue');
insert into boat values ('102', 'interlake', 'red');
insert into boat values ('103', 'clipper', 'green');
insert into boat values ('104', 'marine', 'red');

insert into reserve values ('s22', '101', '10-OCT-98');
insert into reserve values ('s22', '103', '10-AUG-98');
insert into reserve values ('s22', '102', '10-OCT-98');
insert into reserve values ('s22', '104', '10-JUL-98');
insert into reserve values ('s31', '102', '11-OCT-98');
insert into reserve values ('s31', '103', '11-JUN-98');
insert into reserve values ('s31', '104', '11-DEC-98');
insert into reserve values ('s64', '101', '09-MAY-98');
insert into reserve values ('s64', '102', '09-AUG-98');
insert into reserve values ('s74', '103', '09-AUG-98');
insert into reserve values ('s80', '102', '07-JUL-98');

-- QUESTIONS ->

-- Q1
select sname, Surname, Age from sailor;

-- Q2
select sname as names_of_sailors, age + 2 from sailor;

-- Q3
select * from sailor order by sname ASC;

-- Q4
select * from sailor;

-- Q5
select distinct sname from sailor;

-- Q6
select distinct sname, Rating from sailor where Rating > 5 and Rating < 10;

-- Q7
select * from sailor order by Rating ASC, Age DESC;

-- Q8
select * from sailor where Rating > 7;

-- Q9
select * from sailor where sname = 'Horatio' and age = 35.4;

-- Q10
select * from sailor where sname = 'Horatio' or age = 35.4;

-- Q11
select sailor.sid, sname, bid from sailor, reserve where sailor.sid = reserve.sid and bid='104';

-- Q12
select distinct sailor.sid from sailor, reserve, boat where sailor.sid = reserve.sid and boat.bid = reserve.bid and boat.color ='red'; 

-- Q13
select * from sailor where sname like 'B%';

-- Q14
select * from sailor where sname like '%B%' or sname like '%b%';

-- Q15
select sname from sailor where mname is not null;

-- Q16
select sname from sailor where mname is null;

-- Q17
select boat.color from sailor, reserve, boat where sailor.sid = reserve.sid and boat.bid = reserve.bid and sailor.sname = 'Lubber';   

-- Q18
select sname, surname from sailor where sid in (select sid from reserve);

-- Q20
select distinct sname, rating from sailor, reserve where sailor.sid = reserve.sid and reserve.day in (select day from reserve group by day having count(*) > 1) order by sailor.rating asc;

-- Q21
-- select sname from sailor where sname like '%o';

-- Q23
select sname from sailor where sid in (select sid from reserve where bid in (select bid from boat where color in ('red', 'green')));

-- -- or
select sname from sailor, boat, reserve where sailor.sid = reserve.sid and boat.bid = reserve.bid and boat.color in ('red', 'green') group by sname, surname;

-- Q24

select reserve.sid, reserve.bid, color from boat, reserve where boat.bid = reserve.bid;

select sname, surname from sailor where sid in
(
    select sid from reserve, boat where reserve.bid = boat.bid and boat.color = 'red' and reserve.sid in
    (   
        select sid from sailor where sid not in
        (
            select sid from reserve, boat where reserve.bid = boat.bid and color = 'green'
        )
    )
);

-- **Try using joins**

-- Q25
select distinct sname, surname from sailor, reserve where sailor.sid = reserve.sid and reserve.bid = '103';

-- Q26
select distinct sname, surname from sailor, boat, reserve where sailor.sid = reserve.sid and boat.bid = reserve.bid and boat.color = 'red';

-- Q28
select sid, sname, surname from sailor where sid not in (
select reserve.sid from sailor, boat, reserve where sailor.sid = reserve.sid and boat.bid = reserve.bid and boat.color = 'red');

-- Q29
select distinct sname, count(*) as count from sailor group by sname;

-- Q30
-- a
select * from sailor where rating > any (select rating from sailor where sname='Horatio');

-- b
select * from sailor where rating > all (select rating from sailor where sname='Horatio');

-- Q31
-- a
select * from sailor where rating < any (select rating from sailor where sname='Horatio');

-- b
select * from sailor where rating < all (select rating from sailor where sname='Horatio');

-- Q32
select sname from sailor where sname not in ('Lubber', 'Horatio');

-- Q33
select sname from sailor where rating > any ('5', '6', '7');

-- Q34
select sname from sailor where rating > all ('5', '6', '7');

-- Q35
select avg(age) as Average_Age from sailor where rating = 10;

-- Q36
select sname from sailor where age > 
(
    select max(age) from sailor where rating = '10'
);

-- Q37
select rating, min(age) from sailor group by rating order by rating asc;

-- Q38
select rating, count(*) as Count from sailor  where age > 18 group by rating;

-- Q39
select min(age), rating from sailor where age>18 group by rating having count(*) > 1;

-- Q40
select avg(age), rating from sailor group by rating having count(*) > 1;

-- Q41
select bid, count(*) as res_count from reserve where bid in
(
    select bid from boat where color = 'red'
) group by bid;

-- Q42
select sname from sailor where rating = (select max(rating) from sailor);

-- Q44
select rating, avg(age) from sailor group by rating having avg(age) <= all (select avg(age) from sailor group by rating);

-- Q45
select sname from sailor where sid in
(
    select sid from reserve group by sid having count(*) = 
    (
        select count(*) from boat
    )
);

--  or

select sid, sname from sailor where not exists
(select bid from boat
minus
select bid from reserve where reserve.sid=sailor.sid);