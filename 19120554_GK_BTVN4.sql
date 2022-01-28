create database DIEM_THAM_QUAN
go

use DIEM_THAM_QUAN
go

create table TINH_THANH
(
	QuocGia nvarchar(5),
	MaTinhThanh nvarchar(5),
	DanSo int,
	DienTich float,
	TenTT nvarchar(30)

	constraint PK_TT
	primary key(MaTinhThanh, QuocGia)
)

create table DIEM_THAM_QUAN
(
	MaDTQ nvarchar(10),
	TenDTQ nvarchar(10),
	TinhThanh nvarchar(5),
	QuocGia nvarchar(5),
	DacDiem nvarchar(50)

	constraint PK_DTQ
	primary key(MaDTQ)
)

create table QUOC_GIA
(
	MaQG nvarchar(5),
	TenQG nvarchar(20),
	ThuDo nvarchar(5),
	DanSo int,
	DienTich float

	constraint PK_QG
	primary key(MaQG)
)

--add FK
alter table TINH_THANH
add 
	constraint FK_TT_QG
	foreign key(QuocGia)
	references QUOC_GIA

alter table DIEM_THAM_QUAN
add 
	constraint FK_DTQ_TT
	foreign key(TinhThanh, QuocGia)
	references TINH_THANH

alter table QUOC_GIA
add 
	constraint FK_QG_TT
	foreign key(ThuDo, MaQG)
	references TINH_THANH

--thêm data: QG -> TT -> update QG -> DTQ
insert into QUOC_GIA
values 
(N'QG001', N'Việt Nam', NULL, 115000000, 331688.00),
(N'QG002', N'Nhật Bản', NULL, 129500000, 337834.00)

insert into TINH_THANH
values
(N'QG001', N'TT001', 2500000, 927.39, N'Hà Nội'),
(N'QG001', N'TT002', 5344000, 5009.00, N'Huế'),
(N'QG002', N'TT003', 12084000, 2187.00, N'Tokyo')

update QUOC_GIA set ThuDo = N'TT001' where MaQG = N'QG001'
update QUOC_GIA set ThuDo = N'TT003' where MaQG = N'QG002'

insert into DIEM_THAM_QUAN
values
(N'DTQ001', N'Văn Miếu', N'TT001', N'QG001', N'Di tích cổ'),
(N'DTQ002', N'Hoàng Lăng', N'TT002', N'QG001', N'Di tích cổ'),
(N'DTQ003', N'Tháp Tokyo', N'TT003', N'QG002', N'Công trình hiện đại')

select * from QUOC_GIA
select * from TINH_THANH
select * from DIEM_THAM_QUAN

--Q4
select dtq.MaDTQ, dtq.TenDTQ
from DIEM_THAM_QUAN dtq, TINH_THANH tt, QUOC_GIA qg
where dtq.TinhThanh = tt.MaTinhThanh and tt.QuocGia = qg.MaQG and dtq.QuocGia = tt.QuocGia
	and tt.DienTich > 0.01*qg.DienTich

--Q5
select qg.MaQG, qg.TenQG
from QUOC_GIA qg, TINH_THANH tt
where tt.QuocGia = qg.MaQG
group by qg.MaQG, qg.TenQG
having count(*) > 30



