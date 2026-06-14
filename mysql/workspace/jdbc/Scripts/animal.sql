use jdbc;

drop table tbl_animal;
create table tbl_animal(
	id bigint unsigned auto_increment primary key,
	animal_name varchar(255) not null,
	animal_type varchar(255) not null,
	animal_age int default 0,
	animal_height decimal(5, 2) check (animal_height > 0),
	animal_weight decimal(5, 2) check (animal_weight > 0),
	animal_condition enum('alive', 'dead', 'ill') default 'alive',
	animal_gender enum('male', 'female') default 'male',
	animal_created_datetime datetime default current_timestamp(),
	animal_updated_datetime datetime default current_timestamp()
);

select * from tbl_animal;