use jdbc;

drop table tbl_owner;
create table tbl_owner(
   id bigint unsigned auto_increment primary key,
   owner_name varchar(255) not null,
   owner_phone varchar(255) not null,
   owner_gender enum('남', '여', '선택안함') default '선택안함'
);
select * from tbl_owner;
