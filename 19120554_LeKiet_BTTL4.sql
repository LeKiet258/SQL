use QLDT

--Q27
SELECT COUNT(*) SLGV, SUM(LUONG) TONGLUONG
FROM dbo.GIAOVIEN

--Q28
SELECT gv.MABM, COUNT(*) SLGV_BM, AVG(gv.LUONG) LUONGTB
FROM dbo.GIAOVIEN gv
GROUP BY gv.MABM

--Q29: tên chủ đề & SLDT thuộc CD đó
SELECT cd.TENCD, COUNT(*) SLDT
FROM dbo.CHUDE cd,	dbo.DETAI dt
WHERE cd.MACD = dt.MACD
GROUP BY cd.TENCD

--Q30: tên gv & SLDT gv đó tham gia 
SELECT gv.HOTEN, COUNT(DISTINCT tgdt.MADT) SLDT_THAMGIA
FROM dbo.GIAOVIEN gv, dbo.THAMGIADT tgdt
WHERE gv.MAGV = tgdt.MAGV
GROUP BY gv.HOTEN

--Q31: tên gv & SLDT mà gv đó làm chủ nhiệm <=> tên gvcndt & SLDT của gv đó
SELECT gv.magv, gv.HOTEN, COUNT(*)
FROM dbo.GIAOVIEN gv, dbo.DETAI dt
WHERE gv.MAGV = dt.GVCNDT
GROUP BY gv.MAGV, gv.HOTEN

--Q32: với mỗi gv, cho biết tên gv & số ng thân
SELECT gv.HOTEN, COUNT(nt.TEN) SL_NGUOITHAN
FROM dbo.GIAOVIEN gv left join dbo.NGUOITHAN nt
on gv.MAGV = nt.MAGV
GROUP BY gv.HOTEN

--Q33: tên gv tham ja >=3 dt
SELECT gv.HOTEN
FROM dbo.GIAOVIEN gv, dbo.THAMGIADT tgdt
WHERE gv.MAGV = tgdt.MAGV
GROUP BY gv.HOTEN, tgdt.MAGV
HAVING COUNT(DISTINCT tgdt.MADT) >= 3

--Q34: SLGV tham ja dt "ứng dụng hhoc xanh"
SELECT COUNT(DISTINCT tgdt.MAGV) SLGV
FROM dbo.THAMGIADT tgdt, dbo.DETAI dt
WHERE dt.TENDT = N'Ứng dụng hóa học xanh' AND tgdt.MADT = dt.MADT

