create database ddl;
use ddl;

/*
 * 회원테이블
 * 
 * 회원번호
 * 회원이메일
 * 회원비밀번호
 * 회원나이
 * 
 * */

create table tbl_member(
	id bigint primary key,
	member_email varchar(255),
	member_password varchar(255),
	member_age int
);

/*
 * 동물원 테이블
 * 
 * 고유 번호
 * 동물원 이름
 * 동물원 주소
 * 동물원 상세 주소
 * 동물 최대 수용치
 * */

drop table tbl_zoo;

create table tbl_zoo(
	id bigint primary key,
	zoo_name varchar(255) not null, 
	zoo_address varchar(255) not null,
	zoo_detailed_address varchar(255) not null,
	zoo_max_capacity int check(zoo_max_capacity > 0)
);

/* 동물테이블
 * 
 * 고유번호
 * 동물이름
 * 동물종류
 * 동물나이
 * 동물키
 * 동물몸무게
 * */
drop table animal;

create table animal(
	id bigint primary key,
	animal_name varchar(255) not null,
	animal_type varchar(255) not null,
	animal_age int default 0,
	animal_height decimal(3, 2) check (animal_height > 0),
	animal_weight decimal(3, 2) check (animal_weight > 0),
	zoo_id bigint not null,
   	constraint fk_animal_zoo foreign key(zoo_id)
   	references tbl_zoo(id)
);

/*
 * 회사
 * 번호
 * 회사 이름
 * 회사 주소
 * */

/*
 * 직원
 * 번호
 * 이름
 * */
drop table tbl_company;

create table tbl_company(
	id bigint primary key,
	company_name varchar(255) not null,
	company_address varchar(255) not null
);

drop table tbl_employee;

create table tbl_employee(
	id bigint primary key,
	employee_name varchar(255) not null,
	company_id bigint not null,
	constraint fk_employee_company foreign key(company_id)
	references tbl_company(id)
);

/*tbl_member
-------------------------------------------------
id: bigint unsigned primary key
-------------------------------------------------
member_email: varchar(255) unique not null
member_password varchar(255) not null*/

create table tbl_member(
   	id bigint unsigned primary key,
   	member_email varchar(255) unique not null,
   	member_password varchar(255) not null
);

create table tbl_product(
   	id bigint unsigned primary key,
   	product_name varchar(255) not null,
   	product_price int default 0,
   	product_stock int default 0
);

create table tbl_order(
   	id bigint unsigned primary key,
   	order_date datetime default current_timestamp(),
	member_id bigint unsigned not null,
   	product_id bigint unsigned not null,
   	constraint fk_order_member foreign key(member_id)
   	references tbl_member(id),
   	constraint fk_order_product foreign key(product_id)
   	references tbl_product(id)
);


/*
 * 1. 요구사항 분석
 *       꽃 테이블과 화분 테이블 2개가 필요하고,
 *     꽃을 구매할 때 화분도 같이 구매합니다.
 *     꽃은 이름과 색상, 가격이 있고
 *     화분은 제품번호, 색상, 모양이 있습니다.
 *       화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.
 */

/*create table tbl_flower(
   id bigint unsigned primary key,
   flower_name varchar(255) not null,
   flower_color varchar(255) not null,
   flower_price int default 0
);

create table tbl_pot(
   id bigint unsigned primary key,
   pot_color varchar(255) not null,
   pot_shape varchar(255) not null,
   flower_id bigint unsigned not null,
   constraint fk_pot_flower foreign key(flower_id)
   references tbl_flower(id)
);*/


create table tbl_flower(
   id bigint unsigned primary key,
   flower_name varchar(255) not null,
   flower_color varchar(255) not null,
   flower_price int default 0
);

create table tbl_pot(
   id bigint unsigned primary key,
   pot_color varchar(255) not null,
   pot_shape varchar(255) not null
);

create table tbl_flower_pot(
   id bigint unsigned primary key,
   flower_id bigint unsigned not null,
   pot_id bigint unsigned not null,
   constraint fk_flower_pot_flower foreign key(flower_id)
   references tbl_flower(id),
   constraint fk_flower_pot_pot foreign key(pot_id)
   references tbl_pot(id)
);

