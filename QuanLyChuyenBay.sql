CREATE DATABASE QLCB;

GO

USE QLCB;

GO

CREATE TABLE KHACHHANG
(
MAKH NCHAR(15) ,
TEN NCHAR(15),
DCHI NCHAR(50),
DTHOAI NCHAR(12),
PRIMARY KEY (MAKH)
)

CREATE TABLE NHANVIEN
(
MANV NCHAR(15),
TEN NCHAR(15),
DCHI NCHAR(50),
DTHOAI NCHAR(12),
LUONG FLOAT,
LOAINV BIT,
PRIMARY KEY (MANV)
)

CREATE TABLE LOAIMB
(
MALOAI NCHAR(15),
HANGSX NCHAR(15),
PRIMARY KEY (MALOAI)
)

CREATE TABLE MAYBAY
(
SOHIEU INT,
MALOAI NCHAR(15)
PRIMARY KEY (SOHIEU,MALOAI)
)

CREATE TABLE CHUYENBAY
(
MACB NCHAR(4),
SBDI NCHAR(3),
SBDEN NCHAR(3),
GIODI TIME,
GIODEN TIME
PRIMARY KEY (MACB)
)

CREATE TABLE LICHBAY
(
NGAYDI DATE,
MACB NCHAR(4),
SOHIEU INT,
MALOAI NCHAR(15)
PRIMARY KEY(NGAYDI,MACB)
)

CREATE TABLE DATCHO
(
MAKH NCHAR(15),
NGAYDI DATE,
MACB NCHAR(4)
PRIMARY KEY (MAKH,NGAYDI,MACB)
)

CREATE TABLE KHANANG
(
MANV NCHAR(15),
MALOAI NCHAR(15)
PRIMARY KEY (MANV, MALOAI)
)

CREATE TABLE PHANCONG
(
MANV NCHAR(15),
NGAYDI DATE,
MACB NCHAR(4)
PRIMARY KEY (MANV,NGAYDI,MACB)
)

ALTER TABLE LICHBAY
ADD CONSTRAINT FK_LICHBAY_CHUYENBAY
FOREIGN KEY (MACB)
REFERENCES CHUYENBAY(MACB)

ALTER TABLE LICHBAY
ADD CONSTRAINT FK_LICHBAY_MAYBAY
FOREIGN KEY (SOHIEU,MALOAI)
REFERENCES MAYBAY(SOHIEU,MALOAI)

ALTER TABLE	DATCHO
ADD CONSTRAINT FK_DATCHO_KHACHHANG
FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH)

ALTER TABLE	DATCHO
ADD CONSTRAINT FK_DATCHO_LICHBAY
FOREIGN KEY (NGAYDI,MACB)
REFERENCES LICHBAY(NGAYDI,MACB)

ALTER TABLE MAYBAY
ADD CONSTRAINT FK_MAYBAY_LOAIMB
FOREIGN KEY (MALOAI)
REFERENCES LOAIMB(MALOAI)

ALTER TABLE KHANANG
ADD CONSTRAINT FK_KHANANG_LOAIMB
FOREIGN KEY (MALOAI)
REFERENCES LOAIMB(MALOAI)

ALTER TABLE KHANANG
ADD CONSTRAINT FK_KHANANG_NHANVIEN
FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_LICHBAY
FOREIGN KEY (NGAYDI,MACB)
REFERENCES LICHBAY(NGAYDI,MACB)

INSERT INTO NHANVIEN(MANV,TEN,DCHI,DTHOAI,LUONG,LOAINV)
VALUES 
('1006','Chi','12/6	Nguyen Kiem','8120012',150000,0),
('1005','Giao','65 Nguyen Thai Son','8324467',500000,0),
('1001','Huong','8 Dien Bien Phu','8330733',500000,1),
('1002','Phong','1 Ly Thuong Kiet','8308117',450000,1),
('1004','Phuong','351 Lac Long Quan','8308155',250000,0),   	 
('1003','Quang','78 Truong Dinh','8324461',350000,1),
('1007','Tam','36 Nguyen Van Cu','8458188',500000,0)

