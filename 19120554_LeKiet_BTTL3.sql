--Quan Ly De Tai
--Q1
select HOTEN, LUONG
from GIAOVIEN
where PHAI = N'Nữ'

--Q2
select HOTEN, LUONG + 0.1*LUONG as LUONG_SAU_TANG
from GIAOVIEN

--Q3
select gv.MAGV
from GIAOVIEN gv, BOMON bm
where (gv.HOTEN like N'Nguyễn%' and gv.LUONG > 2000) 
	or (gv.MAGV = bm.TRUONGBM and year(bm.NGAYNHANCHUC) > 1995)
group by gv.MAGV

--Q4
select gv.HOTEN
from GIAOVIEN gv, KHOA k, BOMON bm
where gv.MABM = bm.MABM and bm.MAKHOA = k.MAKHOA and k.TENKHOA = N'Công nghệ thông tin'

--Q5
select bm.*, gv.*
from BOMON bm, GIAOVIEN gv
where bm.TRUONGBM = gv.MAGV

--Q6
select gv.HOTEN, bm.*
from GIAOVIEN gv, BOMON bm
where gv.MABM = bm.MABM

--Q7
select dt.TENDT, gv.*
from DETAI dt, GIAOVIEN gv
where gv.MAGV = dt.GVCNDT

--Q8
select k.TENKHOA, gv.* 
from KHOA k, GIAOVIEN gv
where k.TRUONGKHOA = gv.MAGV

--Q9
select distinct gv.*
from BOMON bm, GIAOVIEN gv, THAMGIADT tg
where bm.TENBM = N'Vi sinh' and gv.MABM = bm.MABM
	and tg.MAGV = gv.MAGV and tg.MADT = '006'

--Q10
select dt.MADT, cd.TENCD, gv.HOTEN as TEN_GVCN, gv.NGSINH, gv.DIACHI
from DETAI dt, CHUDE cd, GIAOVIEN gv
where dt.CAPQL = N'Thành phố' and dt.MACD = cd.MACD and dt.GVCNDT = gv.MAGV

--Q11
select gv.HOTEN, tk.HOTEN as NG_PHUTRACH
from GIAOVIEN gv, GIAOVIEN tk
where gv.GVQLCM is not null and tk.MAGV = gv.GVQLCM

--Q12
select gv.HOTEN
from GIAOVIEN gv, GIAOVIEN tk
where tk.HOTEN = N'Nguyễn Thanh Tùng' and gv.GVQLCM = tk.MAGV

--Q13
select gv.HOTEN
from GIAOVIEN gv, BOMON bm
where bm.TENBM = N'Hệ thống thông tin' and bm.TRUONGBM = gv.MAGV

--Q14
select distinct HOTEN
from GIAOVIEN gv, DETAI dt, CHUDE cd
where dt.GVCNDT = gv.MAGV and dt.MACD = cd.MACD and cd.TENCD = N'Quản lý giáo dục'

--Q15
select cv.TENCV
from CONGVIEC cv, DETAI dt
where cv.MADT = dt.MADT and dt.TENDT = N'HTTT quản lý các trường ĐH'
	and month(cv.NGAYBD) = 03 and year(cv.NGAYBD) = 2008

--Q16
select gv.HOTEN, tk.HOTEN as GVQLCM
from GIAOVIEN gv, GIAOVIEN tk
where gv.GVQLCM is not null and tk.MAGV = gv.GVQLCM

--Q17
select *
from CONGVIEC cv
where cv.NGAYBD >= '2007-01-01' and cv.NGAYBD <= '2007-08-01'

--Q18
select gv.HOTEN
from GIAOVIEN gv, GIAOVIEN gv2
where gv2.HOTEN = N'Trần Trà Hương' and gv.MABM = gv2.MABM and gv.HOTEN <> N'Trần Trà Hương'

--Q19
select distinct gv.*
from DETAI dt, BOMON bm, GIAOVIEN gv
where gv.MAGV = bm.TRUONGBM and gv.MAGV = dt.GVCNDT

--Q20
select gv.HOTEN
from GIAOVIEN gv, KHOA k, BOMON bm
where gv.MAGV = k.TRUONGKHOA and gv.MAGV = bm.TRUONGBM

--Q21
select distinct gv.*
from DETAI dt, BOMON bm, GIAOVIEN gv
where gv.MAGV = bm.TRUONGBM and gv.MAGV = dt.GVCNDT

--Q22
select distinct k.TRUONGKHOA
from KHOA k, DETAI dt
where k.TRUONGKHOA = dt.GVCNDT

--Q23
select distinct gv.MAGV
from THAMGIADT tg, DETAI dt, GIAOVIEN gv
where gv.MABM = N'HTTT' or (gv.MAGV = tg.MAGV and tg.MADT = '001')

--Q24
select gv.*
from GIAOVIEN gv, GIAOVIEN gv2
where gv.MABM = gv2.MABM and gv2.MAGV = '002' and gv.MAGV <> '002'

--Q25
select distinct tbm.*
from GIAOVIEN tbm, GIAOVIEN gv2
where tbm.MAGV = gv2.GVQLCM

--Q26
select HOTEN, LUONG
from GIAOVIEN