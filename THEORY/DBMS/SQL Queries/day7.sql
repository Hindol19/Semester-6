select * from sailor;

select * from boat;

select * from reserve;

--Q25
select sname from sailor where sid in (select sid from reserve where bid=103);

--Q26
select sname from sailor where sid in (select sid from reserve where bid in (select bid from boat where color='red'));

--Q28: 
(select sailor.sid, sname from sailor, reserve where sailor.sid=reserve.sid)
MINUS
(select sailor.sid, sname from sailor, reserve, boat where sailor.sid=reserve.sid and boat.bid=reserve.bid and color='red');

--Q29
select count(distinct sname) from sailor;

--Q30(a)
select * from sailor where rating > any (select rating from sailor where sname='Horatio');

--Q30(b)
select * from sailor where rating > all (select rating from sailor where sname='Horatio');

--Q32(a)
select * from sailor where rating < any (select rating from sailor where sname='Horatio');

--Q32(b)
select * from sailor where rating < all (select rating from sailor where sname='Horatio');

--Q32
select * from sailor where sname not in ('Horatio', 'Lubber');

--Q33
select * from sailor where rating > any (5,6,7);

--Q34
select * from sailor where rating > all (5,6,7);

--Q35
select avg(age) from sailor where rating=10;

--Q36
select sname,age from sailor where age > (select max(age) from sailor where rating=10); 

--Q37
select min(age) from sailor group by rating;

--Q38
select rating, count(*)  from sailor where age>=18 group by rating;

--Q39
select rating, min(age) from sailor where age>=18 group by rating having count(*)>1;

--Q40
select rating, avg(age) from sailor group by rating having count(*)>1;

--Q41
select reserve.bid,count(*) from reserve, boat where boat.bid=reserve.bid and color='red' group by reserve.bid;

--Q42
select * from sailor where rating=(select max(rating) from sailor);

--Q44
select rating, avg(age) from sailor group by rating having avg(age) <= all ( select avg(age) from sailor group by rating);

--Q45
select sid, sname from sailor where not exists
(select bid from boat
minus
select bid from reserve where reserve.sid=sailor.sid);