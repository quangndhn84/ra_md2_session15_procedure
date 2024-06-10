create database Students_Management_DB;
use Students_Management_DB;
create table Student(
    student_id int primary key auto_increment,
    student_name varchar(100) not null,
    age int check(age>=18),
    address text,
    student_status bit
);
insert into student(student_name, age, address, student_status)
VALUES('Nguyễn Văn A',20,'Hà nội',1),('Nguyễn Văn B',18,'Đà Nẵng',1);
select * from student;
-- 1. Viết procedure cho phép lấy thông tin tất cả sinh viên
DELIMITER &&
create procedure get_all_students(
    -- Các tham số vào/ra của procedure
    -- IN-OUT parameterName datatype  (mặc định hiểu là IN)
    -- Tham số ra đặc biệt là resultset
)
BEGIN
    select * from student;
end &&
DELIMITER &&;
call get_all_students();
-- 2. Viết procedure cho phép thêm mới 1 sinh viên
DELIMITER &&
Create procedure create_student(
    name_in varchar(100),
    age_in int,
    address_in text,
    status_in bit
)
BEGIN
    insert into Student(student_name, age, address, student_status)
        values (name_in,age_in,address_in,status_in);
end &&
DELIMITER &&
call create_student('Nguyễn Văn C',22,'HCM',1);
-- Viết procedure cho phép cập nhật thông tin 1 sinh viên
DELIMITER &&
create procedure update_Student(
    id_in int,
    name_in varchar(100),
    age_in int,
    address_in text,
    status_in bit
)
BEGIN
    update student
        set student_name = name_in,
            age = age_in,
            address = address_in,
            student_status = status_in
    where student_id = id_in;
end &&
DELIMITER &&
call update_Student(3,'Nguyễn Đức Chiến',25,'Hồ Chí Minh',0);
-- 4. viết procedure cho phép xóa 1 sinh viên theo mã sinh viên
DELIMITER &&
create procedure delete_student(
    id_in int
)
BEGIN
    delete from student where student_id = id_in;
end &&
DELIMITER &&
call delete_student(3);
-- 5. Viết procedure cho phép tính tổng số sinh viên trong khoảng từ a đến b tuổi
DELIMITER &&
create procedure get_cnt_students(
    from_age int,
    to_age int,
    out cnt_student int
)
BEGIN
    set cnt_student = (select count(s.student_id) from student s where s.age between from_age and to_age);
end &&
DELIMITER &&;
call get_cnt_students(20,25,@cnt);
select @cnt;
-- 6. Viết procedure cho phép lấy thông tin sinh viên theo mã sinh viên
DELIMITER &&
create procedure get_Student_by_Id(
    id_in int
)
BEGIN
    select * from student where student_id = id_in;
end &&
DELIMITER &&
call get_Student_by_Id(1);
/*
    Sử dụng intellij kết nối CSDL và thực các công việc sau:
    1. Tạo Database BookManagement
    2. Sử dụng BookManagement để tạo các bảng:
        - Bảng BookType gồm các thông: Mã danh mục sách (char(5) - PK), Tên danh muc sách, trạng thái danh mục sách (Hoạt động - Không hoạt động)
        - Bảng Book gồm các thông tin
            + Mã sách - int - PK - auto_increment
            + Tên sách - varchar(100),not null unique
            + Giá sách - float, >0
            + Tác giả - varchar(200),
            + Nhà xuất bản - varchar(200)
            + Năm xuất bản - int
            + Mã danh mục sách - char(5) - FK (BookType)
            + Trạng thái sách - bit (Hoạt động - Không hoạt động)
    3. Viết các procedure sau và thực hiện gọi các procedure
        - Viết procedure cho phép lấy danh sách danh mục sách
        - Viết procedure cho phép thêm mới danh mục sách
        - Viết procedure cho phép cập nhật danh mục sách
        - Viết procedure cho phép xóa danh mục sách nếu danh mục sách chưa chứa quyển sách nào
        - Viết procedure cho phép lấy thông tin danh mục sách theo mã danh mục
        - Viết procedure cho phép lấy danh sách các sách
        - Viết procedure cho phép thêm mới sách
        - Viết procedure cho phép cập nhật sách
        - Viết procedure cho phép xóa sách
        - Viết procedure cho phép lấy thông tin sách theo mã sách
        - Viết procedure cho phép thống kê số lượng sách theo tác giả
        - Viết procedure cho phép thống kê số lượng sách trong khoảng giá a-b

*/