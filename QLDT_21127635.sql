create database DB_QLDeTai_21127635
go
use DB_QLDeTai_21127635
go

create table GIAOVIEN
(
	MAGV char(3) not null,
	HOTEN nvarchar(15),
	LUONG float(1),
	PHAI nchar(3),
	NGSINH date,
	DIACHI nvarchar(40),
	GVQLCM char(3),
	MABM nchar(4),
	primary key (MAGV)
)

create table BOMON
(
	MABM nchar(4) not null,
	TENBM nvarchar(20),
	PHONG char(3),
	DIENTHOAI char(10),
	TRUONGBM char(3),
	MAKHOA char(4),
	NGAYNHANCHUC date
	primary key(MABM)
)

create table NGUOITHAN
(
	MAGV char(3) not null,
	TEN nvarchar(10) not null,
	NGSINH datetime,
	PHAI nchar(3)
	primary key (MAGV,TEN)
)

create table KHOA
(
	MAKHOA char(4) not null,
	TENKHOA nvarchar(20),
	NAMTL char(4),
	PHONG char(3),
	DIENTHOAI char(10),
	TRUONGKHOA char(3),
	NGAYNHANCHUC date
	primary key (MAKHOA)
)

create table CHUDE
(
	MACD nchar(4) not null,
	TENCD nvarchar(25)
	primary key (MACD)
)

create table DETAI
(
	MADT char(3) not null,
	TENDT nvarchar(45),
	CAPQL nvarchar(10),
	KINHPHI float(1),
	NGAYBD date,
	NGAYKT date,
	MACD nchar(4),
	GVCNDT char(3)
	primary key (MADT)
)

create table CONGVIEC
(
	MADT char(3) not null,
	SOTT int not null,
	TENCV nvarchar(30),
	NGAYBD date,
	NGAYKT date
	primary key (MADT,SOTT)
)

create table THAMGIADT
(
	MAGV char(3) not null,
	MADT char(3) not null,
	STT int not null,
	PHUCAP float(1),
	KETQUA nchar(5)
	primary key (MAGV,MADT,STT)
)

create table GV_DT
(
	MAGV char(3) not null,
	DIENTHOAI char(10) not null
	primary key (MAGV,DIENTHOAI)
)
alter table GIAOVIEN
add check (PHAI IN('Nam',N'Nữ'))

alter table NGUOITHAN
add check (PHAI IN('Nam',N'Nữ'))

alter table DETAI
add check (NGAYBD <= NGAYKT)

alter table CONGVIEC
add check (NGAYBD <= NGAYKT)

alter table THAMGIADT
add check (KETQUA IN (N'Đạt',NULL))

alter table GIAOVIEN
add foreign key (GVQLCM) references GIAOVIEN(MAGV)

alter table GIAOVIEN
add foreign key (MABM) references BOMON(MABM)

alter table BOMON
add foreign key (TRUONGBM) references GIAOVIEN(MAGV)

alter table BOMON
add foreign key (MAKHOA) references KHOA(MAKHOA)

alter table KHOA
add foreign key (TRUONGKHOA) references GIAOVIEN(MAGV)

alter table THAMGIADT
add foreign key (MAGV) references GIAOVIEN(MAGV)

alter table THAMGIADT
add foreign key (MADT,STT) references CONGVIEC(MADT,SOTT)

alter table CONGVIEC
add foreign key (MADT) references DETAI(MADT)

alter table DETAI
add foreign key (GVCNDT) references GIAOVIEN(MAGV)

alter table DETAI
add foreign key (MACD) references CHUDE(MACD)

alter table NGUOITHAN
add foreign key (MAGV) references GIAOVIEN(MAGV)

alter table GV_DT
add foreign key (MAGV) references GIAOVIEN(MAGV)

insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('001',N'Nguyễn Hoài An', 2000.0,N'Nam','1973/02/15',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('002',N'Trần Trà Hương', 2500.0,N'Nữ','1960/06/20',N'125 Trần Hưng Đạo, Q.1,TP HCM',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('003',N'Nguyễn Ngọc Ánh', 2200.0,N'Nữ','1975/05/11',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('004',N'Trương Nam Sơn', 2300.0,N'Nam','1959/06/20',N'215 Lý Thường Kiệt,TP Biên Hòa',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('005',N'Lý Hoàng Hà', 2500.0,N'Nam','1954/10/23',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('006',N'Trần Bạch Tuyết', 1500.0,N'Nữ','1980/05/20',N'127 Hùng Vương, Tp Mỹ Tho',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('007',N'Nguyễn An Trung', 2100.0,N'Nam','1976/06/05',N'234 3/2, TP Biên Hòa',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('008',N'Trần Trung Hiếu', 1800.0,N'Nam','1977/08/06',N'22/11 Lý Thường Kiệt, TP Mỹ Tho',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('009',N'Trần Hoàng Nam', 2000.0,N'Nam','1975/11/22',N'234 Trần Não, An Phú,TP HCM',NULL,NULL)
insert into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM)
values ('010',N'Phạm Nam Thanh', 1500.0,N'Nam','1980/12/12',N'221 Hùng Vương, Q.5, TP HCM',NULL,NULL)

insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,NULL,NULL)
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'HHC',N'Hóa hữu cơ','B44','838222222',NULL,NULL,NULL)
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'HL',N'Hóa lý','B42','0838878787',NULL,NULL,NULL)
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'HPT',N'Hóa phân tích','B43','0838777777','007',NULL,'2007/10/15')
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'HTTT',N'Hệ thống thông tin','B13','0838125125','002',NULL,'2004/09/20')
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'MMT',N'Mạng máy tính','B16','0838676767','001',NULL,'2005/05/15')
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'SH',N'Sinh hóa','B33','0838898989',NULL,NULL,NULL)
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'VLĐT',N'Vật lý điện tử','B23','0838234234',NULL,NULL,NULL)
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'VLƯD',N'Vật lý ứng dụng','B24','0838454545','005',NULL,'2006/02/18')
insert into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
values (N'VS',N'Vi sinh','B32','0838909090','004',NULL,'2007/01/01')

insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('001',N'Hùng','1990/01/14',N'Nam')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('001',N'Thủy','1994/12/08',N'Nữ')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('003',N'Hà','1998/09/03',N'Nữ')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('003',N'Thu','1998/09/03',N'Nữ')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('007',N'Mai','2003/03/26',N'Nữ')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('007',N'Vy','2000/02/14',N'Nữ')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('008',N'Nam','1991/05/06',N'Nam')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('009',N'An','1996/08/19',N'Nam')
insert into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
values ('010',N'Nguyệt','2006/01/14',N'Nữ')

insert into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
values ('CNTT',N'Công nghệ thông tin','1995','B11','0838123456','002','2005/02/20')
insert into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
values ('HH',N'Hóa học','1980','B41','0838456456','007','2001/10/15')
insert into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
values ('SH',N'Sinh học','1980','B31','0838454545','004','2000/10/11')
insert into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
values ('VL',N'Vật lý','1976','B21','0838223223','005','2003/09/18')

insert into CHUDE(MACD,TENCD)
values (N'NCPT',N'Nghiên cứu phát triển')
insert into CHUDE(MACD,TENCD)
values (N'QLGD',N'Quản lý giáo dục')
insert into CHUDE(MACD,TENCD)
values (N'ƯDCN',N'Ứng dụng công nghệ')

insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20.0,'2007/10/20','2008/10/20',N'QLGD','002')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('002',N'HTT quản lý giáo vụ cho một Khoa',N'Trường',20.0,'2000/10/12','2001/10/12',N'QLGD','002')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300.0,'2008/05/15','2010/05/15',N'NCPT','005')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100.0,'2007/01/01','2009/12/31',N'NCPT','004')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('005',N'Ứng dụng hóa học xanh',N'Trường',200.0,'2003/10/10','2004/12/10',N'ƯDCN','007')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000.0,'2006/10/20','2009/10/20',N'NCPT','004')
insert into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
values ('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20.0,'2009/05/10','2010/05/10',N'QLGD','001')

insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('001',1,N'Khởi tạo và Lập kế hoạch','2007/10/20','2008/12/20')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('001',2,N'Xác định yêu cầu','2008/12/21','2008/03/21')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('001',3,N'Phân tích hệ thống','2008/03/22','2008/05/22')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('001',4,N'Thiết kế hệ thống','2008/05/23','2008/06/23')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('001',5,N'Cài đặt thử nghiệm','2008/06/24','2008/10/20')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('002',1,N'Khởi tạo và Lập kế hoạch','2009/05/10','2009/07/10')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('002',2,N'Xác định yêu cầu','2009/07/11','2009/10/11')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('002',3,N'Phân tích hệ thông','2009/10/12','2009/12/20')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('002',4,N'Thiết kế hệ thống','2009/12/21','2010/03/22')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('002',5,N'Cài đặt thử nghiệm','2010/03/23','2010/05/10')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('006',1,N'Lấy mẫu','2006/10/20','2007/02/20')
insert into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
values ('006',2,N'Nuôi cấy','2007/02/21','2008/08/21')

insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('001','002','1',0.0,NULL)
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('001','002','2',2.0,NULL)
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('002','001','4',2.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('003','001','1',1.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('003','001','2',0.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('003','001','4',1.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('003','002','2',0.0,NULL)
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('004','006','1',0.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('004','006','2',1.0,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('006','006','2',1.5,N'Đạt')
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('009','002','3',0.5,NULL)
insert into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
values ('009','002','4',1.5,NULL)

insert into GV_DT(MAGV,DIENTHOAI)
values ('001','0123456789')
insert into GV_DT(MAGV,DIENTHOAI)
values ('002','0987654321')
insert into GV_DT(MAGV,DIENTHOAI)
values ('003','0567891234')
insert into GV_DT(MAGV,DIENTHOAI)
values ('004','0123456987')
insert into GV_DT(MAGV,DIENTHOAI)
values ('005','0987612345')
insert into GV_DT(MAGV,DIENTHOAI)
values ('006','0923415678')
insert into GV_DT(MAGV,DIENTHOAI)
values ('007','0231457689')
insert into GV_DT(MAGV,DIENTHOAI)
values ('008','0978645312')
insert into GV_DT(MAGV,DIENTHOAI)
values ('009','0192837465')
insert into GV_DT(MAGV,DIENTHOAI)
values ('010','0912873465')

update GIAOVIEN
set MABM = 'MMT'
where MAGV = '001'
update GIAOVIEN
set MABM = 'HTTT'
where MAGV = '002'
update GIAOVIEN
set MABM = 'HTTT',GVQLCM = '002'
where MAGV = '003'
update GIAOVIEN
set MABM = 'VS'
where MAGV = '004'
update GIAOVIEN
set MABM = N'VLĐT'
where MAGV = '005'
update GIAOVIEN
set MABM = 'VS',GVQLCM = '004'
where MAGV = '006'
update GIAOVIEN
set MABM = 'HPT'
where MAGV = '007'
update GIAOVIEN
set MABM = 'HPT',GVQLCM = '007'
where MAGV = '008'
update GIAOVIEN
set MABM = 'MMT',GVQLCM = '001'
where MAGV = '009'
update GIAOVIEN
set GVQLCM = '007',MABM = 'HPT'
where MAGV = '010'


update BOMON
set MAKHOA = 'CNTT'
where MABM = N'CNTT'
update BOMON
set MAKHOA = 'HH'
where MABM = N'HHC'
update BOMON
set MAKHOA = 'HH'
where MABM = N'HL'
update BOMON
set MAKHOA = 'HH'
where MABM = N'HPT'
update BOMON
set MAKHOA = 'CNTT'
where MABM = N'HTTT'
update BOMON
set MAKHOA = 'CNTT'
where MABM = 'MMT'
update BOMON
set MAKHOA = 'SH'
where MABM = N'SH'
update BOMON
set MAKHOA = 'VL'
where MABM = N'VLĐT'
update BOMON
set MAKHOA = 'VL'
where MABM = N'VLƯD'
update BOMON
set MAKHOA = 'SH'
where MABM = N'VS'

SELECT GV.HOTEN , GV.LUONG
FROM GIAOVIEN GV
WHERE GV.PHAI = N'Nữ'

SELECT GV.HOTEN , GV.LUONG*1.1 AS LUONG
FROM GIAOVIEN GV

SELECT GV.MAGV
FROM GIAOVIEN GV
WHERE GV.HOTEN LIKE N'Nguyễn%' and GV.LUONG > 2000
union
select bm.TRUONGBM
from BOMON bm
where year(bm.NGAYNHANCHUC) > 1995

SELECT GV.HOTEN
FROM GIAOVIEN GV,BOMON BM, KHOA K
WHERE GV.MABM = BM.MABM AND BM.MAKHOA=K.MAKHOA AND K.TENKHOA = N'Công nghệ thông tin'

SELECT*
FROM BOMON BM, GIAOVIEN GV 
WHERE BM.TRUONGBM = GV.MAGV AND BM.MABM = GV.MABM AND BM.TRUONGBM IS NOT NULL

SELECT DISTINCT BM.MABM,BM.TENBM,BM.PHONG,BM.DIENTHOAI,BM.TRUONGBM,BM.MAKHOA,BM.NGAYNHANCHUC
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MABM = BM.MABM

SELECT DISTINCT DT.TENDT , GV.HOTEN
FROM DETAI DT, GIAOVIEN GV
WHERE DT.GVCNDT = GV.MAGV

SELECT K.TENKHOA, GV.HOTEN AS TRUONGKHOA
FROM KHOA K, GIAOVIEN GV
WHERE K.TRUONGKHOA = GV.MAGV

SELECT GV.MAGV
FROM BOMON BM, GIAOVIEN GV 
WHERE BM.TENBM = N'Vi sinh' AND GV.MABM = BM.MABM
INTERSECT
SELECT TG.MAGV 
FROM THAMGIADT TG
WHERE TG.MADT = '006'

SELECT DT.MADT, CD.TENCD, GV.HOTEN, GV.NGSINH, GV.DIACHI
FROM DETAI DT, CHUDE CD, GIAOVIEN GV
WHERE DT.CAPQL = N'ĐHQG' AND DT.MACD = CD.MACD AND DT.GVCNDT = GV.MAGV

SELECT GV.HOTEN,GVPT.HOTEN AS GVPT
FROM GIAOVIEN GV, GIAOVIEN GVPT
WHERE GV.GVQLCM IS NOT NULL AND GV.GVQLCM = GVPT.MAGV

SELECT GV.HOTEN
FROM GIAOVIEN GV, GIAOVIEN GVPT
WHERE GVPT.HOTEN = N'Nguyễn An Trung' and GV.GVQLCM = GVPT.MAGV

SELECT GV.HOTEN
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MAGV = BM.TRUONGBM AND BM.TENBM = N'Hệ thống thông tin'

SELECT DISTINCT GV.HOTEN
FROM GIAOVIEN GV, DETAI DT, CHUDE CD
WHERE DT.GVCNDT = GV.MAGV AND DT.MACD = CD.MACD AND CD.TENCD = N'Quản lý giáo dục'

SELECT DISTINCT CV.TENCV
FROM CONGVIEC CV, DETAI DT
WHERE CV.MADT = DT.MADT AND DT.TENDT LIKE N'HTTT%'  AND DT.CAPQL = N'ĐHQG' AND DATEPART(MM,DT.NGAYBD) = 10 AND DATEPART(YYYY,DT.NGAYBD) = 2007


SELECT CV.TENCV 
FROM CONGVIEC CV
WHERE CV.NGAYBD < '2008/08/01' AND CV.NGAYBD > '2008/01/01'

SELECT GV.HOTEN
FROM GIAOVIEN GV, GIAOVIEN TTH
WHERE TTH.HOTEN = N'Trần Trà Hương' AND TTH.MABM = GV.MABM AND GV.HOTEN NOT LIKE N'Trần Trà Hương'


SELECT BM.TRUONGBM
FROM BOMON BM
WHERE BM.TRUONGBM IS NOT NULL
INTERSECT
SELECT DT.GVCNDT
FROM DETAI DT

SELECT GV.HOTEN, GV.MAGV
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MAGV = BM.TRUONGBM
INTERSECT
SELECT GV.HOTEN, GV.MAGV
FROM GIAOVIEN GV, KHOA K
WHERE K.TRUONGKHOA = GV.MAGV


SELECT GV.HOTEN, GV.MAGV
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MAGV = BM.TRUONGBM
UNION
SELECT GV.HOTEN, GV.MAGV
FROM GIAOVIEN GV, DETAI DT
WHERE DT.GVCNDT = GV.MAGV
