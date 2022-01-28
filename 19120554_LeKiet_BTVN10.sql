/****************Phần 1: SP Tính toán (câu a --> câu i)****************/
USE QL_DETAI

--a
CREATE PROC helloWorld 
AS 
	print 'Hello World'
GO

EXEC helloWorld
GO 

--b: in tổng 2 số
CREATE PROC sp_inTong2So @so1 int, @so2 int
AS
	DECLARE @tong INT
    SET @tong = @so1 + @so2
	PRINT @tong 
GO 

EXEC dbo.sp_inTong2So 1,2
GO 

--c, tính tổng 2 số có trả về
CREATE PROC sp_tinhTong2So @so1 int, @so2 int, @res int OUT
AS
	SET @res = @so1 + @so2
GO 

DECLARE @sum INT 
EXEC sp_tinhTong2So 2,3, @sum OUT 
PRINT @sum
GO 

--d: in tong 3 so
CREATE PROC sp_inTong3So @a int, @b int, @c int 
AS 
	DECLARE @tong INT 
	EXEC dbo.sp_tinhTong2So @a, @b, @tong OUT 
	SET @tong = @tong + @c 
	PRINT @tong 
GO 

EXEC sp_inTong3So 1,2,3
GO

--e
CREATE PROC sp_tongMtoiN @m int, @n int
AS 
	DECLARE @res INT 
	DECLARE @i INT 

	SET @res = 0
	SET @i = @m

	WHILE(@i<=@n)
	BEGIN 
		SET @res = @res + @i
		SET @i=@i+1
	END 

	PRINT @res 
GO 

EXEC dbo.sp_tongMtoiN 3,5
GO 


--f
CREATE PROC sp_isPrime @n INT 
AS 
	IF(@n < 2)
		RETURN 0
	ELSE
    BEGIN 
		DECLARE @i INT 
		SET @i = 2

		WHILE(@i<@n)
		BEGIN
			IF(@n % @i = 0)
				RETURN 0 
			SET @i = @i +1
		END 
		RETURN 1
	END 
GO 

DECLARE @bien INT 
EXEC @bien = dbo.sp_isPrime 71 -- int
PRINT @bien
GO 

--g
CREATE PROC sp_tongNguyenTo @m INT, @n INT 
AS 
	DECLARE @tong INT 
	DECLARE @i INT 

	SET @tong = 0
	SET @i = @m

	WHILE(@i <= @n)
	BEGIN 
		DECLARE @bien INT
		EXEC @bien = dbo.sp_isPrime @i 
		IF(@bien = 1)
			SET @tong = @tong + @i
		set @i = @i + 1
	END 

	PRINT @tong 
GO 

EXEC dbo.sp_tongNguyenTo 1,5
GO 

--h
create proc sp_UCLN @a int, @b int
as 
	while(@b != 0)
	begin 
		declare @tmp int
		set @tmp = @a
		set @a = @b 
		set @b = @tmp % @b 
	end

	return @a
go

declare @bien int
exec @bien = sp_UCLN 12,20
print @bien
go

--i
create proc sp_BCNN @a int, @b int
as 
	declare @ret int
	declare @gcd int 

	exec @gcd = sp_UCLN @a, @b
	set @ret = @a * @b / @gcd 

	return @ret
go

declare @bien int
exec @bien = sp_BCNN 12,20
print @bien
go

/*******************Phần 2: SP QLDT (câu j --> câu t)****************/	
--j
create proc sp_DSGV 
as 
	select * from GIAOVIEN
go

exec sp_DSGV
go

--k
create proc sp_SLDT_1GV @magv VARCHAR(5)  
AS
	DECLARE @res INT
	SELECT @res = COUNT(DISTINCT tg.MADT)
	from THAMGIADT tg WHERE tg.MAGV = @magv
	GROUP BY tg.MAGV

	RETURN @res 
go

DECLARE @magv VARCHAR(5) = '009'
DECLARE @bien INT 
EXEC @bien = dbo.sp_SLDT_1GV @magv
PRINT 'SLDT cua giao vien co ma ' + @magv + ' la: ' + CAST(@bien AS VARCHAR)
go

--l
DROP PROC sp_inThongTinGV