/*
 * 1. 요구사항 분석
 *    안녕하세요, 동물병원을 곧 개원하는 원장입니다.
 *    동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
 *    보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
 *    보호자는 이름, 나이, 전화번호, 주소 정보를 알려줘야 하고
 *    동물은 병명, 이름, 나이, 몸무게 정보가 필요합니다.
 * 		
 */
/*
 * 	동물  
 *  번호P bigint unsigned primary key
 * 	병명NN varchar(255) not null
 * 	이름NN varchar(255) not null
 * 	나이D0 int default 0
 *  몸무게D0 int default 0
 *  보호자F 
 */

/*
 *보호자 
 *번호P bigint unsigned primary key
 *이름NN varchar(255) not null
 *나이D0 int default 0
 *전화번호NN char(11) not null
 *주소NN varchar(255) not null
 * 
*/
drop table tbl_owner;

create table tbl_owner(
	id bigint unsigned auto_increment primary key,
	owner_name varchar(255) not null,
	owner_age int default 0,
	owner_phone char(11) not null,
	owner_address varchar(255) not null
);
drop table tbl_pet;

create table tbl_pet(
	id bigint unsigned auto_increment primary key,
	pet_illness varchar(255) not null,
	pet_name varchar(255) not null,
	pet_age int default 0,
	pet_weight decimal(3,2) not null,
	owner_id bigint unsigned,
	constraint fk_pet_owner foreign key(owner_id)
	references tbl_owner(id)
);

/*
1. 요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시글에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 번호, 이메일, 이름이 있다.
    댓글에도 작성자가 필요해요.
*/
/*
 * board
 * 번호P
 * 제목NN
 * 내용NN
 * 시간D(CT)
 * 작성자
 * 
 * writer
 * 번호P
 * 이메일U NN
 * 이름NN
 * 
 * comment
 * 번호P
 * 내용NN
 * 작성자F
 * 
 * */

create table tbl_post(
	id bigint unsigned primary key,
	post_title varchar(255) not null,
	post_content text not null,
	created_datetime datetime default current_timestamp(), /*created_datetime은 항상!! 있어야한다.*/
	post_writer bigint unsigned not null, /*null을 허용하면 익명게시판도 됨*/
	constraint fk_post_writer foreign key(post_writer)
	references tbl_user(id)
);

create table tbl_user(
	id bigint unsigned primary key,
	user_email varchar(255) unique key not null,
	user_name varchar(255) default '익명'
);

create table tbl_comment(
	id bigint unsigned primary key,
	comment_content text not null,
	comment_writer bigint unsigned not null,
	post_id bigint unsigned not null,
	constraint fk_comment_writer foreign key(comment_writer)
	references tbl_user(id),
	constraint fk_comment_post foreign key(post_id)
	references tbl_post(id)
);


/*
   1. 요구 사항
       마이페이지에서 회원 프로필을 구현하고 싶습니다.
       회원당 프로필을 여러 개 설정할 수 있고,
       대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.
       
       *파일 테이블 (-> 파일을 저장하는게 아니고, 파일이 어디에 저장되어있는지의 정보)
       *경로
       *이름
       *크기
*/

create table tbl_member(
	id bigint unsigned primary key,
	member_name varchar(255) default '익명',
	member_email varchar(255) unique key not null
);

create table tbl_file(						/*요건 공용*/
   id bigint unsigned primary key,
   file_path varchar(255) not null,
   file_name varchar(255) not null,
   file_size varchar(255) not null
);

create table tbl_member_file(				/*요건 개인*/
   id bigint unsigned primary key,
   member_id bigint unsigned not null,
   member_file_check enum('selected', 'none') default 'selected',
   constraint fk_member_file_file foreign key(id)
   references tbl_file(id),
   constraint fk_member_file_member foreign key(member_id)
   references tbl_member(id)
);

/*
1. 요구 사항
    회원들끼리 좋아요를 누를 수 있습니다.
    좋아요를 *받은* 사람과 *준* 사람 둘 다 저장해야 한다.
*/
/*  받은사람:준사람 = 1:N 받은사람FK
 *  
 * 	받은사람       준사람        좋아요
 *  번호P         번호P         
 *  이름NN        이름NN
 *  
 * */
