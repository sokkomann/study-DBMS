use jdbc;

drop table tbl_car;
create table tbl_car(
   id bigint unsigned auto_increment primary key,
   car_brand varchar(255) not null,
   car_model varchar(255) not null,
   car_price bigint unsigned default 0,
   car_status enum ('enable', 'disable') default 'enable',
   car_created_date date,
   car_updated_date date
);
select * from tbl_car;