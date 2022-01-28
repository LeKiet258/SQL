--Q35: mức lương cao nhất của các gv
select max(gv.LUONG) as LuongCaoNhat
from GIAOVIEN gv

--Q36: những gv có lương lớn nhất
select gv.*
from GIAOVIEN gv
where gv.LUONG = (select max(gv2.LUONG) from GIAOVIEN gv2)

--q36
select *
from GIAOVIEN gv
where LUONG = (select max(gv2.Luong) from GIAOVIEN gv2)

--Q37
select gv.LUONG
from GIAOVIEN gv
where gv.MABM = N'HTTT' and gv.LUONG = (select max(gv2.LUONG)
										from GIAOVIEN gv2)
--q37: Cho"biết"lương"cao"nhất"trong"bộ"môn"“HTTT”."
select gv.LUONG
from GIAOVIEN gv
where gv.LUONG = (select max(gv2.luong) 
					from GIAOVIEN gv2
					where gv2.MABM = N'HTTT')

--Q38: gv lớn tuổi nhất bm Hệ thống thông tin
select gv.HOTEN
from GIAOVIEN gv
where gv.NGSINH = (select min(gv2.NGSINH) 
						from GIAOVIEN gv2, BOMON bm
						where gv2.MABM = bm.MABM and gv.MABM = gv2.MABM and bm.TENBM = N'Hệ thống thông tin' ) 		

--Q39: tên gv nhỏ tuổi nhất khoa Công nghệ thông tin
select gv.HOTEN
from GIAOVIEN gv
where gv.NGSINH = (select max(gv2.NGSINH)
					from GIAOVIEN gv2, KHOA k2, BOMON bm2
					where gv2.MABM = bm2.MABM and bm2.MAKHOA = k2.MAKHOA and k2.TENKHOA = N'Công nghệ thông tin')
--q39: tên gv nhỏ tuổi nhất khoa Công nghệ thông tin
select gv.HOTEN
from GIAOVIEN gv
where gv.NGSINH = (select max(gv2.ngsinh)
					from GIAOVIEN gv2 join BOMON bm on gv2.MABM = bm.MABM join KHOA k on bm.MAKHOA = k.MAKHOA
					where k.TENKHOA = N'Công nghệ thông tin')

--Q40: tên gv & tên khoa của gv có lương cao nhất
select gv.HOTEN, k.TENKHOA
from GIAOVIEN gv, KHOA k, BOMON bm
where gv.LUONG = (select max(gv2.LUONG) from GIAOVIEN gv2)
	and gv.MABM = bm.MABM and bm.MAKHOA = k.MAKHOA
--q40: tên gv & tên khoa của gv có lương cao nhất
select gv.HOTEN, k.TENKHOA
from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM join KHOA k on bm.MAKHOA = k.MAKHOA
where gv.LUONG = (select max(gv2.luong)
					from GIAOVIEN gv2)

--Q41**: cho biết những gv có lương lơn nhất trong bộ môn của họ
select gv.HOTEN, gv.LUONG, bm.TENBM
from GIAOVIEN gv right join BOMON bm on gv.MABM = bm.MABM 
where gv.LUONG = (select max(gv2.LUONG)
				from GIAOVIEN gv2
				where gv2.MABM = gv.MABM) --dòng này quan trọng

--Q42: cho biết tendt mà Nguyễn Hoài An chưa tham gia
--Cách 1:
select dt.TENDT 
from DETAI dt
where dt.MADT not in (select tg.MADT
						from GIAOVIEN gv, THAMGIADT tg
						where gv.HOTEN = N'Nguyễn Hoài An' and tg.MAGV = gv.MAGV)
--Cách 2:
select dt.TENDT
from DETAI dt, GIAOVIEN gv
where gv.HOTEN = N'Nguyễn Hoài An' and 
	gv.MAGV not in (select tg2.MAGV
					from THAMGIADT tg2 
					where tg2.MADT = dt.MADT)

--q42: cho biết tendt mà Nguyễn Hoài An chưa tham gia
select dt.TENDT
from DETAI dt
where dt.MADT not in(
	select tg.MADT
	from GIAOVIEN gv join THAMGIADT tg on gv.MAGV = tg.MAGV
	where gv.HOTEN = N'Nguyễn Hoài An')

--Q43
select dt.TENDT, cndt.HOTEN
from DETAI dt, GIAOVIEN cndt
where dt.MADT not in (select tg.MADT
						from GIAOVIEN gv, THAMGIADT tg
						where gv.HOTEN = N'Nguyễn Hoài An' and tg.MAGV = gv.MAGV)
	and dt.GVCNDT = cndt.MAGV

--Q44: Cho biết tên những giáo viên khoa Công nghệ thông tin chưa tham gia đề tài
select gv.HOTEN
from GIAOVIEN gv, BOMON bm, KHOA k, THAMGIADT tg
where gv.MABM = bm.MABM and bm.MAKHOA = k.MAKHOA and k.TENKHOA = N'Công nghệ thông tin'
	and tg.MAGV = gv.MAGV and gv.MAGV not in (select tg.MAGV)
					