create table tbl_member(
	id bigint unsigned primary key,
	member_name varchar(255) default '익명',
	member_email varchar(255) unique key not null
);
create table tbl_like(
	id bigint unsigned,
	taker_id bigint unsigned not null,
	giver_id bigint unsigned not null,
	constraint fk_like_taker_member foreign key(id)
   	references tbl_member(id),
   	constraint fk_member_giver_member foreign key(id)
   	references tbl_member(id)
);

/*
    1. 요구사항 분석
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.
*/
/*
 * 중고차는 그동안의 차주들을 기록
 * 차주는 여러대의 차를 소유가능.
 * 
 * */
create table tbl_used_car(
	id bigint unsigned primary key,
	car_brand varchar(255) not null,
	car_model varchar(255) not null,
	car_price bigint unsigned default 0,
	car_launched_date date not null
);

create table tbl_owners(
	id bigint unsigned primary key,
	owner_name varchar(255) not null,
	owner_phone varchar(255) not null,
	owner_address varchar(255) not null,
	owner_address_detail varchar(255) not null
);

create table tbl_registration(
	id bigint unsigned primary key,
	registrated_date date default current_timestamp(),
	car_id bigint unsigned not null,
	owner_id bigint unsigned not null,
	constraint fk_registration_car foreign key(car_id)
	references tbl_used_car(id),
	constraint fk_registration_owner foreign key(owner_id)
	references tbl_owners(id)
);

/*병원을 운영 중입니다.
의사와 환자를 관리하려고 합니다.
- 의사는 여러 명의 환자를 진료할 수 있습니다.
- 환자는 여러 의사에게 진료를 받을 수 있습니다.
- 진료를 받을 때마다 진료 기록(Medical Record)이 반드시 생성됩니다.
의사 정보
- 이름
- 진료 과목
환자 정보
- 이름
- 주민번호
진료 기록 정보
- 진료 날짜
- 진료 내용*/

create table tbl_doctor(
	id bigint unsigned primary key,
	doctor_name VARCHAR(255) not null,
	doctor_type varchar(255) not null
);

create table tbl_patient(
	id bigint unsigned primary key,
	patient_name varchar(255) not null,
	patient_number varchar(255) not null
);

create table tbl_medical_records(
	id bigint unsigned primary key,
	record_time datetime default current_timestamp(),
	record_content text not null,
	patient_id bigint unsigned not null,
	doctor_id bigint unsigned not null,
	constraint fk_record_patient foreign key(patient_id)
	references tbl_patient(id),
	constraint fk_record_doctor foreign key(doctor_id)
	references tbl_doctor(id)
);

/*
1. 요구사항
    대카테고리, 소카테고리가 필요해요.
*/
create table tbl_categoryA(
	id bigint unsigned primary key,
	categoryA_name varchar(255) not null,
);

create table tbl_categoryB(
	id bigint unsigned primary key,
	categoryB_name varchar(255) not null,
	categoryA_id bigint unsigned not null,
	constraint fk_categoryB_categoryA foreign key(categoryA_id)
	references tbl_categoryA(id)
);

/*
1. 요구사항
   회의실 예약 서비스를 제작하고 싶습니다.
   회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
   회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
*/
create table tbl_office(
	id bigint unsigned primary key,
	office_name varchar(255) not null,
	office_address varchar(255)	not null
);

create table tbl_office_room(
	id bigint unsigned primary key,
	room_name varchar(255) not null,
	office_id bigint unsigned not null,
	constraint fk_room_office foreign key(office_id)
	references tbl_office(id)
);

create table tbl_part_time(
	id bigint unsigned primary key,
	start_time time not null,
   	end_time time not null,
	/*part_timeA enum('available', 'unavailable') default 'available',
	part_timeB enum('available', 'unavailable') default 'available',
	part_timeC enum('available', 'unavailable') default 'available',*/
	room_id bigint unsigned not null,
	constraint fk_part_time_room foreign key(room_id)
	references tbl_office_room(id)
);

