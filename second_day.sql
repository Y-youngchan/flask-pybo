-- 테이블 레코드 조회
select * from students;

-- 컬럼 지정해서 조회
select name, birthday from students;

-- 조건에 해당하는 것 조회(조건절 : where)
select * from students where id=3;

select * from students where gender='남자' and address='서울';

select * from students where gender='여자' or address='서울';

-- limit로 조회할 행의 수를 제한
select * from students limit 4,3;

select * from students where gender='남자' limit 2,3;

-- distinct 중복을 제외하고 조회
select distinct gender from students;

select distinct address from students;

select * from students where id=2;
update students set address='서울' where id=2;


CREATE TABLE student (
  id tinyint(4) NOT NULL,
  name char(4) NOT NULL,
  gender enum('남자','여자') NOT NULL,
  address varchar(50) NOT NULL,
  distance INT NOT NULL,
  birthday datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO student VALUES (2, '박재숙', '남자', '서울',  10, '1985-10-26 00:00:00');

INSERT INTO student VALUES (1, '이숙경', '여자', '청주', 200, '1982-11-16 00:00:00');

INSERT INTO student VALUES (3, '백태호', '남자', '경주', 350, '1989-2-10 00:00:00');

INSERT INTO student VALUES (4, '김경훈', '남자', '제천', 190, '1979-11-4 00:00:00');

INSERT INTO student VALUES (8, '김정인', '남자', '대전', 200, '1990-10-1 00:00:00');

INSERT INTO student VALUES (6, '김경진', '여자', '제주', 400, '1985-1-1 00:00:00');

INSERT INTO student VALUES (7, '박경호', '남자', '영동', 310, '1981-2-3 00:00:00');

select * from student;

-- 그룹으로 묶어서 조회
select gender from student group by gender;

-- 그룹별 집계함수 적용
select gender, sum(distance) as sum, avg(distance) as avg from student group by gender;

-- order by : 정렬
select * from student order by distance desc;

select * from student order by distance desc, address asc;

-- 제약조건
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id tinyint(4) NOT NULL AUTO_INCREMENT,
  name char(4) NOT NULL,
  address varchar(50) NOT NULL,
  department enum('국문과','영문과','컴퓨터공학과','전자공학과','물리학과') NOT NULL,
  introduction text NOT NULL,
  number char(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY idx_number (number) USING BTREE,
  KEY idx_department (department),
  KEY idx_department_name (department,address),
  FULLTEXT KEY idx_introduction (introduction)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

select * from student;

INSERT INTO student VALUES (1, '이숙경', '청주', '컴퓨터공학과', '저는 컴퓨터 공학과에 다닙니다. computer', '0212031');
INSERT INTO student VALUES (2, '박재숙', '서울', '영문과', '저는 영문과에 다닙니다.', '0512321');
INSERT INTO student VALUES (3, '백태호', '경주', '컴퓨터공학과', '저는 컴퓨터 공학과에 다니고 경주에서 왔습니다.', '0913134');
INSERT INTO student VALUES (4, '김경훈', '제천', '국문과', '제천이 고향이고 국문과에 다닙니다.', '9813413');
INSERT INTO student VALUES (6, '김경진', '제주', '국문과', '이번에 국문과에 입학한 김경진이라고 합니다. 제주에서 왔어요.', '0534543');
INSERT INTO student VALUES (7, '박경호', '제주', '국문과', '박경호입니다. 잘 부탁드립니다.', '0134511');
INSERT INTO student VALUES (8, '김정인', '대전', '영문과', '김정인입니다. 대전에서 왔고, 영문과에 다닙니다.', '0034543');

-- primary key 조회 : 가장 빠르게 검색, 테이블에서 하나의 컬럼에만 지정 가능
select * from student where id=3;

-- unique key 조회 : 빠르게 검색, 테이블에서 여러개 컬럼 지정 가능
select * from student where number='0534543';

-- normal key 조회 : primary, unique보다 느림, 여러개 컬럼 지정 가능
select * from student where department='국문과';

-- fulltext key 조회 : 최서 4자이상의 문자열을 검색하여 조회
select introduction, match(introduction) against('영문과에')
from student
where match(introduction) against('영문과에');

-- 중복키 : 하나의 키에 여러개의 컬럼을 포함
select * from student where department='국문과' and address='제주';

-- 조인: 복수의 데이블을 하나의 테이블처럼 조회
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id tinyint(4) NOT NULL,
  name char(4) NOT NULL,
  gender enum('남자','여자') NOT NULL,
  location_id tinyint(4) NOT NULL,
  birthday datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS location;

CREATE TABLE location (
id  tinyint UNSIGNED NOT NULL AUTO_INCREMENT ,
name  varchar(20) NOT NULL ,
distance  tinyint UNSIGNED NOT NULL ,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO location VALUES (1, '서울', 10);
INSERT INTO location VALUES (2, '청주', 200);
INSERT INTO location VALUES (3, '경주', 255);
INSERT INTO location VALUES (4, '제천', 190);
INSERT INTO location VALUES (5, '대전', 200);
INSERT INTO location VALUES (6, '제주', 255);
INSERT INTO location VALUES (7, '영동', 255);
INSERT INTO location VALUES (8, '광주', 255);

INSERT INTO student VALUES (1, '이숙경', '여자', 1, '1982-11-16 00:00:00');
INSERT INTO student VALUES (2, '박재숙', '남자', 2, '1985-10-26 00:00:00');
INSERT INTO student VALUES (3, '백태호', '남자', 3, '1989-2-10 00:00:00');
INSERT INTO student VALUES (4, '김경훈', '남자', 4, '1979-11-4 00:00:00');
INSERT INTO student VALUES (6, '김경진', '여자', 5, '1985-1-1 00:00:00');
INSERT INTO student VALUES (7, '박경호', '남자', 6, '1981-2-3 00:00:00');
INSERT INTO student VALUES (8, '김정인', '남자', 5, '1990-10-1 00:00:00');

select * from student;
select * from location;

-- left join
select s.name, s.location_id, l.name as address, l.distance
from student as s left join location as l
on s.location_id = l.id;

-- right join
select s.name, s.location_id, l.name as address, l.distance
from student as s right join location as l
on s.location_id = l.id;

-- location테이블에 제주 삭제
select * from location where name='제주';
delete from location where name='제주';

-- outter join(left join)
select s.name, s.location_id, l.name as address, l.distance
from student as s left join location as l
on s.location_id = l.id;

-- inner join
select s.name, s.location_id, l.name as address, l.distance
from student as s inner join location as l
on s.location_id = l.id;












