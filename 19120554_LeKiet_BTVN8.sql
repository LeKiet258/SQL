--q51: macb cua tat ca cac may bay cua hang "Boeing"
--kq: macb - chuyenbay
--c: máy bay hãng Boeing (mamb) - loaimb/lb
--bc: lb2
--Cach 1
select lb2.MACB
from LICHBAY lb2
where lb2.MACB in (select lb.MACB
					from LOAIMB lmb, LICHBAY lb
					where lb.MALOAI = lmb.MALOAI and lmb.HANGSX = 'Boeing')
group by lb2.MACB
having count(distinct lb2.MACB) = (select count(lb.MACB)
									from LOAIMB lmb, LICHBAY lb
									where lb.MALOAI = lmb.MALOAI and lmb.HANGSX = 'Boeing')
--Cach 2
select cb.MACB
from CHUYENBAY cb
where not exists(
	(select * from LOAIMB lmb, LICHBAY lb
	where lb.MALOAI = lmb.MALOAI and lmb.HANGSX = 'Boeing' 
		and not exists(
		(select * from LICHBAY lb2
		where lb2.MACB = lb.MACB and lb2.MACB = cb.MACB))))

--Cach 3
select cb.MACB
from CHUYENBAY cb
where not exists(
	(select lb.MACB
	from LOAIMB lmb, LICHBAY lb
		except
	(select lb2.MACB
	from LICHBAY lb2
	where lb2.MACB = cb.MACB)))

--q52: ma & ten phicong co kha nang lai tat ca cac may bay hang 'Airbus'
--kq: phicong - NV
--c: máy bay hãng "Airbus" - LMB
--bc: kn
--Cach 1
select nv.MANV, nv.TEN
from KHANANG kn, NHANVIEN nv
where nv.MANV = kn.MANV and kn.MALOAI in (select lmb.MALOAI
										from LOAIMB lmb
										where lmb.HANGSX = 'Airbus')
group by nv.MANV, nv.TEN
having count(distinct kn.MALOAI) = (select count(lmb.MALOAI)
									from  LOAIMB lmb
									where lmb.HANGSX = 'Airbus')
					
-- Cach 2
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1 and not exists(
	(select * from LOAIMB lmb
	where lmb.HANGSX = 'Airbus' and not exists(
		(select * from KHANANG kn
		where kn.MANV = nv.MANV and kn.MALOAI = lmb.MALOAI))))

--Cach 3
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1 and not exists(
	(select lmb.MALOAI from LOAIMB lmb 
	where lmb.HANGSX = 'Airbus'
		except
	(select kn.MALOAI
	from KHANANG kn
	where kn.MANV = nv.MANV)))

--q53
--kq: nv[loainv=0]
--c: cb có macb = 100
--bc: pc
--Cach 1
select nv.TEN
from PHANCONG pc, NHANVIEN nv
where nv.LOAINV != 1 and nv.MANV = pc.MANV and 
	pc.MACB in (select cb.MACB
				from CHUYENBAY cb
				where cb.MACB = '100')
group by nv.TEN
having count(distinct pc.MACB) = (select count(cb.MACB)
								from CHUYENBAY cb
								where cb.MACB = '100') 
--Cach 2
select nv.TEN
from NHANVIEN nv
where nv.LOAINV = 0 and not exists(
	(select * from CHUYENBAY cb
	where cb.MACB = '100' and not exists(
		(select * from PHANCONG pc
		where pc.MANV = nv.MANV and pc.MACB = cb.MACB))))

--Cach 3
select nv.TEN
from NHANVIEN nv
where nv.LOAINV = 0 and not exists(
	(select cb.MACB from CHUYENBAY cb
	where cb.MACB = '100'
		except
	(select pc.MACB from PHANCONG pc
	where pc.MANV = nv.MANV)))

--q54
--kq: ngaydi - lichbay
--c: loại mb hãng 'Boeing'
--bc: lichbay2
--Cach 1
select lb.NGAYDI
from LICHBAY lb
where lb.MALOAI in (select lmb.MALOAI
					from LOAIMB lmb
					where lmb.HANGSX = 'Boeing')
group by lb.NGAYDI
having count(distinct lb.MALOAI) = (select count(distinct lmb.MALOAI)
									from LOAIMB lmb
									where lmb.HANGSX = 'Boeing') 
--Cach 2
select lb.NGAYDI
from LICHBAY lb
where not exists(
	(select * from LOAIMB lmb
	where lmb.HANGSX = 'Boeing' and not exists(
		(select * from LICHBAY lb2
		where lb2.NGAYDI = lb.NGAYDI and lb2.MALOAI = lmb.MALOAI))))

--Cach 3
select lb.NGAYDI
from LICHBAY lb
where not exists(
	(select lmb.MALOAI from LOAIMB lmb
	where lmb.HANGSX = 'Boeing'
		except
	(select lb.MALOAI from LICHBAY lb2
	where lb2.NGAYDI = lb.NGAYDI)))

--q55
--kq: loaimb + hãng "boeing" - loaimb
--c: ngdi - lichbay
--bc: lichbay2
--Cach 1
select lb.MALOAI
from LICHBAY lb, LOAIMB lmb
where lmb.HANGSX = 'Boeing' and lmb.MALOAI = lb.MALOAI
group by lb.MALOAI
having count(distinct lb.NGAYDI) = (select count(distinct lb2.NGAYDI)
									from LICHBAY lb2)