CREATE PROC sp_inThongTinGV @magv varchar(5)
AS 
	DECLARE @hoten NVARCHAR(40), @luong FLOAT, @phai NVARCHAR(3), @ngaysinh DATETIME, @diachi NVARCHAR(100), @gvql VARCHAR(5), @mabm NVARCHAR(5)
	SELECT @hoten = gv.HOTEN, @luong = gv.LUONG, @phai = gv.PHAI, @ngaysinh = gv.NGSINH, @diachi = gv.DIACHI, @gvql = gv.GVQLCM, @mabm = gv.MABM
	FROM dbo.GIAOVIEN gv
	WHERE gv.MAGV = @magv
	PRINT 'Thong tin ca nhan cua gv ' + @magv + ' la: '
	PRINT 'ho ten: ' + @hoten
	PRINT 'luong: ' + CAST(@luong AS VARCHAR)
	PRINT 'phai: ' + @phai
	PRINT 'ngay sinh: ' + CAST(@ngaysinh AS VARCHAR)
	PRINT 'dia chi: ' + @diachi
	PRINT 'GVQLCM: ' + @gvql
	PRINT 'Ma bo mon: ' + @mabm

	DECLARE @sldt INT 
	EXEC @sldt = dbo.sp_SLDT_1GV @magv
	PRINT 'So luong de tai tham gia la: ' + CAST(@sldt AS VARCHAR)

	DECLARE @slnt INT 
	SELECT @slnt = COUNT(*)
	FROM dbo.NGUOITHAN nt WHERE nt.MAGV = @magv
	GROUP BY nt.MAGV

	PRINT 'So luong nguoi than la: ' + CAST(@slnt AS VARCHAR(5))
GO 

EXEC dbo.sp_inThongTinGV '001'
GO

--m
DROP PROC sp_KTtonTaiGV
CREATE PROC sp_KTtonTaiGV @magv VARCHAR(5), @res int out
AS
	IF(EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE MAGV = @magv))
	BEGIN 
		SET @res = 1
		PRINT 'GV co ton tai'
	END 
	ELSE 
	BEGIN 
		SET @res = 0
		PRINT 'GV khong ton tai'
	END 
GO 

DECLARE @bien INT 
EXEC dbo.sp_KTtonTaiGV '001', @bien OUT 
GO 

--n
DROP PROC sp_KTquyDinhGV
CREATE PROC sp_KTquyDinhGV @magv varchar(5), @res int OUT 
AS
	--@mabm = mabm cua @magv
	--voi moi detai tham gia, cndt.mabm = @mabm - DT, GV
	DECLARE @mabm NVARCHAR(5)
	SELECT @mabm = gv.MABM FROM dbo.GIAOVIEN gv WHERE gv.MAGV = @magv
	
	IF(EXISTS(
		SELECT *
		FROM dbo.DETAI dt, dbo.GIAOVIEN gv, dbo.THAMGIADT tg
		WHERE tg.MAGV = @magv AND tg.MADT = dt.MADT AND 
			dt.GVCNDT = gv.MAGV AND gv.MABM = @mabm)) --tim mabm cua gvcndt roi doi chieu voi gv tham gia dt
	BEGIN 
		SET @res = 1
		PRINT 'Hop le'
	END 
	ELSE 
	BEGIN 
		SET @res = 0
		PRINT 'Khong hop le'
	END 
go

DECLARE @bien int 
EXEC sp_KTquyDinhGV '003', @Bien out
GO 

--o
CREATE PROC sp_themPhanCong @magv VARCHAR(5), @cv_madt VARCHAR(3), @cv_stt INT 
AS
	DECLARE @gvTonTai INT, @gvHopLe INT 
	EXEC sp_KTtonTaiGV @magv, @gvTonTai out 
	EXEC sp_KTquyDinhGV @magv, @gvHopLe OUT 
	IF(@gvTonTai = 1 AND @gvHopLe = 1 AND EXISTS(
										SELECT * FROM dbo.CONGVIEC cv
										WHERE cv.MADT = @cv_madt AND cv.SOTT = @cv_stt))
	BEGIN 
		INSERT INTO dbo.THAMGIADT
		(MAGV, MADT, STT)
		VALUES
		(   @magv,  -- MAGV - varchar(5)
		    @cv_madt,  -- MADT - varchar(3)
		    @cv_stt   -- STT - int
		    )
	END 
GO 

