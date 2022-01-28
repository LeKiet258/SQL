--1
DROP PROC spPhanCong
GO 

CREATE PROC spPhanCong @magv VARCHAR(5), @madt VARCHAR(3), @phucap FLOAT, @kq NVARCHAR(40)
AS
	IF(NOT EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE MAGV = @magv))
		RETURN -1
	IF(NOT EXISTS(SELECT * FROM dbo.DETAI WHERE MADT = @madt))
		RETURN -2
	--kt gv tham gia đủ 3 cv của dt
	IF((SELECT COUNT(*) FROM dbo.THAMGIADT tg WHERE tg.MAGV = @magv AND tg.MADT = @madt) >= 3)
		RETURN -3
	--kt dt đủ 3 gv tham gia
	IF((SELECT COUNT(DISTINCT tg.MAGV) FROM dbo.THAMGIADT tg WHERE tg.MADT = @madt) >= 3)
		RETURN -4
		
	DECLARE @stt INT
	SELECT @stt = COUNT(*) FROM dbo.THAMGIADT 
	WHERE MADT = @madt
	GROUP BY MADT
	 
	INSERT INTO dbo.THAMGIADT
	VALUES (@magv, @madt, @stt + 1, @phucap, @kq)
	RETURN 1
GO --end sp

DECLARE @bien INT 
EXEC @bien = dbo.spPhanCong @magv = '001',    -- varchar(5)
                    @madt = '001',    -- varchar(3)
                    @phucap = 0.0, -- float
                    @kq = N'Đạt'      -- nvarchar(40)
GO 
PRINT @bien

SELECT * FROM dbo.THAMGIADT

--2
DROP PROC spXoaGV
GO 

CREATE PROC spXoaGV @magv VARCHAR(5)
AS
	IF(NOT EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE MAGV = @magv))
		PRINT N'Giáo viên không tồn tại'
	ELSE 
	BEGIN 
		IF(EXISTS(SELECT * FROM dbo.KHOA WHERE TRUONGKHOA = @magv))
			UPDATE dbo.KHOA SET TRUONGKHOA = NULL WHERE TRUONGKHOA = @magv
		IF(EXISTS(SELECT * FROM dbo.BOMON WHERE TRUONGBM = @magv))
			UPDATE dbo.BOMON SET TRUONGBM = NULL WHERE TRUONGBM = @magv
		IF(EXISTS(SELECT * FROM dbo.DETAI WHERE GVCNDT = @magv))
			UPDATE dbo.DETAI SET GVCNDT = NULL WHERE GVCNDT = @magv
		IF(EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE GVQLCM = @magv))
			UPDATE dbo.GIAOVIEN SET GVQLCM = NULL WHERE GVQLCM = @magv
		IF(EXISTS(SELECT * FROM dbo.THAMGIADT tg WHERE tg.MAGV = @magv))
			DELETE dbo.THAMGIADT WHERE MAGV = @magv
		DELETE dbo.GIAOVIEN WHERE MAGV = @magv
		PRINT N'Xóa thành công'
	END 

GO 

EXEC spXoaGV '002'


SELECT * FROM dbo.GIAOVIEN
SELECT * FROM dbo.KHOA 
SELECT * FROM dbo.BOMON
SELECT * FROM dbo.DETAI
SELECT * FROM dbo.THAMGIADT

INSERT INTO dbo.GIAOVIEN
VALUES ('002', N'Trần Trà Hương', 2500.0, N'Nữ', N'1960-06-20', N'125 Trần Hưng Đạo, Q.1, TP HCM', NULL, NULL)

UPDATE dbo.BOMON SET TRUONGBM = '002' WHERE MABM = N'HTTT'

INSERT INTO dbo.THAMGIADT
VALUES
('002', '001', 4, 2.0, N'Đạt')

UPDATE dbo.DETAI SET GVCNDT = '002' WHERE MADT = '001' OR MADT = '002'
GO 

--3
DROP PROC spCapNhatTruongBM
GO 

CREATE PROC spCapNhatTruongBM @magv varchar(5), @mabm nVARCHAR(5), @nngaync DATETIME
AS
	IF(NOT EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE MAGV = @magv))
		RETURN -1
	IF(NOT EXISTS(SELECT * FROM dbo.BOMON WHERE MABM = @mabm))
		RETURN -2
	IF(NOT EXISTS(SELECT * FROM dbo.BOMON bm, dbo.GIAOVIEN gv 
		WHERE gv.MAGV = @magv AND bm.MABM = @mabm AND gv.MABM = bm.MABM))
		RETURN -3
	IF(EXISTS(SELECT * FROM dbo.KHOA WHERE TRUONGKHOA = @magv))
		RETURN -4
	IF(NOT EXISTS(SELECT * FROM dbo.GIAOVIEN WHERE ABS(DATEDIFF(YEAR, GETDATE(), NGSINH)) > 22))
		RETURN -5
	UPDATE dbo.BOMON SET 
		MABM = @mabm, 
		TRUONGBM = @magv, 
		NGAYNHANCHUC = @nngaync
	WHERE MABM = @mabm
GO 

EXEC dbo.spCapNhatTruongBM @magv = '009',                      -- varchar(5)
                           @mabm = N'MMT',                     -- nvarchar(5)
                           @nngaync = '2005-09-10' -- datetime
SELECT * FROM dbo.BOMON
GO 

--4
DROP PROC spThemCongViec
GO 

CREATE PROC spThemCongViec @madt varchar(3), @tencv nvarchar(40), @ngaybd datetime, @ngaykt datetime
AS
	IF(EXISTS(SELECT * FROM dbo.DETAI WHERE MADT = @madt))
		IF(@ngaybd < @ngaykt)
			IF(@ngaybd > GETDATE())
			BEGIN 
				DECLARE @stt INT 
				
				SELECT @stt = COUNT(*) FROM dbo.CONGVIEC cv 
				WHERE cv.MADT = @madt
				GROUP BY cv.MADT

				IF(@stt = 10)
					PRINT N'Vượt quá số công việc tối đa cho đề tài'
				ELSE 
				BEGIN 
					INSERT INTO dbo.CONGVIEC
					VALUES
					(   @madt,        -- MADT - varchar(3)
					    @stt + 1,         -- SOTT - int
					    @tencv,       -- TENCV - nvarchar(40)
					    @ngaybd, -- NGAYBD - datetime
					    @ngaykt  -- NGAYKT - datetime
					)
					PRINT N'Thêm thành công'
				END 
			END 
			ELSE 
				PRINT N'Ngày bắt đầu phải lớn hơn ngày hiện hành'
		ELSE 
			PRINT N'Ngày bắt đầu phải nhỏ hơn ngày kết thúc'
	ELSE 
		PRINT N'Đề tài không tồn tại'
GO 

EXEC dbo.spThemCongViec @madt = '001',                      -- varchar(3)
                        @tencv = N'Kiểm định',                    -- nvarchar(40)
                        @ngaybd = '2021-07-15', -- datetime
                        @ngaykt = '2021-08-15'  -- datetime
















