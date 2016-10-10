delete from Q;
delete from F1;
delete from F2;
delete from F3;
delete from C2;
delete from C3;
delete from R2;
delete from R3;
delete from PD_R3;

insert into Q (supp, conf, prot) values (500, 0.55, 1.0);

insert into F1 (attr, val, supp) 
	(select attr, val, count(*) as supp
    from Pro_Publica, Q 
    group by attr, val
    having count(*) >= (select supp from Q));

-- YOUR CODE GOES HERE

insert into C2(attr1,val1,attr2,val2)
	(select a.attr,a.val,b.attr,b.val 
    from F1 a, F1 b 
    where a.attr<b.attr);

insert into F2 (attr1, val1, attr2, val2, supp)
	(select attr1, val1, attr2, val2, count(P1.attr) as supp 
    from C2, Pro_Publica P1, Pro_Publica P2
    where P1.uid=P2.uid and 
		C2.attr1=P1.attr and 
        C2.val1=P1.val and 
        C2.attr2=P2.attr and 
        C2.val2=P2.val 
	group by attr1, val1, attr2, val2 
    having count(P1.attr) >= (select supp from Q));
    
insert into C3(attr1, val1, attr2, val2, attr3, val3)
	(select Distinct a.attr1, a.val1, a.attr2, a.val2, b.attr2 ,b.val2 
	from F2 a, F2 b 
    where a.attr1=b.attr1 and 
			a.val1=b.val1 and 
            a.attr2<b.attr2 );

insert into F3 (attr1, val1, attr2, val2, attr3, val3, supp) 
	(select attr1, val1, attr2, val2, attr3, val3, count(P1.attr) as supp from C3, Pro_Publica P1, Pro_Publica P2, Pro_Publica P3 
	where P1.uid=P2.uid and 
		P2.uid=p3.uid and 
		C3.attr1=P1.attr and 
		C3.val1=P1.val and 
		C3.attr2=P2.attr and 
		C3.val2=P2.val and 
		C3.attr3=P3.attr and 
		C3.val3=P3.val 
	group by attr1, val1, attr2, val2, attr3, val3 
	having count(P1.attr) >= (select supp from Q));
    
    
insert into R2(attr1, val1, attr2, val2, supp, conf)
	(select attr1, val1, attr2, val2, F2.supp, F2.supp/F1.supp as conf 
    from F2,F1,Q 
    where F2.attr1=F1.attr and
		F2.val1=F1.val and 
		attr2='vdecile' and 
		(F2.supp/F1.supp)>=Q.conf);
        
insert into R3(attr1, val1, attr2, val2, attr3, val3, supp, conf)
	(select F3.attr1, F3.val1, F3.attr2, F3.val2, F3.attr3, F3.val3, F3.supp, F3.supp/F2.supp as conf 
	from F3,F2,Q 
    where F3.attr1=F2.attr1 and
		F3.val1=F2.val1 and
		F3.attr2=F2.attr2 and
        F3.val2=F2.val2 and
        F3.attr1!='vdecile' and
        F3.attr2!='vdecile' and 
        F3.attr3='vdecile' and
        (F3.supp/F2.supp)>=Q.conf);


insert into PD_R3(attr1, val1, attr2, val2, attr3, val3, supp, conf, prot)
	(select R3.attr1, R3.val1, R3.attr2, R3.val2, R3.attr3, R3.val3, R3.supp,R3.supp/F2.supp 
    as conf,R3.conf/R2.conf as prot 
    from R3, R2, F2, Q 
    where F2.attr1=R3.attr1 and
		F2.attr2=R3.attr2 and
        F2.val1=R3.val1 and
        F2.val2=R3.val2 and
        R3.attr1=R2.attr1 and
        R3.val1=R2.val1 and 
        R3.attr3=R2.attr2 and
        R3.val3=R2.val2 and
        F2.attr2='race' and  
        R3.attr1!='vdecile' and
        R3.attr2='race' and
        R3.attr3='vdecile' and 
        (R3.supp/F2.supp)>=Q.conf and 
        (R3.conf/R2.conf)>=Q.prot and 
        R3.supp>=Q.supp);
        
        
-- ALLOWED:
-- you may but don't have to use the provided tables: F2, F3, C2, C3 as part 
-- all valid SQL queries are fine here: insert, delete, update
-- you may create additional helper tables if you like

-- NOT ALLOWED:
-- you may NOT use any procedural code: no for loops and the like are allowed

-- OUTPUT MUST GO INTO THESE RELATIONS, DON'T CHANGE THEIR SCHEMAS:
-- insert into R2 (attr1, val1, attr2, val2, supp, conf)
-- (...);

-- insert into R3 (attr1, val1, attr2, val2, attr3, val3, supp, conf)
-- (...);

-- insert into PD_R3 (attr1, val1, attr2, val2, attr3, val3, supp, conf, prot) 
--  (...);