create table tbl_member(
	id bigint unsigned primary key,
	member_name varchar(255) not null,
	member_grade int check(member_grade between 1 and 3) default 1
);

create table tbl_reservation(
	id bigint unsigned primary key,
	member_id bigint unsigned not null,
	part_time_id bigint unsigned not null,
	reservation_date datetime not null,
	constraint fk_reserve_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_reservation_part_time foreign key(part_time_id)
	references tbl_part_time(id)
);

/*
1. 요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.*/
create table tbl_member(
   id bigint unsigned primary key,
   member_name varchar(255) not null,
   member_email varchar(255) unique not null,
   member_password varchar(255) not null
);

create table tbl_kindergarten(
   id bigint unsigned primary key,
   kindergarten_name varchar(255) not null,
   kindergarten_address varchar(255) not null,
   kindergarten_address_detail varchar(255) not null,
   member_id bigint unsigned not null,
   constraint fk_kindergarten_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_parent(
   id bigint unsigned primary key,
   parent_name varchar(255) not null,
   parent_age int,
   parent_phone varchar(255) not null,
   parent_gender enum('M', 'W', 'N') default 'N'
);

create table tbl_child(
   id bigint unsigned primary key,
   child_name varchar(255) not null,
   child_age int not null,
   child_gender enum('M', 'W'),
   parent_id bigint unsigned,
   constraint fk_child_parent foreign key(parent_id)
   references tbl_parent(id)
);

create table tbl_field_trip(
   id bigint unsigned primary key,
   field_trip_title varchar(255) not null,
   field_trip_content varchar(255) not null,
   member_id bigint unsigned not null,
   constraint fk_field_trip_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_file(
   id bigint unsigned primary key,
   file_path varchar(255) not null,
   file_name varchar(255) not null,
   file_size varchar(255) not null,
   field_trip_id bigint unsigned,
   constraint fk_file_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);

create table tbl_apply(
   id bigint unsigned primary key,
   child_id bigint unsigned not null,
   field_trip_id bigint unsigned not null,
   constraint fk_apply_child foreign key(child_id)
   references tbl_child(id),
   constraint fk_apply_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);
/*
1. 요구사항
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.
*/
create table tbl_categoryA(
	id bigint unsigned primary key,
	categoryA_name varchar(255) not null
);

create table tbl_categoryB(
	id bigint unsigned primary key,
	categoryB_name varchar(255) not null,
	categoryA_id bigint unsigned not null,
	constraint fk_B_A foreign key(categoryA_id)
	references tbl_categoryA(id)
);

create table tbl_categoryC(
	id bigint unsigned primary key,
	categoryC_name varchar(255) not null,
	categoryB_id bigint unsigned not null,
	constraint fk_C_B foreign key(categoryB_id)
	references tbl_categoryB(id)
);

create table tbl_advertisement(
	id bigint unsigned primary key,
	ad_title varchar(255) not null,
	ad_content text not null,
	categoryC_id bigint unsigned not null,
	constraint fk_ad_categoryC foreign key(categoryC_id)
	references tbl_categoryC(id)
);

create table tbl_company(
	id bigint unsigned primary key,
	company_name varchar(255) not null,
	company_address varchar(255) not null,
	company_address_detail varchar(255) not null,
	company_tel varchar(255) not null,
	company_type enum('1', '2', '3', '4') default '1'	/*enum은 문자열만!*/
);

create table tbl_apply(
   id bigint unsigned primary key,
   company_id bigint unsigned not null,
   ad_id bigint unsigned not null,
   constraint fk_apply_company foreign key(company_id)
   references tbl_company(id),
   constraint fk_apply_ad foreign key(ad_id)
   references tbl_ad(id)
);
/*
   1. 요구사항
      안녕하세요. 저는 온라인 영화 예매 서비스를 기획하고 있는 담당자입니다. 
      저희는 고객들이 쉽고 빠르게 원하는 영화를 예매할 수 있는 시스템을 구축하려 합니다.
      회원은 아이디, 이름, 생년월일, 이메일, 휴대폰 번호, 비밀번호, 가입일이 필요하고,
      영화는 제목, 장르, 상영 시간(분), 개봉일, 배우, 관람 등급이 필요합니다.
      상영관에는 총 좌석 수가 필요하고, 하나의 상영관에는 여러 좌석이 있으며 좌석 번호가 있습니다. 
      상영 일정에는 어떤 상영관에서 어떤 영화가 언제 개봉하는지 알 수 있어야 합니다.
      회원은 좌석 여러 개를 예매할 수 있으며, 상영일정을 고르고 좌석까지 골라야 합니다. */

create table tbl_member(
	id bigint unsigned primary key,
	member_id varchar(255) not null,
	member_name varchar(255) not null,
	member_birth date not null,
	member_email varchar(255) not null,
	member_phone varchar(255) not null,
	member_password varchar(255) not null,
	created_datetime datetime default current_timestamp()
);

create table tbl_film(
	id bigint unsigned primary key,
	film_title varchar(255) not null,
	film_runtime varchar(255) not null,
	film_open_date date not null,
	film_required_age int default 0
);

create table tbl_genre(
	id bigint unsigned primary key,
	genre_name varchar(255) not null
);

create table tbl_film_genre(
	id bigint unsigned primary key,
	film_id bigint unsigned not null,
	genre_id bigint unsigned not null,
	constraint fk_film_genre_film foreign key(film_id)
	references tbl_film(id),
	constraint fk_film_genre_genre foreign key(genre_id)
	references tbl_genre(id)
);

create table tbl_actor(
	id bigint unsigned primary key,
	actor_name varchar(255) not null,
	actor_birth date not null
);

create table tbl_film_actor(
	id bigint unsigned primary key,
	film_id bigint unsigned not null,
	actor_id bigint unsigned not null,
	constraint fk_film_actor_film foreign key(film_id)
	references tbl_film(id),
	constraint fk_film_actor_actor foreign key(actor_id)
	references tbl_actor(id)
);

create table tbl_screen(
	id bigint unsigned primary key,
	screen_seat_count int default 0,
	screen_location varchar(255) not null
);

create table tbl_seat(
	id bigint unsigned primary key,
	seat_number varchar(255) not null,
	screen_id bigint unsigned not null,
	constraint fk_seat_screen foreign key(screen_id)
	references tbl_screen(id)
);

create table tbl_schedule(
	id bigint unsigned primary key,
	start_time datetime,
	film_id bigint unsigned not null,
	screen_id bigint unsigned not null,
	constraint fk_schedule_film foreign key(film_id)
	references tbl_film(id),
	constraint fk_schedule_screen foreign key(screen_id)
	references tbl_screen(id)
);

create table tbl_booking(
	id bigint unsigned primary key,
	booking_payment int not null,
	booking_status enum('active', 'inactive') default 'active',
	member_id bigint unsigned not null,
	schedule_id bigint unsigned not null,
	created_datetime datetime default current_timestamp(),
	constraint fk_booking_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_booking_schedule foreign key(schedule_id)
	references tbl_schedule(id)
);

create table tbl_booking_seat(
	id bigint unsigned primary key,
	booking_id bigint unsigned not null,
	seat_id bigint unsigned not null,
	constraint fk_booking_seat_booking foreign key(booking_id)
	references tbl_booking(id),
	constraint fk_booking_seat_seat foreign key(seat_id)
	references tbl_seat(id)
);
/*1. 요구사항
	저희는 환자들의 진료 예약부터 진료 기록까지 전 과정을 효율적으로 관리할 수 있는 시스템이 필요합니다.
	환자는 환자 번호, 이름, 생년월일, 성별, 주소, 연락처가 필요하고,
	의사는 의사 번호, 이름, 전문 분야, 연락처, 입사일이 필요합니다.
	환자는 정해진 의사에게 예약하여 진료를 받습니다.
	예약에 필요한 정보는 예약 번호, 예약 날짜, 진료 상태(완료, 취소, 대기), 예약 신청 날짜입니다.
	예약이 완료되면 진료실이 배정되고, 진료 기록이 남아야 합니다. 
	진료기록에는 진단 내용, 진료 일시가 필요합니다.*/
create table tbl_patient(
	id bigint unsigned primary key,
	patient_name varchar(255) not null,
	patient_birth date not null,
	patient_gender enum('M', 'W') not null,
	patient_address varchar(255) not null,
	patient_address_detail varchar(255) not null,
	patient_phone varchar(255) not null
);
create table tbl_doctor(
	id bigint unsigned primary key,
	doctor_name varchar(255) not null,
	doctor_major varchar(255) not null,
	doctor_phone varchar(255) not null,
	doctor_joining_date date
);

create table tbl_room(
	id bigint unsigned primary key,
	room_location varchar(255) not null 
);

create table tbl_appointment(
	id bigint unsigned primary key,
	appointment_date date not null,
	appointment_status enum('done', 'cancel', 'wait') default 'wait',
	created_datetime datetime default current_timestamp(),
	patient_id bigint unsigned not null,
	doctor_id bigint unsigned not null,
	room_id bigint unsigned not null,
	constraint fk_appointment_patient foreign key(patient_id)
	references tbl_patient(id),
	constraint fk_appointment_doctor foreign key(doctor_id)
	references tbl_doctor(id),
	constraint fk_appointment_room foreign key(room_id)
	references tbl_room(id)
);

create table tbl_medical_record(
	id bigint unsigned primary key,
	medical_record_content text not null,
	medical_record_datetime datetime,
	appointment_id bigint unsigned not null,
	constraint fk_medical_record_appointment foreign key(appointment_id)
	references tbl_appointment(id)
);

/*
1. 요구사항
	저는 사용자들에게 편리하게 항공편을 검색하고 좌석을 예약하는 시스템을 구축하고자 합니다. 
	이 시스템은 다수의 공항과 항공편, 그리고 여러명의 승객을 관리할 수 있어야 합니다.
	고객은 회원 번호, 이름, 국적, 여권 번호, 이메일이 필요하고,
	공항은 공항 코드, 공항 이름, 도시, 국가가 필요합니다.
	항공편은 항공편 번호, 항공사 이름, 총 좌석 수, 출발 시각, 도착 시각, 출발 공항, 도착 공항이 필요합니다.
	항공편은 좌석등급이 있고, 등급 코드, 등급 이름, 가격 가중치(배수)가 있습니다.
	고객은 여러번 예약할 수 있으며, 하나의 예약에는 여러 승객이 포함될 수 있습니다.
	좌석 배정에는 배정 번호, 예약 번호, 승객 번호, 항공편 번호, 좌석 번호가 필요합니다.*/

/*1.사용자가 있다. 2.항공편이 있다.(여러개) 3.공항이 있다(여러개) 4.항공편과 공항은 다대다
 * 5.항공편(비행기)에는 좌석수가 있다. 6.좌석등급이 있다 등급에따라 예약할때 가격이 달라진다.
 * 7.좌석이 있다. 좌석번호가 있다(A-14 등) 8.사용자가 예약을 할때 여러승객 예약이 가능하다. 9.사용자는 여러번 예약이 가능하다.
 * 10.항공편과 공항은 다대다. 11.멤버와 예약은 다대다. 항공편과 예약은 다대다*/
/*create table tbl_member(
	id bigint unsigned primary key,
	member_name varchar(255) not null,
	member_nationality varchar(255) not null,
	member_passport int unsigned not null,
	member_email varchar(255) not null
);

create table tbl_airport(
	id bigint unsigned primary key,
	airport_code varchar(255) not null,
	airport_name varchar(255) not null,
	airport_loaction_city varchar(255) not null,
	airport_location_state varchar(255) not null
);

create table tbl_flight(
	id bigint unsigned primary key,
	flight_number varchar(255) not null,
	airline_name varchar(255) not null,
	flight_seat_count int default 0,
	departure_time datetime not null,
	arrival_time datetime not null,
	departure_airport_id bigint unsigned not null,
	arrival_airport_id bigint unsigned not null,
	constraint fk_flight_departure_airport foreign key(departure_airport_id)
	references tbl_airport(id),
	constraint fk_flight_arrival_airport foreign key(arrival_airport_id)
	references tbl_airport(id)
);

create table tbl_seat_class(
	id bigint unsigned primary key,
	class_code varchar(255) not null,
	class_name varchar(255) not null,
	class_weight decimal(3,2) not null
);

create table tbl_seat(
	id bigint unsigned primary key,
	seat_number varchar(255) not null,
	flight_id bigint unsigned not null,
	constraint fk_seat_flight foreign key(flight_id)
	references tbl_flight(id)
);

create table tbl_passenger(
	id bigint unsigned primary key,
	passenger_name varchar(255) not null,
	passenger_passport varchar(255) not null,
	passenger_address varchar(255) not null,
	passenger_address_detail varchar(255) not null,
	member_id bigint unsigned not null,
	booking_id bigint unsigned not null,
	constraint fk_passenger_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_passenger_booking foreign key(booking_id)
	references tbl_booking(id)
);

create table tbl_booking(
	id bigint unsigned primary key,
	booking_payment int not null,
	booking_status enum('active', 'inactive') default 'active',
	created_time datetime default current_timestamp(),
	member_id bigint unsigned not null,
	flight_id bigint unsigned not null,
	class_id bigint unsigned not null,
	constraint fk_booking_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_booking_flight foreign key(flight_id)
	references tbl_flight(id),
	constraint fk_booking_seat_class foreign key(class_id)
	references tbl_seat_class(id)
);

create table tbl_seat_assignment(
	id bigint unsigned primary key,
	booking_id bigint unsigned not null,
	passenger_id bigint unsigned not null,
   	flight_id bigint unsigned not null,
   	seat_id bigint unsigned not null,
	constraint fk_seat_assign_booking foreign key(booking_id)
	references tbl_booking(id),
	constraint fk_seat_assign_passenger foreign key(passenger_id)
	references tbl_passenger(id),
	constraint fk_seat_assign_flight foreign key(flight_id)
	references tbl_flight(id),
	constraint fk_seat_assign_seat foreign key(seat_id)
	references tbl_seat(id)
);*/
create table tbl_customer(
   id bigint unsigned primary key,
   customer_name varchar(255) not null,
   customer_nation varchar(255) not null,
   customer_passport_id varchar(255) not null,
   customer_email varchar(255) not null
);

create table tbl_airport(
   id bigint unsigned primary key,
   airport_number varchar(255) not null,
   airport_name varchar(255) not null,
   airport_location varchar(255) not null,
   airport_nation varchar(255) not null
);

create table tbl_flight(
   id bigint unsigned primary key,
   flight_number varchar(255) not null,
   flight_name varchar(255) not null,
   flight_seat_count int default 0,
   departure_datetime datetime not null,
   arrival_datetime datetime not null,
   departure_airport_id bigint unsigned not null,
   arrival_airport_id bigint unsigned not null,
   constraint fk_flight_departure_airport foreign key(departure_airport_id)
   references tbl_airport(id),
   constraint fk_flight_arrival_airport foreign key(arrival_airport_id)
   references tbl_airport(id)
);

create table tbl_seat_class(
   id bigint unsigned primary key,
   seat_class_code varchar(255) not null,
   seat_class_name varchar(255) not null,
   seat_price_weight decimal(3, 2) not null
);

create table tbl_reservation(
   id bigint unsigned primary key,
   reservation_price int not null,
   customer_id bigint unsigned not null,
   constraint fk_reservation_customer foreign key(customer_id)
   references tbl_customer(id)
);

create table tbl_passenger(
   id bigint unsigned primary key,
   passenger_name varchar(255) not null,
   passenger_passport_id varchar(255) not null,
   passenger_email varchar(255) not null,
   reservation_id bigint unsigned not null,
   constraint fk_passenger_reservation foreign key(reservation_id)
   references tbl_reservation(id)
);

create table tbl_seat_assignment(
   id bigint unsigned primary key,
   flight_id bigint unsigned not null,
   seat_class_id bigint unsigned not null,
   constraint fk_seat_assignment_passenger foreign key(id)
   references tbl_passenger(id),
   constraint fk_seat_assignment_flight foreign key(flight_id)
   references tbl_flight(id),
   constraint fk_seat_assignment_seat_class foreign key(seat_class_id)
   references tbl_seat_class(id)
);