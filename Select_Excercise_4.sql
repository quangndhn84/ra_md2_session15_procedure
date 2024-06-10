create database QLKho1;
use QLKho1;
create table vat_tu(
    maVT int primary key,
    tenVT varchar(50) not null unique
);

create table phieu_xuat(
    soPX int primary key unique,
    ngayXuat date not null
);

create table phieu_xuat_chi_tiet(
    soPX int,
    foreign key(soPX) references phieu_xuat(soPX),
    maVT int,
    foreign key(maVT) references vat_tu(maVT),
    don_gia_xuat float check(don_gia_xuat > 0),
    so_luong_xuat int check(so_luong_xuat > 0)
);

create table phieu_nhap(
    soPN int primary key unique,
    ngayNhap date not null
);

create table phieu_nhap_chi_tiet(
    soPN int,
    foreign key(soPN) references phieu_nhap(soPN),
    maVT int,
    foreign key(maVT) references vat_tu(maVT),
    don_gia_nhap float check(don_gia_nhap > 0),
    so_luong_nhap float check(so_luong_nhap > 0)
);

create table nha_cung_cap(
    maNCC int primary key unique,
    tenNCC varchar(100) not null unique,
    dia_chi text,
    so_dien_thoai text
);

create table don_dat_hang(
    soDH int primary key unique,
    ngayDH date not null,
    maNCC int,
    foreign key(maNCC) references nha_cung_cap(maNCC)
);

create table chi_tiet_don_dat_hang(
    maVT int,
    foreign key(maVT) references vat_tu(maVT),
    soDH int,
    foreign key(soDH) references don_dat_hang(soDH)
);

-- 1. Tìm danh sách vật tư bán chạy nhất
insert into vat_tu(mavt,tenvt)
values (1,'vật tư 1'),(2,'vật tư 2'),(3,'vật tư 3');
select * from vat_tu;
insert into phieu_xuat
values(1,'2024-06-10'),(2,'2024-06-09'),(3,'2024-06-08');
insert into phieu_xuat_chi_tiet
values(1,1,100,3),(1,2,50,5),(1,3,60,4),(2,1,110,8),(2,2,65,2),(3,1,105,6);

select vt.*, sum(pxct.so_luong_xuat) as 'maxXuat'
from vat_tu vt join phieu_xuat_chi_tiet pxct on vt.mavt = pxct.mavt
group by pxct.mavt
order by maxXuat DESC
limit 1;

-- 2. Tìm danh sách vật tư có trong kho nhiều nhất
insert into phieu_nhap
values(1,'2024-06-10'),(2,'2024-06-09');
insert into phieu_nhap
values(3,'2024-06-08');
insert into phieu_nhap_chi_tiet
values(1,1,50,10),(1,2,60,6),(1,3,70,5),(2,1,55,3),(2,2,70,7);
insert into phieu_nhap_chi_tiet
values(3,1,50,12);
select * from phieu_nhap_chi_tiet;
select * from phieu_xuat_chi_tiet;
select a.mavt,a.tenvt,a.slnhap,b.slxuat, (a.slnhap-b.slxuat) as 'TonKho'
from 
(select vt1.*,sum(pnct.so_luong_nhap) as 'SLNhap'
from phieu_nhap_chi_tiet pnct join vat_tu vt1 on pnct.mavt = vt1.mavt	
group by pnct.mavt) a join
(select vt2.*,sum(pxct.so_luong_xuat) as 'SLXuat'
from phieu_xuat_chi_tiet pxct join vat_tu vt2 on pxct.mavt = vt2.mavt
group by pxct.mavt) b on a.maVT = b.maVT
order by TonKho DESC
limit 1;
-- 3. Tìm danh sách nhà cung cấp có đơn hàng từ 12/2/2024 đến 22/2/2024
select ncc.*
from nha_cung_cap ncc join don_dat_hang ddh on  ncc.mancc = ddh.mancc
where ddh.ngaydh between '2024-02-12' and '2024-02-22';
-- 4. Tìm danh sách vật tư được mua ở nhà cung cấp từ ngày 11/1/2024 đến 22/2/2024
select vt.*
from vat_tu vt join chi_tiet_don_dat_hang ctdh on vt.mavt = ctdh.mavt
	join don_dat_hang dh on ctdh.sodh = dh.sodh
where dh.ngaydh between '2024-01-11' and '2024-02-22';





