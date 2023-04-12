create database DeThiThu
go
use DeThiThu
go

create table NHACUNGCAP
(
	MaNhaCC nchar(6),
	TenNhaCC nvarchar(30),
	DiaChi nvarchar(20),
	SoDT char(11),
	MaSoThue nchar(6)
	primary key (MaNhaCC)
)

create table LOAIDICHVU
(
	MaLoaiDV nchar(4),
	TenLoaiDV nvarchar(40),
	primary key(MaLoaiDV)
)

create table MUCPHI
(
	MaMP nchar(4),
	DonGia nchar(7),
	MoTa nvarchar(30),
	primary key(MaMp)
)

create table DONGXE
(
	DongXe nvarchar(20),
	HangXe nvarchar(15),
	SoChogoi int,
	primary key (DongXe)
)

create table 
(
	MaDKCC
)