INSERT INTO KHACHHANG(MAKH,TEN,DCHI,DTHOAI)
VALUES
('0009','Nga','223 Nguyen Trai','8932320'),   
('0101','Anh','567 Tran	Phu','8826729'),
('0045','Thu','285 Le Loi','8932203'), 	    
('0012','Ha','435 Quang Trung','8933232'),    
('0238','Hung','456 Pasteur','9812101'),
('0397','Thanh','234 Le Van Si','8952943'),   
('0582','Mai','789 Nguyen Du',null),
('0934 ','Minh','678 Le Lai',null),
('0091','Hai','345 Hung Vuong','8893223'),     
('0314','Phuong','395 Vo Van Tan','8232320'),   
('0613','Vu','348 CMT8','8343232'),    
('0586','Son','123 Bach Dang','8556223'),
('0422','Tien','75 Nguyen Thong','8332222')  
 

INSERT INTO LOAIMB(HANGSX,MALOAI)
VALUES
('Airbus','A310'),
('Airbus','A320'),
('Airbus','A330'),
('Airbus','A340'),
('Boeing','B747'),
('Boeing','B727'),
('Boeing','B757'),
('MD','DC10'),
('MD','DC9')

INSERT INTO KHANANG(MANV,MALOAI)
VALUES
('1001','B727'),
('1001','B747'),
('1001','DC10'),
('1001','DC9'),
('1002','A320'),
('1002','A340'),
('1002','B757'),
('1002','DC9'),
('1003','A310'),
('1003','DC9')
 
INSERT INTO MAYBAY(SOHIEU,MALOAI)
VALUES
(10,'B747'),
(11,'B727'),
(13,'B727'),
(13,'B747'),
(21,'DC10'),
(21,'DC9'),
(22,'B757'),
(22,'DC9'),
(23,'DC9'),
(24,'DC9'),
(70,'A310'),
(80,'A310'),
(93,'B757')
	 
INSERT INTO CHUYENBAY(MACB,SBDI,SBDEN,GIODI,GIODEN)
VALUES
('100','SLC','BOS','08:00','17:50'),
('112','DCA','DEN','14:00','18:07'),
('121','STL','SLC','07:00','09:13'),
('122','STL','YYV','08:30','10:19'),
('206','DFW','STL','09:00','11:40'),
('330','JFK','YYV','16:00','18:53'),
('334','ORD','MIA','12:00','14:14'),
('335','MIA','ORD','15:00','17:14'),
('336','ORD','MIA','18:00','20:14'),
('337','MIA','ORD','20:30','23:53'),
('394','DFW','MIA','19:00','21:30'),
('395','MIA','DFW','21:00','23:43'),
('449','CDG','DEN','10:00','19:29'),
('930','YYV','DCA','13:00','16:10'),
('931','DCA','YYV','17:00','18:10'),
('932','DCA','YYV','18:00','19:10'),
('991','BOS','ORD','17:00','18:22')

INSERT INTO LICHBAY(NGAYDI,MACB,SOHIEU,MALOAI)
VALUES
('11/1/2000','100',80,'A310'),
('11/1/2000','112',21,'DC10'),
('11/1/2000','206',22,'DC9'),
('11/1/2000','334',10,'B747'),
('11/1/2000','395',23,'DC9'),
('11/1/2000','991',22,'B757'),
('11/01/2000','337',10,'B747'),
('10/31/2000','100',11,'B727'),
('10/31/2000','112',11,'B727'),
('10/31/2000','206',13,'B727'),
('10/31/2000','334',10,'B747'),
('10/31/2000','335',10,'B747'),
('10/31/2000','337',24,'DC9'),
('10/31/2000','449',70,'A310')

INSERT INTO DATCHO(MAKH,NGAYDI,MACB)
VALUES
('0009','11/01/2000','100'),
('0009','10/31/2000','449'),
('0045','11/01/2000','991'),
('0012','10/31/2000','206'),
('0238','10/31/2000','334'),
('0582','11/01/2000','991'),
('0091','11/01/2000','100'),
('0314','10/31/2000','449'),
('0613','11/01/2000','100'),
('0586','11/01/2000','991'),
('0586','10/31/2000','100'),
('0422','10/31/2000','449')

INSERT INTO PHANCONG(MANV,NGAYDI,MACB)
VALUES
('1001','11/01/2000','100'),
('1001','10/31/2000','100'),
('1002','11/01/2000','100'),
('1002','10/31/2000','100'),
('1003','10/31/2000','100'),
('1003','10/31/2000','337'),
('1004','10/31/2000','100'),
('1004','10/31/2000','337'),
('1005','10/31/2000','337'),
('1006','11/01/2000','991'),
('1006','10/31/2000','337'),
('1007','11/01/2000','112'),
('1007','11/01/2000','991'),
('1007','10/31/2000','206');

GO