--Cach 2
select lmb.MALOAI
from LOAIMB lmb
where lmb.HANGSX = 'Boeing' and not exists(
	(select * from LICHBAY lb
	where not exists(
		(select * from LICHBAY lb2
		where lb2.MALOAI = lmb.MALOAI and lb2.NGAYDI = lb.NGAYDI))))

--Cach 3
select lmb.MALOAI
from LOAIMB lmb
where lmb.HANGSX = 'Boeing' and not exists(
	(select lb.NGAYDI from LICHBAY lb
	except
	(select lb2.NGAYDI from LICHBAY lb2
	where lb2.MALOAI = lmb.MALOAI  )))


--q56
--kq: khachhang[ma + ten]
--c: ngay datcho 31/10/2000 - 1/1/2000 - datcho
--bc: datcho2
--Cach 1
select dc.MAKH, kh.TEN
from DATCHO dc, KHACHHANG kh
where dc.MAKH = kh.MAKH and 
	dc.NGAYDI in (select dc2.NGAYDI from DATCHO dc2
				where dc2.NGAYDI between '10/31/2000' and '1/1/2000')
group by dc.MAKH, kh.TEN
having count(distinct dc.NGAYDI) = 
(		select count(distinct dc2.NGAYDI)
		from DATCHO dc2
		where dc2.NGAYDI between '10/31/2000' and '1/1/2000')

--Cach 2
select kh.MAKH, kh.TEN
from KHACHHANG kh
where not exists(
	(select * from DATCHO dc
	where dc.NGAYDI between '10/31/2000' and '1/1/2000' and not exists(
		(select * from DATCHO dc2
		where dc2.MAKH = kh.MAKH and dc2.NGAYDI = dc.NGAYDI))))

--cach 3
select kh.MAKH, kh.TEN
from KHACHHANG kh
where not exists(
	(select dc.NGAYDI from DATCHO dc
	where dc.NGAYDI between '10/31/2000' and '1/1/2000'
	except
	(select dc2.NGAYDI from DATCHO dc2
	where dc2.MAKH = kh.MAKH)))

--q57: mã và tên phi công không có khả năng lái được tất cả các máy bay của Airbus
--kq: phicong[ma + ten] - NV
--c: maybay hang 'Airbus' - LMB
--bc: khanang
--cach 1
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1 and nv.MANV not in
(
	select kn.MANV
	from KHANANG kn
	where kn.MALOAI in 
		(select lmb.MALOAI
		from LOAIMB lmb
		where lmb.HANGSX = 'Airbus')
	group by kn.MANV
	having count(distinct kn.MALOAI) = 
		(select count(lmb.MALOAI)
		from LOAIMB lmb
		where lmb.HANGSX = 'Airbus')
)

--Cach 2
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1 and nv.MANV not in 
	(select nv1.MANV
	from NHANVIEN nv1
	where nv1.LOAINV = 1 and not exists(
		(select * from LOAIMB lmb
		where lmb.HANGSX = 'Airbus' and not exists(
			(select * from KHANANG kn
			where kn.MANV = nv.MANV and kn.MALOAI = lmb.MALOAI)))))

--Cach 3
select nv.MANV, nv.TEN
from NHANVIEN nv
where nv.LOAINV = 1 and nv.MANV not in 
	(select nv1.MANV
	from NHANVIEN nv1
	where not exists(
		(select * from LOAIMB lmb
		where lmb.HANGSX = 'Airbus'
		except
		(select * from KHANANG kn
		where kn.MANV = nv.MANV))))


--q58: sân bay nào có tất cả các loại máy bay của hãng Boeing xuất phát
--kq: sanbaydi - chuyenbay
--c: maloai của 'Boeing' - loaimb
--bc: lb2 x cb2
--Cach 1
select cb.SBDI
from LICHBAY lb, CHUYENBAY cb
where lb.MACB = cb.MACB and lb.MALOAI in 
	(select lmb.MALOAI
	from LOAIMB lmb
	where lmb.HANGSX = 'Boeing')
group by cb.SBDI
having count(distinct lb.MALOAI) = 
	(select count(lmb.MALOAI)
	from LOAIMB lmb
	where lmb.HANGSX = 'Boeing')

--Cach 2
select cb.SBDI
from CHUYENBAY cb
where not exists(
	(select * from LOAIMB lmb
	where lmb.HANGSX = 'Boeing' and not exists(
		(select * from LICHBAY lb2, CHUYENBAY cb2
		where lb2.MACB = cb2.MACB and lb2.MACB = cb2.MACB
			and cb2.SBDI = cb.SBDI and lb2.MALOAI = lmb.MALOAI))))
--Cach 3
select cb.SBDI
from CHUYENBAY cb
where not exists(
	(select lmb.MALOAI from LOAIMB lmb
	where lmb.HANGSX = 'Boeing'
	except
	(select lb2.MALOAI from LICHBAY lb2, CHUYENBAY cb2
	where lb2.MACB = cb2.MACB and lb2.MACB = cb2.MACB
		and cb2.SBDI = cb.SBDI)))
































































