--Quan Ly Chuyen Bay
--Q1
SELECT nv.MANV, nv.TEN, nv.DCHI, nv.DTHOAI
FROM dbo.NHANVIEN nv, dbo.LICHBAY lb, dbo.PHANCONG pc
WHERE pc.MANV = nv.MANV AND nv.LOAINV = 1 AND lb.MALOAI = N'B747' AND lb.MACB = pc.MACB AND pc.NGAYDI = lb.NGAYDI

--Q2
SELECT lb.MACB, lb.NGAYDI
FROM dbo.LICHBAY lb, dbo.CHUYENBAY cb
WHERE lb.MACB = cb.MACB AND cb.SBDI = N'DCA' AND (cb.GIODI BETWEEN N'14:00' AND N'18:00')

--Q3
select distinct nv.TEN 
from NHANVIEN nv, PHANCONG pc, CHUYENBAY cb
where nv.LOAINV = 0 and nv.MANV = pc.MANV
	and pc.MACB = cb.MACB and cb.MACB = N'100'
	and cb.SBDI = N'SLC'

--Q4
SELECT DISTINCT lb.MALOAI, lb.SOHIEU
FROM dbo.CHUYENBAY cb, dbo.LICHBAY lb
WHERE cb.MACB = lb.MACB AND cb.SBDI = N'MIA'

--Q5
select lb.MACB, lb.NGAYDI, kh.TEN, kh.DCHI, kh.DTHOAI
from LICHBAY lb, KHACHHANG kh, DATCHO dc
where dc.MAKH = kh.MAKH and lb.MACB = dc.MACB AND lb.NGAYDI = dc.NGAYDI
order by lb.MACB asc, lb.NGAYDI desc

--Q6
select pc.MACB, pc.NGAYDI, nv.TEN, nv.DCHI, nv.DTHOAI
from NHANVIEN nv, PHANCONG pc
where nv.MANV = pc.MANV AND nv.LOAINV = 0
order by pc.MACB asc, pc.NGAYDI desc

--Q7
select pc.MACB, pc.NGAYDI, nv.TEN, nv.DCHI, nv.DTHOAI
from NHANVIEN nv, PHANCONG pc, CHUYENBAY cb
where nv.MANV = pc.MANV AND nv.LOAINV = 1 AND pc.MACB = cb.MACB and cb.SBDEN = N'ORD'

--Q8
SELECT pc.MACB, pc.NGAYDI, nv.TEN
FROM dbo.NHANVIEN nv, dbo.PHANCONG pc
WHERE nv.MANV = N'1001' AND nv.MANV = pc.MANV 

--Q9
select cb.MACB, cb.SBDI, cb.GIODI, cb.GIODEN, lb.NGAYDI
from CHUYENBAY cb, LICHBAY lb
where lb.MACB = cb.MACB and cb.SBDEN = N'DEN'
order by lb.NGAYDI desc, cb.SBDI asc

--Q10
select nv.TEN, lmb.HANGSX, lmb.MALOAI
from NHANVIEN nv, LOAIMB lmb, KHANANG kn
where nv.MANV = kn.MANV AND kn.MALOAI = lmb.MALOAI

--Q11
select distinct nv.MANV, nv.TEN
from NHANVIEN nv, LICHBAY lb, PHANCONG pc
where nv.MANV = pc.MANV AND nv.LOAINV = 1 
	AND pc.MACB = lb.MACB AND pc.MACB = N'100' 
	AND lb.NGAYDI = '11/01/2000' AND pc.NGAYDI = lb.NGAYDI

--Q12
SELECT pc.MACB, pc.MANV, nv.TEN
FROM dbo.NHANVIEN nv, dbo.PHANCONG pc, dbo.CHUYENBAY cb
WHERE nv.LOAINV = 0 AND nv.MANV = pc.MANV
	AND pc.MACB = cb.MACB AND pc.NGAYDI = '10/31/2000' 
	AND cb.SBDI = N'MIA' AND cb.GIODI = '20:30'

--Q13
SELECT pc.MACB, lb.SOHIEU, lb.MALOAI, lmb.HANGSX
FROM dbo.NHANVIEN nv, dbo.PHANCONG pc, dbo.LICHBAY lb, dbo.LOAIMB lmb
WHERE nv.TEN = N'Quang' AND nv.LOAINV = 1
	AND nv.MANV = pc.MANV
	AND pc.NGAYDI = lb.NGAYDI AND pc.MACB = lb.MACB
	AND lb.MALOAI = lmb.MALOAI

--Q14
select nv.TEN
from NHANVIEN nv
WHERE nv.LOAINV = 1
except
select phc.TEN
from NHANVIEN phc, PHANCONG pc
where phc.MANV = pc.MANV AND phc.LOAINV = 1

--Q15
SELECT DISTINCT kh.TEN
FROM KHACHHANG kh, DATCHO dc, LICHBAY lb, LOAIMB lmb
WHERE kh.MAKH = dc.MAKH 
	AND dc.MACB = lb.MACB AND dc.NGAYDI = lb.NGAYDI
	AND lb.MALOAI = lmb.MALOAI AND lmb.HANGSX = N'Boeing'

--Q16
SELECT DISTINCT MACB
FROM LICHBAY LB
WHERE (LB.SOHIEU = 10 and LB.MALOAI = 'B747')