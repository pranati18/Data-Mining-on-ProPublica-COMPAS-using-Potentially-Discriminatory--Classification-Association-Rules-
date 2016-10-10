drop table Pro_Publica;
drop table F1;
drop table F2;
drop table F3;
drop table C2;
drop table C3;
drop table R2;
drop table R3;
drop table PD_R3;
drop table Q;

create table Pro_Publica(
 uid integer, 
 attr varchar(16), 
 val integer,
 primary key (uid, attr));

\copy Pro_Publica FROM 'PP.csv' with CSV delimiter ',';

create table Q (
 supp float,
 conf float,
 prot float
);

create table F1 (
  attr varchar(16),
  val integer,
  supp float, 
  primary key (attr, val));

create table C2 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  primary key (attr1, val1, attr2, val2));

create table F2 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  supp float,
  primary key (attr1, val1, attr2, val2));

create table C3 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  attr3 varchar(16),
  val3 integer,
  primary key (attr1, val1, attr2, val2, attr3, val3)
);

create table F3 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  attr3 varchar(16),
  val3 integer,
  supp float,
  primary key (attr1, val1, attr2, val2, attr3, val3));

create table R2 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  supp float,
  conf float,
  primary key (attr1, val1, attr2, val2)
);

create table R3 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  attr3 varchar(16),
  val3 integer,
  supp float,
  conf float,
  primary key (attr1, val1, attr2, val2, attr3, val3)
);

create table PD_R3 (
  attr1 varchar(16),
  val1 integer,
  attr2 varchar(16),
  val2 integer,
  attr3 varchar(16),
  val3 integer,
  supp float,
  conf float,
  prot float,
  primary key (attr1, val1, attr2, val2, attr3, val3)
);
