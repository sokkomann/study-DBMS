# DBMS

## 목차

**MySQL**
1. [MySQL 소개와 기초 문법](#01-mysql-소개와-기초-문법)
2. [RDBMS와 제약조건](#02-rdbms와-제약조건)
3. [자료형과 DDL](#03-자료형과-ddl)
4. [무결성과 모델링](#04-무결성과-모델링)
5. [정규화](#05-정규화)
6. [DML과 조건식](#06-dml과-조건식)
7. [JOIN](#07-join)
8. [TCL (트랜잭션)](#08-tcl-트랜잭션)
9. [View](#09-view)

**PostgreSQL**

10. [PostgreSQL 소개와 MySQL 비교](#10-postgresql-소개와-mysql-비교)
11. [PostgreSQL 자료형 · ENUM · 시퀀스](#11-postgresql-자료형--enum--시퀀스)

**Redis**

12. [Redis 소개와 활용](#12-redis-소개와-활용)

---

## 01. MySQL 소개와 기초 문법

### MySQL

웹 사이트와 다양한 애플리케이션에서 사용되며, **간결성·빠른 속도·쉬운 관리**가 핵심인 DBMS이다.
블로그, 게시판 등 읽기 작업이 쓰기 작업보다 훨씬 많고 빠른 응답 속도가 중요한 경우에 선택한다.
문법이 간결하고 메모리 사용량이 낮아 부담 없이 사용할 수 있다.
(복잡한 쿼리 및 분석 쿼리 비율이 높으면 PostgreSQL을 선택한다)

| 규모 | 선택 |
|------|------|
| 웹 (소~중규모) | MySQL |
| 웹 (중~대규모) + AI | PostgreSQL |
| 웹 (초대규모, 고가) | Oracle |

### 기초 문법 (계정 · 데이터베이스)

```sql
-- 로그인
mysql -u root -p

show databases;                  -- 데이터베이스 목록
create database [DB명];          -- 생성
use [DB명];                      -- 선택

-- 계정
select user, host from user;     -- 계정 목록
create user '계정'@localhost identified by '비밀번호';  -- 로컬 전용
create user '계정'@'%' identified by '비밀번호';        -- 원격 허용
set password for '계정'@'%' = '신규비밀번호';            -- 비밀번호 변경
drop user '계정'@localhost;                              -- 삭제

-- 권한
grant all privileges on *.* to '계정'@'%' with grant option;
flush privileges;                -- 권한 명령어 확정
```

> IDE는 **DBeaver**를 사용했다.

---

## 02. RDBMS와 제약조건

### DBMS의 소통 방식

사용자 ↔ 응용프로그램(고객 관리, 주문 관리 등) ↔ **DBMS** ↔ 데이터.

### RDBMS (관계형 데이터베이스 시스템)

데이터를 표(Table) 구조로 관리한다.

- **Column (열, 속성, 필드)**: 공통된 주제를 가지는 값들.
- **Row (행, 튜플, 레코드)**: 하나의 정보로 본다.

### 대표적인 제약조건

- **Primary Key (PK)**: 고유한 값. 각 행의 구분점. 중복 불가, NULL 불가.
- **Foreign Key (FK)**: 다른 테이블의 PK. 테이블 간 관계를 맺을 때 사용. 중복·NULL 가능.
- **Unique Key (UK)**: NULL은 허용하지만 중복은 불가. (PK는 아니지만 중복되지 않는 값)

> **복습 노트 — FK의 진짜 용도**
> FK는 따라가서 정보를 알아내는 용도가 아니라, **이 데이터가 누구의 것인지 명시하는 용도**다.
> 한 테이블만 조회해도 핵심 정보(FK)를 가져올 수 있게 해 준다.
> (영화-장르, 영화-배우처럼 다대다 관계는 중간 테이블로 풀어낸다)

---

## 03. 자료형과 DDL

### 컴파일 언어와 스크립트 언어

- **컴파일 언어**: 파일 단위로 해석(일괄 처리). 수정이 거의 없을 때 효율적. 주로 서버.
- **스크립트 언어**: 한 줄 단위로 해석(개별 처리). 잦은 수정에 효율적. AI·데이터 분석·화면. (**SQL이 스크립트 언어**)

### SQL문(쿼리문)의 종류

**DDL, DML, DCL, TCL** — 실무에서는 주로 **DML, TCL**을 쓴다.

### 자료형

| 분류 | 타입 |
|------|------|
| 정수 | `tinyint`, `smallint`, `mediumint`, `int`, `bigint` |
| 실수 | `decimal(m, d)` — m자리 정수, d자리 소수점 |
| 날짜 | `date`, `time`, `datetime` |
| 문자 | `char(m)` 고정 길이(주민번호 등) / `varchar(m)` 가변 길이(주로 사용) |

### DDL (Data Definition Language, 데이터 정의어)

테이블 조작·제어 관련 쿼리문. (실무에서는 거의 쓰지 않음)

```sql
-- create
create table [테이블명] ([컬럼명] [자료형(용량)] [제약조건], ...);

-- alter
alter table [테이블명] rename [새 테이블명];
alter table [테이블명] add [컬럼명] [자료형] [제약조건];          -- 맨 뒤 추가
alter table [테이블명] add [컬럼명] [자료형] after [기존 컬럼명];  -- 지정 위치 추가
alter table [테이블명] drop [컬럼명];                             -- 컬럼 삭제
alter table [테이블명] change [기존컬럼] [새컬럼] [타입];          -- 컬럼명 변경
alter table [테이블명] modify [컬럼명] [새 타입];                  -- 타입 변경

-- drop / truncate
drop table [테이블명];
truncate table [테이블명];
```

### 실습 — FK로 연결된 테이블 설계

```sql
create table tbl_zoo(
    id bigint primary key,
    zoo_name varchar(255) not null,
    zoo_max_capacity int check(zoo_max_capacity > 0)
);

create table animal(
    id bigint primary key,
    animal_name varchar(255) not null,
    animal_age int default 0,
    zoo_id bigint not null,
    constraint fk_animal_zoo foreign key(zoo_id) references tbl_zoo(id)
);
```

---

## 04. 무결성과 모델링

### 무결성

데이터의 **정확성·일관성·유효성**이 유지되는 것.

1. **개체 무결성**: 모든 테이블은 PK로 선택된 컬럼을 가져야 한다.
2. **참조 무결성**: 두 테이블의 데이터가 항상 일관된 값을 가지도록 유지한다.
3. **도메인 무결성**: 컬럼의 타입·NULL 허용 등을 정의하고 올바른 데이터가 입력됐는지 확인한다.

### 모델링 (기획)

추상적인 주제를 RDB에 맞게 설계하는 작업.

1. **요구사항 분석**: 예) 회원, 주문, 상품 3가지를 관리한다.
2. **개념적 설계**: 엔터티와 속성을 도출한다.
3. **논리적 설계**: PK / FK / Unique / Not Null / Default 등 제약을 부여한다.
4. **물리적 설계**: 실제 테이블명·컬럼명·자료형으로 구체화한다. (`tbl_member`, `id bigint`, `member_email varchar(255)` ...)
5. **구현**

> **실습 — 실무형 테이블 설계 패턴** (jdbc 스크립트)
> 실제 회원/게시글 테이블에는 다음 패턴을 적용했다.
> - `enum`으로 값 제한: `member_gender enum('남','여','선택안함')`
> - **소프트 딜리트**: `member_status enum('disable','enable') default 'enable'` (실제 삭제 대신 상태로 관리)
> - **생성·수정 시각**: `created_datetime`, `updated_datetime datetime default current_timestamp()`

---

## 05. 정규화

> 정규화는 약속이다.

삽입/수정/삭제 **이상(Anomaly) 현상**을 제거하기 위한 작업으로, **중복 데이터 최소화**가 목적이다.
5차까지 있지만 보통 **3차 정규화까지** 진행한다.

- **1차 정규화**: 같은 내용의 컬럼이 반복될 때(예: `상품명1, 상품명2, 상품명3`) 한 컬럼으로 풀어낸다.
- **2차 정규화**: 조합키(복합키)로 구성된 경우, 조합키의 **일부에만 종속**되는 속성(부분 종속)을 분리한다.
- **3차 정규화**: PK가 아닌 일반 컬럼이 다른 컬럼을 결정하는 **이행 종속**(X→Y→Z)을 제거한다. (단, Unique Key는 대상이 아니다)

### 이상 현상의 종류

1. **삽입 이상**: 새 데이터를 넣기 위해 불필요한 데이터까지 넣어야 하는 문제.
2. **갱신 이상**: 중복 행 중 일부만 변경되어 데이터가 불일치하는 문제.
3. **삭제 이상**: 행을 삭제할 때 꼭 필요한 데이터까지 함께 삭제되는 문제.

---

## 06. DML과 조건식

### DML (Data Manipulation Language, 데이터 조작어)

```sql
-- select : 조회
select [컬럼1], [컬럼2], ...
from [테이블명]
where [조건식];

-- insert : 추가
insert into [테이블명] ([컬럼1], [컬럼2], ...) values([값1], [값2], ...);  -- 컬럼 선택(미전달 시 default)
insert into [테이블명] values([값1], [값2], ...);                         -- 전체 값

-- update : 수정
update [테이블명] set [컬럼1] = [값1], ... where [조건식];

-- delete : 삭제
delete from [테이블명] where [조건식];
```

### 조건식 (where절)

- `>`, `<`, `>=`, `<=`, `=`
- `<>`, `!=`, `^=` : 같지 않다
- `and` : 둘 다 참이면 참 / `or` : 둘 중 하나라도 참이면 참

### 실습

```sql
-- 최대 수용 수가 5보다 큰 동물원 조회
select id, zoo_name, zoo_max_capacity from tbl_zoo where zoo_max_capacity > 5;

-- 1번 동물원의 동물 나이를 모두 1씩 증가
update tbl_animal set animal_age = animal_age + 1 where zoo_id = 1;
```

---

## 07. JOIN

여러 테이블에 흩어진 정보 중 필요한 것만 가져와 가상의 테이블로 만들어 보여주는 문법.
정규화로 테이블이 쪼개져 있을 때 한 번에 정보를 가져오기 위해 사용한다.

### 내부 조인 (Inner Join)

```sql
select *
from [선행 테이블] inner join [후행 테이블]
on [조건식];
```

- `on`절은 **합칠 때** 조건을 검사하고, `where`절은 **합친 후** 조건을 검사한다.
- **등가 조인**: `on`절 조건식에 등호(`=`)가 있는 조인. (대부분 이것)
- **비등가 조인**: `on`절 조건식에 등호가 없는 조인.

### 외부 조인 (Outer Join)

조건이 일치하지 않아도 원하는 테이블은 모두 조회한다.

```sql
[선행] left outer join [후행] on [조건식];   -- 선행 테이블 전체 조회
[선행] right outer join [후행] on [조건식];  -- 후행 테이블 전체 조회
```

---

## 08. TCL (트랜잭션)

### 트랜잭션 (Transaction)

하나의 서비스를 위한 **DML의 묶음(작업 단위)**.
예) "상품 구매 시 포인트 적립" 서비스는 `INSERT`(구매)와 `UPDATE`(적립)가 한 트랜잭션이다.
`INSERT`는 성공했지만 `UPDATE`에서 문제가 생기면 `INSERT`도 되돌려야 하므로 TCL이 필요하다.

```sql
commit;     -- 현재 트랜잭션의 모든 작업을 확정 (오류 없으면 실행, 되돌릴 수 없음)
rollback;   -- 직전 커밋 지점으로 되돌리기 (오류 나면 실행)
```

> **DML만 가능**하고 DDL은 해당 사항이 없다.
> `delete`(DML)는 rollback으로 복구되지만, `truncate`(DDL)는 복구되지 않는다.
> 따라서 DDL(`create`, `drop`, `alter`, `truncate`)은 신중히 작성해야 한다.

---

## 09. View

정규화로 나뉜 테이블들을 join해서 만든 **가상의 테이블**을 저장해 두고 조회용으로 쓰는 기능.
실제 데이터가 저장되는 것은 아니지만 View를 통해 데이터를 관리할 수 있다. (추가·수정·삭제 말고 **조회만** 한다)

- **독립성**: 다른 곳에서 접근하지 못하게 한다.
- **편리성**: 긴 쿼리문을 짧게 만든다.
- **보안성**: 기존 쿼리문이 남에게 보이지 않는다.

```sql
create view [뷰 이름] as (select 쿼리문);
create or replace view [뷰 이름] as (select 쿼리문);  -- 생성 또는 수정

-- 실습: 회원-게시글을 join한 View
create view view_post_member as (
    select p.*, m.member_name
    from tbl_member m join tbl_post p on m.id = p.member_id
);
```

---

## 10. PostgreSQL 소개와 MySQL 비교

### PostgreSQL

웹 서비스·빅데이터 등 다양한 분야에서 널리 쓰이는 오픈소스 DBMS.
Oracle과 유사한 기능을 많이 포함하며 ANSI SQL 표준을 거의 완벽히 지원한다.
복잡한 쿼리 처리와 확장 기능에 강하고, 데이터 무결성·트랜잭션 관리에 매우 강력하다.

### PostgreSQL vs MySQL

| | PostgreSQL | MySQL |
|---|------------|-------|
| 지향 | **기능 중심** | **속도 중심** |
| 강점 | 복잡한 연산·대용량 처리, 사용자 정의 타입 | 조회 속도, 단순 구조 웹 서비스 |
| 확장 | `pgvector`로 벡터 임베딩 저장, **HNSW** 벡터 검색 | 표준 자료형에 충실 |

> **HNSW (Hierarchical Navigable Small World)**: 지름길이 있는 여러 층의 지도를 이용해 수억 개의 데이터 사이를 순식간에 가로질러 정답을 찾는 벡터 검색 알고리즘. → 단어가 달라도 맥락(방향)이 비슷하면 결과로 출력 가능하다.

### 기초 문법

```sql
psql -U postgres -d postgres
create user [사용자] with password '[비밀번호]';
create database [DB명];
alter user [사용자] with superuser;

\l            -- 데이터베이스 목록
\c [DB명]     -- 데이터베이스 접속
\du           -- 계정 목록
```

---

## 11. PostgreSQL 자료형 · ENUM · 시퀀스

### 자료형 (MySQL과 차이점 위주)

| 분류 | 타입 |
|------|------|
| 정수 | `smallint`, `integer`/`int`, `bigint` |
| 실수 | `real`, `double precision`, `numeric(전체, 소수)` |
| 문자 | `char`, `varchar`, **`text`**(길이 제한 없음). 문자열 연결은 `||` |
| 날짜/시간 | `date`, `time`, `timestamp`, **`timestamptz`**(timezone 포함) |
| 논리 | `boolean` |

```sql
set timezone = 'Asia/Seoul';                              -- 최초 1회
select to_char(now(), 'YYYY-MM-DD HH24:MI:SS');           -- 날짜 → 문자열
select to_date('2025-09-22', 'YYYY-MM-DD');               -- 문자열 → 날짜
```

### ENUM

특정 컬럼에 허용될 고정된 문자열 목록을 정의하는 자료형.
MySQL은 `enum('값1','값2')`로 바로 쓰지만, **PostgreSQL은 사용자 정의 타입으로 별도 생성**한다.

```sql
create type gender as enum('남', '여');
alter type gender add value '선택안함';   -- 추가 (부분 삭제는 불가, 전체 삭제 후 재생성)
```

### 시퀀스 (자동 증가)

```sql
id int generated always as identity primary key;      -- 직접 값 삽입 제한
id int generated by default as identity primary key;  -- 직접 삽입 가능, 없으면 자동 증가
```

---

## 12. Redis 소개와 활용

### Redis (Remote Dictionary Server)

빠른 속도의 **메모리 기반 키-값 저장소**로, 주로 캐시·세션 저장·토큰 관리에 활용된다.
이를 **인메모리(in-memory) 데이터베이스**(= 캐싱)라고 한다.

### 사용 목적

- 매우 빠른 읽기/쓰기 속도 (메모리 기반)
- 데이터 만료 기능 (**TTL**) 지원
- 분산 시스템에 적합 (트래픽이 몰릴 때 분산된 서버 간 세션 통합)
- 여러 데이터 타입 지원 (문자열, 리스트, 해시, 집합 등)

### 활용

1. **분산 시스템 환경에서의 세션 공유**
2. **토큰 무효화**: 로그아웃·강제 로그아웃 시 토큰을 블랙리스트에 저장해 무효화한다.
3. **캐싱**: DB 조회 결과나 외부 API 호출 결과 등 비용이 큰 작업을 저장해 빠르게 응답한다.
