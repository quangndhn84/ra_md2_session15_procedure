create database QuanLySinhVien;
use QuanLySinhVien;
create table Class(
    classId int primary key auto_increment,
    className varchar(100) not null unique,
    startDate datetime,
    classStatus bit
);
create table Student(
    studentId char(5) primary key,
    studentName varchar(100) not null,
    address text,
    phone varchar(25),
    studentStatus bit,
    classId int,
    foreign key(classId) references Class(classId)
);
create table Subjects(
    subId char(5) primary key,
    subName varchar(100) not null,
    credit int,
    subStatus bit
);
create table Mark(
    markId char(5) primary key,
    subId char(5) not null,
    foreign key(subId) references Subjects(subId),
    studentId char(5) not null,
    foreign key(studentId) references Student(studentId),
    mark int,
    examTime datetime
);

insert into Class(className,startDate,classStatus)
values('JV240219','2022-05-05',1),('JV240403','2023-12-10',1),('JV240408','2024-04-08',1),('JS230913','2024-06-09',0);
select * from Class;

insert into Student
values('SV001','Nguyễn Văn A','Hà Nội','0385689522',1,1),
('SV002','Hoàng Văn B','Đà Nẵng','0365486254',1,2),
('SV003','Nguyễn Văn C','Hà Tĩnh','0865242356',1,3),
('SV004','Nguyễn Thị Hường','Hà Nội','0362345688',0,4),
('SV005','Hồ Văn Hòa','HCM','0345542563',1,1),
('SV006','Trần Văn Tình','Hà Nội','0852356655',0,2),
('SV007','Nguyễn Văn Hùng','Hà Tĩnh','0398556254',1,3);
select * from Student;

insert into Subjects(subId,subName,credit,subStatus)
values('SJ01','Java',3,1),('SJ02','Frontent',2,0),('SJ03','Backend',4,1),('SJ04','C++',5,1),('SJ05','NoteJs',1,0);
select * from Subjects;

insert into Mark(markId,subId,studentId,mark,examTime)
values('M1','SJ02','SV001',6,'2024-6-10'),('M2','SJ01','SV002',9,'2024-6-9'),('M3','SJ04','SV003',7,'2024-6-8'),('M4','SJ03','SV004',8,'2024-5-6');
select * from Mark;
-- 1. Hiển thị các thông tin của môn học có credit lớn nhất
-- 1.1. Lấy ra môn học có tín chỉ cao nhất
-- 1.2. Lấy thông tin các môn học có tín chỉ bằng với tín chỉ cao nhất
select *
from subjects sb
where sb.credit in (select max(s.credit) as 'MaxCredit'
from subjects s);

-- 2. Lấy thông tin các môn có điểm thi lớn nhất
-- 2.1. Lấy điểm thi lớn nhất
-- 2.2. Lấy thông tin môn học có điểm thi là lớn nhất
select * 
from subjects s join mark mk on s.subid = mk.subid
where mk.mark in (select max(m.mark) as 'MaxMark'
from mark m);
-- 3. Hiển thị thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo điểm trung bình giảm dần
select s.*, avg(m.mark) as 'avgMark'
from student s join mark m on s.studentId = m.studentId
group by m.studentid
order by avgMark DESC;