--p
CREATE PROC sp_xoaGV @magv VARCHAR(5)
AS
	IF(EXISTS(SELECT * FROM dbo.NGUOITHAN WHERE MAGV = @magv) OR EXISTS(SELECT * FROM dbo.THAMGIADT tg WHERE tg.MAGV = @magv)
		OR EXISTS(SELECT * FROM dbo.GV_DT WHERE MAGV = @magv) OR EXISTS(SELECT * FROM dbo.DETAI WHERE GVCNDT = @magv)
		OR EXISTS(SELECT * FROM dbo.KHOA WHERE TRUONGKHOA = @magv))
			RAISERROR('khong the xoa gv vi co thong tin lien quan toi gv nay', 16, 1)
	ELSE 
		DELETE dbo.GIAOVIEN WHERE MAGV = @magv  
GO 

EXEC dbo.sp_xoaGV '007'

--r
CREATE PROC sp_KTLuong @magvA varchar(5), @magvB varchar(5)
AS
	IF(EXISTS(SELECT * FROM dbo.GIAOVIEN gv, dbo.BOMON bm, dbo.GIAOVIEN gvA
			WHERE bm.TRUONGBM = @magvA AND gv.MAGV = @magvB AND bm.MABM = gv.MABM 
				AND gvA.MAGV = @magvA AND gvA.LUONG > gv.LUONG))
		RETURN 1
	ELSE 
		RETURN 0
go

DECLARE @bien INT 
EXEC @bien = sp_KTLuong '002', '003'
PRINT @bien


--t
DROP PROC sp_maGvMoi
GO 

CREATE PROC sp_maGvMoi 
AS
	SELECT '0' + CAST(COUNT(*) + 1 AS VARCHAR(5)) FROM dbo.GIAOVIEN

GO 

EXEC dbo.sp_maGvMoi
GO 	

--s
DROP PROC sp_themGV
CREATE PROC sp_themGV @tengv nvarchar(40), @tuoi int, @luong int, @phai nvarchar(3)
AS
	IF(NOT EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE HOTEN = @tengv) AND @tuoi > 18 AND @luong > 0)
	BEGIN 
		INSERT INTO dbo.GIAOVIEN
		(
		    MAGV,
		    HOTEN,
		    LUONG,
		    PHAI,
		    NGSINH
		)
		VALUES
		(   (SELECT '0' + CAST(COUNT(*) + 1 AS VARCHAR(5)) FROM dbo.GIAOVIEN),        -- MAGV - varchar(5)
		    @tengv,       -- HOTEN - nvarchar(40)
		    @luong,       -- LUONG - float
		    @phai,       -- PHAI - nvarchar(3)
		    DATEDIFF(YEAR, GETDATE(), @tuoi) -- chi lay dc nam sinh
		    )
	END 
	ELSE 
		RAISERROR('khong the them gv do khong thoa cac quy dinh ve ten, tuoi, luong', 16, 1)
GO 

EXEC sp_themGV N'Lê Kiệt', 20, 1789.0, N'Nam'

--SELECT * FROM dbo.GIAOVIEN
--DELETE dbo.GIAOVIEN WHERE MAGV = '011'


/*******************Phần 3: QLKS****************/
--Tạo CSDL, tạo bảng và nhập liệu
CREATE DATABASE QLKS
USE QLKS

CREATE TABLE PHONG
(
	MaPhong varchar(5),
	TinhTrang NVARCHAR(10),
	LoaiPhong NVARCHAR(10),
	DonGia FLOAT 

	CONSTRAINT PK_PHONG
	PRIMARY KEY(MaPhong)
)

CREATE TABLE KHACH
(
	MaKH VARCHAR(5),
	HoTen NVARCHAR(50),
	DiaChi NVARCHAR(50),
	DienThoai VARCHAR(13)

	CONSTRAINT PK_KHACH
	PRIMARY KEY(MaKH)
)

CREATE TABLE DATPHONG
(
	Ma VARCHAR(5),
	MaKH VARCHAR(5),
	MaPhong VARCHAR(5),
	NgayDP DATE,
	NgayTra DATE,
	ThanhTien FLOAT 

	CONSTRAINT PK_DP
	PRIMARY KEY(Ma)
)

