--Q34: hangsx, maloai, sohieu máy bay dc sd nhiều nhất
select lmb.HANGSX, lmb.MALOAI, lb.SOHIEU
from LOAIMB lmb, LICHBAY lb
where lmb.MALOAI = lb.MALOAI
group by lmb.HANGSX, lmb.MALOAI, lb.SOHIEU
having count(*) >= all(select count(*)
						from LICHBAY lb2
						group by lb2.MALOAI, lb2.SOHIEU) 


--Q35: ten nv dc phan cong di nhieu cb nhat
select nv.TEN
from NHANVIEN nv, PHANCONG pc
where nv.MANV = pc.MANV
group by nv.TEN
having count(pc.MACB) >= all(select count(pc2.MACB)
							from PHANCONG pc2
							group by pc2.MANV)

--Q36: cho biet phi cong (ten, d/c, dt) lai nhieu chuyen bay nhat
select nv.TEN, nv.DCHI, nv.DTHOAI
from NHANVIEN nv, PHANCONG pc
where nv.LOAINV = 1 and nv.MANV = pc.MANV
group by nv.TEN, nv.DCHI, nv.DTHOAI
having count(pc.MANV) >= all(select count(pc.MANV)
						from NHANVIEN nv2, PHANCONG pc2
						where nv2.LOAINV = 1 and nv2.MANV = pc2.MANV
						group by nv2.TEN)

--Q37: SBDEN & SLCB của sân bay có ít cb đáp nhất
select cb.SBDEN, count(cb.MACB) as SLCB
from CHUYENBAY cb
group by cb.SBDEN
having count(cb.MACB) <= all(select count(cb2.MACB)
							from CHUYENBAY cb2
							group by cb2.SBDEN)

--Q38: 
select cb.SBDI, count(cb.MACB) as SLCB
from CHUYENBAY cb
group by cb.SBDI
having count(cb.MACB) >= all(select count(cb2.MACB)
							from CHUYENBAY cb2
							group by cb2.SBDI)

--Q39: ten, d/c, dt cua khach hang di tren nhieu cb nhat
select kh.TEN, kh.DCHI, kh.DTHOAI
from KHACHHANG kh, DATCHO dc
where kh.MAKH = dc.MAKH
group by kh.TEN, kh.DCHI, kh.DTHOAI
having count(dc.MACB) >= all(select count(dc2.MACB)
							from KHACHHANG kh2, DATCHO dc2
							where kh2.MAKH = dc2.MAKH
							group by kh2.TEN, kh2.DCHI, kh2.DTHOAI)

--Q40: 
select nv.MANV, nv.TEN, nv.LUONG
from NHANVIEN nv, KHANANG kn
where nv.LOAINV = 1 and nv.MANV = kn.MANV
group by nv.MANV, nv.TEN, nv.LUONG
having count(kn.MALOAI) >= all(select nv.MANV, nv.TEN, nv.LUONG
								from NHANVIEN nv, KHANANG kn
								where nv.LOAINV = 1 and nv.MANV = kn.MANV
								group by nv.MANV, nv.TEN, nv.LUONG)

--Q41:
select nv.MANV, nv.TEN, nv.LUONG
from NHANVIEN nv
where nv.LUONG = (select max(nv2.LUONG)
					from NHANVIEN nv2)

--Q42**:
select pc.MACB, nv.TEN, nv.DCHI
from NHANVIEN nv, PHANCONG pc
where nv.MANV = pc.MANV and nv.LUONG in (select max(nv2.LUONG)
									from NHANVIEN nv2)
	and pc.MACB in (select pc2.MACB
					from PHANCONG pc2 
					group by pc2.MACB
					having count(pc2.MACB) = 1)

--Q43:
select cb.MACB, cb.GIODI, cb.GIODEN
from CHUYENBAY cb
where cb.GIODI = (select min(cb2.GIODI)
					from CHUYENBAY cb2)

--Q44
select cb.MACB, datediff(minute, cb.GIODI, cb.GIODEN)
from CHUYENBAY cb
where datediff(minute, cb.GIODI, cb.GIODEN) = (select max(datediff(minute, cb2.GIODI, cb2.GIODEN))
											from CHUYENBAY cb2)

--Q45:
select cb.MACB, datediff(minute, cb.GIODI, cb.GIODEN)
from CHUYENBAY cb
where datediff(minute, cb.GIODI, cb.GIODEN) = (select min(datediff(minute, cb2.GIODI, cb2.GIODEN))
											from CHUYENBAY cb2)

--Q46
select lb.MACB, lb.NGAYDI
from LICHBAY lb
where lb.MALOAI = 'B747' 
group by lb.MACB, lb.NGAYDI
having count(lb.MACB) >= all(select count(lb2.MACB)
							from LICHBAY lb2
							where lb2.MALOAI = 'B747' 
							group by lb2.MACB, lb2.NGAYDI)

--Q47
select dc.MACB, dc.NGAYDI, count(distinct pc.MANV) as SLNV
from DATCHO dc, PHANCONG pc
where dc.MACB = pc.MACB and dc.NGAYDI = pc.NGAYDI
group by dc.MACB, dc.NGAYDI
having count(distinct dc.MAKH) >= 3

--Q48
select nv.LOAINV, count(nv.MANV)
from NHANVIEN nv
where nv.LUONG>6000
group by nv.LOAINV

--Q49
select dc.MACB, count(distinct dc.MAKH) SLKH
from PHANCONG pc, DATCHO dc
where pc.MACB = dc.MACB and pc.NGAYDI = dc.NGAYDI
group by dc.MACB
having count(distinct pc.MANV) > 3

--Q50
select lmb.MALOAI, count(distinct lb.MACB)
from LOAIMB lmb left join LICHBAY lb
on lmb.MALOAI = lb.MALOAI
group by lmb.MALOAI
having count(distinct lb.MACB) > 1
