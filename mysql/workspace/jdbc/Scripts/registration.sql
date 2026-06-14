use jdbc;

drop table tbl_registration;
create table tbl_registration(
   id bigint unsigned auto_increment primary key,
   car_id bigint unsigned not null,
   owner_id bigint unsigned not null,
   constraint fk_registration_car foreign key(car_id)
   references tbl_car(id),
   constraint fk_registration_owner foreign key(owner_id)
   references tbl_owner(id)
);
select * from tbl_registration;