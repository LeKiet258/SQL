create database QL_TOANHA
go

use QL_TOANHA
go

create table TOANHA
(
	MaToaNha nvarchar(5),
	TenToaNha nvarchar(100),
	LoaiToaNha nvarchar(100),
	DonGia float,
	ToTruong nvarchar(5)

	constraint PK_TN
	primary key(MaToaNha)
)

create table CANHO
(
	MaCanHo nvarchar(5),
	DienTich float,
	SoTang int,
	MaToaNha nvarchar(5),
	ChuHo nvarchar(5)

	constraint PK_CH
	primary key(MaCanHo)
)

create table CUDAN
(
	SoHieuCuDan nvarchar(5),
	MaToaNha nvarchar(5),
	HoTen nvarchar(100),
	NgaySinh date,
	GioiTinh bit, --0: nam, 1: nữ
	MaCanHo nvarchar(5)

	constraint PK_CD
	primary key(SoHieuCuDan, MaToaNha)
)

--add FK
alter table TOANHA
add
	constraint FK_TN_CD
	foreign key(ToTruong, MaToaNha)
	references CUDAN

alter table CANHO
add
	constraint FK_CH_CD
	foreign key(ChuHo, MaToaNha)
	references CUDAN

alter table CUDAN
add 
	constraint FK_CD_TN
	foreign key(MaToaNha)
	references TOANHA,
	
	constraint FK_CD_CH
	foreign key(MaCanHo)
	references CANHO

--add data: TN -> CD -> update TN
insert into TOANHA
values
(N'A', N'Tòa A', N'Chung cư', 1000.0, null),
(N'B', N'Tòa B', N'Nhà tập thể', 550.0, null),
(N'C', N'Tòa C', N'Ký túc xá sinh viên', 2100.0, null)

insert into CUDAN
values
(N'001', N'A', N'Nguyễn Văn A', '08/25/2001', 0, null),
(N'002', N'B', N'Nguyễn Văn B', '12/12/1996', 1, null),
(N'003', N'C', N'Nguyễn Văn C', '04/06/2965', 0, null)

update TOANHA set ToTruong = N'Nguyễn Văn A' where MaToaNha = N'A'
update TOANHA set ToTruong = N'Nguyễn Văn B' where MaToaNha = N'B'
update TOANHA set ToTruong = N'Nguyễn Văn C' where MaToaNha = N'C'

insert into CANHO
values
(N'CH1', 1234.5, 12, N'A', N'002'),
(N'CH2', 1111.5, 10, N'B', N'001'),
(N'CH3', 2323.5, 13, N'C', N'003')