--Q45
select gv.*
from GIAOVIEN gv
where gv.MAGV not in (select tg.MAGV from THAMGIADT tg)

--Q46
select gv.*
from GIAOVIEN gv
where gv.LUONG > (select gv2.LUONG from GIAOVIEN gv2 where gv2.HOTEN = N'Nguyễn Hoài An')

--Q47: tìm những trưởng bm tham gia ít nhất 1 dt
select bm.TRUONGBM
from GIAOVIEN gv, BOMON bm, THAMGIADT tg
where gv.MAGV = bm.TRUONGBM and tg.MAGV = gv.MAGV
group by bm.TRUONGBM
having count(distinct tg.MADT) >= 1


--Q48:
select gv1.*
from GIAOVIEN gv1, GIAOVIEN gv2
where gv1.MAGV <> gv2.MAGV and gv1.HOTEN = gv2.HOTEN and gv1.PHAI = gv2.PHAI	and gv1.MABM = gv2.MABM


--Q49##
select gv.*
from GIAOVIEN gv
where gv.LUONG > any(select gv2.LUONG
					from BOMON bm, GIAOVIEN gv2
					where bm.TENBM = N'Công nghệ phần mềm' and gv2.MABM = bm.MABM)

--Q50
select gv.*
from GIAOVIEN gv
where gv.LUONG > all(select gv2.LUONG
					from GIAOVIEN gv2, BOMON bm
					where gv2.MABM = bm.MABM and bm.TENBM = N'Hệ thống thông tin')

--Q51**: tên khoa đông gv nhất
select k.TENKHOA
from KHOA k, GIAOVIEN gv, BOMON bm
where gv.MABM = bm.MABM and bm.MAKHOA = k.MAKHOA
group by k.TENKHOA
having count(gv.MAGV) >= all(select count(gv2.MAGV)
						from KHOA k2, GIAOVIEN gv2, BOMON bm2
						where gv2.MABM = bm2.MABM and bm2.MAKHOA = k2.MAKHOA
						group by k2.MAKHOA)

--Q52
select gv.HOTEN
from GIAOVIEN gv, DETAI dt
where gv.MAGV = dt.GVCNDT
group by gv.HOTEN
having count(dt.MADT) >= all(select count(dt2.MADT)
							from GIAOVIEN gv2, DETAI dt2
							where gv2.MAGV = dt2.GVCNDT
							group by gv2.HOTEN)

--Q53
select bm.MABM
from BOMON bm, GIAOVIEN gv
where gv.MABM = bm.MABM
group by bm.MABM
having count(gv.MAGV) >= all(select count(gv2.MAGV)
						from BOMON bm2, GIAOVIEN gv2
						where gv2.MABM = bm2.MABM
						group by bm2.MABM)

--Q54
select gv.HOTEN, bm.TENBM
from GIAOVIEN gv, BOMON bm, THAMGIADT tg
where gv.MABM = bm.MABM and gv.MAGV = tg.MAGV
group by gv.HOTEN, bm.TENBM
having count(distinct tg.MADT) >= all(select count(distinct tg2.MADT)
									from GIAOVIEN gv2, BOMON bm2, THAMGIADT tg2
									where gv2.MABM = bm2.MABM and gv2.MAGV = tg2.MAGV
									group by gv2.HOTEN, bm2.TENBM)

--Q55: tên gv tham gia nhiều dt nhất bm 'HTTT'
select gv.HOTEN
from GIAOVIEN gv, THAMGIADT tg
where gv.MAGV = tg.MAGV and gv.MABM = N'HTTT'
group by gv.HOTEN
having count(distinct tg.MADT) >= all(select count(distinct tg2.MADT)
									from GIAOVIEN gv2, THAMGIADT tg2
									where gv2.MAGV = tg2.MAGV and gv2.MABM = N'HTTT'
									group by gv2.HOTEN)
		
--Q56
select gv.HOTEN, bm.TENBM
from GIAOVIEN gv, BOMON bm, NGUOITHAN nt
where gv.MAGV = nt.MAGV and gv.MABM = bm.MABM
group by gv.HOTEN, bm.TENBM, nt.MAGV
having count(nt.TEN) >= all(select count(nt2.TEN)
							from GIAOVIEN gv2, NGUOITHAN nt2
							where gv2.MAGV = nt2.MAGV
							group by gv2.MAGV)

--Q57
select gv.HOTEN
from BOMON bm, DETAI dt, GIAOVIEN gv
where gv.MABM = bm.MABM and bm.TRUONGBM = gv.MAGV and bm.TRUONGBM = dt.GVCNDT
group by gv.HOTEN
having count(dt.MADT) >= all(select count(dt2.MADT)
				from BOMON bm2, DETAI dt2
				where bm2.TRUONGBM = dt2.GVCNDT
				group by bm2.TRUONGBM)