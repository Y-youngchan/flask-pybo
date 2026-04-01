# 데이터 베이스 생성
create database class character set utf8 collate utf8_general_ci;

# 데이터 베이스 조회
show databases;

# 데이터 베이스 삭제
drop database class;

# 데이터 베이스 선택
use class;

# 테이블 생성
create table students (
	id tinyint primary key auto_increment not null,
    name char(4) not null,
    gender enum('남자','여자') not null,
    address varchar(50) not null,
    birthday datetime not null
);

# 테이블 리스트 보기
show tables;

# 테이블 스키마 열람
desc students;

# 테이블 삭제
drop table students;








