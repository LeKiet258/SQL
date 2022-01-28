--Q17
select cb.SBDEN, count(cb.MACB) SLCB
from CHUYENBAY cb
group by cb.SBDEN
order by SLCB

--Q18
select cb.SBDI, count(cb.MACB) SLCB
from CHUYENBAY cb
group by cb.SBDI
order by SLCB

--Q19
select lb.NGAYDI, cb.SBDI, count(cb.MACB) SLCB
from CHUYENBAY cb, LICHBAY lb
where cb.MACB = lb.MACB
group by lb.NGAYDI, cb.SBDI

--Q20
select lb.NGAYDI, cb.SBDEN, count(cb.MACB) SLCB
from CHUYENBAY cb, LICHBAY lb
where cb.MACB = lb.MACB
group by lb.NGAYDI, cb.SBDEN

--Q21
select lb.MACB, lb.NGAYDI, count(nv.MANV) as SLNV
from LICHBAY lb left join PHANCONG pc
on pc.NGAYDI = lb.NGAYDI and pc.MACB = lb.MACB
left join NHANVIEN nv
on nv.MANV = pc.MANV and nv.LOAINV = 0
group by lb.MACB, lb.NGAYDI

--Q22
select count(lb.MACB) SLCB
from CHUYENBAY cb, LICHBAY lb
where cb.MACB = lb.MACB and cb.SBDI = N'MIA' and lb.NGAYDI = '11/01/2000'

--Q23
select cb.MACB, lb.NGAYDI, count(pc.MANV) SLNV
from CHUYENBAY cb left join LICHBAY lb
on cb.MACB = lb.MACB
left join PHANCONG pc on pc.MACB = cb.MACB and pc.NGAYDI = lb.NGAYDI
group by cb.MACB, lb.NGAYDI
order by SLNV desc

--Q24
select cb.MACB, lb.NGAYDI, count(dc.MAKH) SL_HANHKHACH
from CHUYENBAY cb left join LICHBAY lb
on cb.MACB = lb.MACB
left join DATCHO dc
on dc.MACB = cb.MACB and dc.NGAYDI = lb.NGAYDI
group by cb.MACB, lb.NGAYDI
order by SL_HANHKHACH desc

--Q25
select cb.MACB, lb.NGAYDI, sum(nv.LUONG) TONG_LUONG
from CHUYENBAY cb 
left join LICHBAY lb on cb.MACB = lb.MACB
left join PHANCONG pc on pc.MACB = cb.MACB and pc.NGAYDI = lb.NGAYDI
left join NHANVIEN nv on nv.MANV = pc.MANV
group by cb.MACB, lb.NGAYDI
order by TONG_LUONG

--Q26
select avg(nv.LUONG) LUONG_TIEPVIEN
from NHANVIEN nv
where nv.LOAINV = 0

--Q27
select avg(nv.LUONG) LUONG_PHICONG
from NHANVIEN nv
where nv.LOAINV = 1

--Q28
select lmb.MALOAI, count(lb.MACB) SLCB
from LOAIMB lmb left join LICHBAY lb on lmb.MALOAI = lb.MALOAI
left join CHUYENBAY cb on cb.MACB = lb.MACB and cb.SBDEN = N'ORD'
group by lmb.MALOAI

--Q29
select cb.SBDI, count(MACB) SLCB
from CHUYENBAY cb
where (cb.GIODI between '10:00' and '22:00')
group by cb.SBDI
having count(MACB) > 2

--Q30
select nv.TEN
from NHANVIEN nv, PHANCONG pc
where nv.MANV = pc.MANV and nv.LOAINV = 1 
group by nv.TEN
having count(pc.MACB) >= 2

--Q31
select dc.MACB, dc.NGAYDI
from DATCHO dc
group by dc.MACB, dc.NGAYDI
having count(MAKH) < 3

--Q32
select mb.SOHIEU, mb.MALOAI
from MAYBAY mb, PHANCONG pc, LICHBAY lb
where mb.MALOAI = lb.MALOAI and mb.SOHIEU = lb.SOHIEU 
	and pc.MANV = N'1001' 
	and lb.MACB = pc.MACB and lb.NGAYDI = pc.NGAYDI
group by mb.SOHIEU, mb.MALOAI
having count(pc.MACB) > 2

--Q33
select lmb.HANGSX, count(lmb.MALOAI) SL_LOAIMB
from LOAIMB lmb
group by lmb.HANGSX