ALTER TABLE dbo.DATPHONG
ADD 
	CONSTRAINT FK_DP_P
	FOREIGN KEY(MaKH)
	REFERENCES dbo.PHONG,

	CONSTRAINT FK_DP_K
	FOREIGN KEY(MaKH)
	REFERENCES dbo.KHACH

INSERT INTO dbo.PHONG
VALUES 
('001', N'Rảnh', N'Nhà trọ', 1000),
('002', N'Bận', N'Phòng đơn', 2000),
('003', N'Rảnh', N'Phòng đôi', 4000),
('004', N'Bận', N'Phòng họp', 5000)

INSERT INTO dbo.KHACH
VALUES
('001', N'Nguyễn Văn A', '70/A Nguyễn Hữu Cảnh', '0123456789'),
('002', N'Nguyễn Văn B', '70/B Nguyễn Hữu Cảnh', '0123456790'),
('003', N'Nguyễn Văn C', '70/C Nguyễn Hữu Cảnh', '0678956789'),
('004', N'Nguyễn Văn D', '70/D Nguyễn Hữu Cảnh', '0176546789')

SET DATEFORMAT DMY
INSERT INTO dbo.DATPHONG
VALUES
('1', '002', '002', N'07-06-2021', NULL, NULL), 
('2', '004', '004', N'04-06-2021', NULL, NULL)
GO 

DROP TABLE dbo.DATPHONG
DROP TABLE dbo.PHONG
GO 

--SP QLKS (spDatPhong và spTraPhong)
DROP PROC spDatPhong
CREATE PROC spDatPhong @makh varchar(5), @maph varchar(5), @ngaydat date
AS
	IF(EXISTS(SELECT * FROM dbo.KHACH WHERE MaKH = @makh) AND EXISTS(SELECT * FROM dbo.PHONG WHERE MaPhong = @maph AND TinhTrang = N'Rảnh'))
	BEGIN 
		INSERT INTO dbo.DATPHONG
		VALUES ((SELECT COUNT(*) + 1 FROM dbo.DATPHONG), @makh, @maph, @ngaydat, NULL, NULL)

		 --cap nhat tinh trang phong moi
		 UPDATE dbo.PHONG SET TinhTrang = N'Bận' WHERE MaPhong = @maph
	END 
	ELSE 
		RAISERROR('makh hoac maph hoac ngaydat ko hop le', 16, 1)
GO 

DECLARE @makh VARCHAR(5) = '003'
DECLARE @maph VARCHAR(5) = '001'
DECLARE @ngaydat DATE = N'05-06-2021'
EXEC dbo.spDatPhong @makh, @maph, @ngaydat

SELECT * FROM dbo.DATPHONG
SELECT * FROM dbo.PHONG

DROP PROC spTraPhong
CREATE PROC spTraPhong @madp varchar(5), @makh varchar(5)
AS
	IF(EXISTS(SELECT * FROM dbo.DATPHONG WHERE Ma = @madp AND MaKH = @makh) AND EXISTS(SELECT * FROM dbo.KHACH WHERE MaKH = @makh))
	BEGIN 
		UPDATE dbo.DATPHONG SET NgayTra = @curDate WHERE Ma = @madp
		UPDATE dbo.DATPHONG SET ThanhTien = 
			(SELECT ABS(DATEDIFF(DAY, GETDATE(), dp.NgayDP)) * p.DonGia
			FROM dbo.PHONG p, dbo.DATPHONG dp
			WHERE p.MaPhong = dp.MaPhong AND MaKH = @makh) WHERE Ma = @madp 

		UPDATE dbo.PHONG SET TinhTrang = N'Rảnh' WHERE MaPhong = (SELECT dp.MaPhong
																FROM dbo.DATPHONG dp
																WHERE dp.Ma = @madp)
	END 
	ELSE
		RAISERROR(N'Co van de voi @madp hoac @makh', 16, 1)
GO 

DECLARE @madp VARCHAR(5) = '1'
DECLARE @makh VARCHAR(5) = '002'
EXEC spTraPhong @madp, @makh
GO 

UPDATE dbo.DATPHONG SET NgayTra = NULL WHERE MaKH = '002'
UPDATE dbo.PHONG SET TinhTrang = N'Bận' WHERE MaPhong = '002'

SELECT * FROM dbo.DATPHONG
SELECT * FROM dbo.PHONG

























