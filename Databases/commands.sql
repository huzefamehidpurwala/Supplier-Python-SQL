DROP DATABASE IF EXISTS spj;
    CREATE DATABASE spj;

USE spj;

create table supplier (SNO varchar(5) Primary key, SNAME varchar(25) NOT NULL, STATUS int NOT NULL, CITY varchar(20) NOT NULL);

create table part (PNO varchar(6) Primary key, PNAME varchar(25) NOT NULL, COLOR varchar(10) NOT NULL, WEIGHT numeric(5, 1) NOT NULL, CITY varchar(20) NOT NULL);

create table project (JNO varchar(6) Primary key, JNAME varchar(25) NOT NULL, CITY varchar(20) NOT NULL);

create table shipment (SNO varchar(6) NOT NULL, PNO varchar(6) NOT NULL, JNO varchar(6) NOT NULL, QTY int NOT NULL, foreign key (SNO) references supplier(SNO), foreign key (PNO) references part(PNO), foreign key (JNO) references project(JNO));
