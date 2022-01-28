--Q58: Cho"biết"tên"giáo"viên"nào"mà"tham"gia"đề"tài"đủ"tất"cả"các"chủ"đề."
--kq: gv (magv)
--c: chude (macd)
--bc: tg kết dtai
select gv.HOTEN
from GIAOVIEN gv
where not exists (
	(select * from CHUDE cd 
	where not exists (
		(select * from THAMGIADT tg, DETAI dt
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT
			and dt.MACD = cd.MACD)))
)

--Q59: Cho"biết"tên"đề"tài"nào"mà"được"tất"cả"các"giáo"viên"của"bộ"môn"HTTT"tham"gia
--kq: dt (ten)
--c: gv HTTT
--bc: tgdt
select dt.TENDT
from DETAI dt
where not exists (
	(select * from GIAOVIEN gv
	where gv.MABM = N'HTTT' and not exists(
		(select * from THAMGIADT tg 
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV)))
)

--Q60: Cho"biết"tên"đề"tài"nào"mà"được"tất"cả"các"giáo"viên"của"bộ"môn"HTTT"tham"gia
select dt.TENDT
from DETAI dt
where not exists (
	(select * from GIAOVIEN gv, BOMON bm
	where gv.MABM = bm.MABM and bm.TENBM = N'Hệ thống thông tin' and not exists(
		(select * from THAMGIADT tg 
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV)))
)


--Q61 
--kq: gv
--c: dt có macd = QLGD
--bc: tgdt
select *
from GIAOVIEN gv
where not exists(
	(select * from DETAI dt
	where dt.MACD = N'QLGD' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT)))
)

--Q62
--kq: gv(ten)
--c: dt Trần T. hương tham gia -> gv, tgdt
--bc: tgdt
select gv.HOTEN
from GIAOVIEN gv
where not exists (
	(select * from GIAOVIEN gv2, THAMGIADT tg2
	where gv2.HOTEN = N'Trần Trà Hương' and tg2.MAGV = gv2.MAGV and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = tg2.MADT and gv.HOTEN != N'Trần Trà Hương'))) --Nhớ DK: gv.HOTEN != N'Trần Trà Hương'
)

--q62: Cho"biết"tên"giáo"viên"nào"tham"gia"tất"cả"các"đề"tài"mà"giáo"viên"Trần"Trà"Hương"đã"tham"gia."
--c: dt có TTH, gv + tgdt
--kq: gv
--bc: tgdt
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	select *
	from GIAOVIEN gv2 join THAMGIADT tg on gv2.MAGV = tg.MAGV
	where gv2.HOTEN = N'Trần Trà Hương' and not exists(
		select * 
		from THAMGIADT tg2
		where tg2.MADT = tg.MADT and tg2.MAGV = gv.MAGV and gv.HOTEN != N'Trần Trà Hương'))


--Q63
--kq: dt
--c: gv bm 'Hóa Hữu Cơ'
--bc: tg
select dt.TENDT
from DETAI dt
where not exists(
	(select * from GIAOVIEN gv, BOMON bm
	where gv.MABM = bm.MABM and bm.TENBM = N'Hóa Hữu Cơ' and not exists(
		(select * from THAMGIADT tg
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV)))
)

--q63: Cho"biết"tên"đề"tài"nào"mà"được"tất"cả"các"giáo"viên"của"bộ"môn"Hóa"Hữu"Cơ"tham"gia.
--c: gv HHC
--kq: ten dt
--bc: tgdt
select dt.TENDT
from DETAI dt
where not exists(
	select *
	from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM
	where bm.TENBM = N'Hóa Hữu Cơ' and not exists(
		select * 
		from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT))

--Q64
--kq: gv (ten_
--c: cv có madt = 006
--bc: tg
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	(select * from CONGVIEC cv
	where cv.MADT = '006' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = cv.MADT)))
)

--Q65
--kq: gv:
--c: dt chủ đề "Ướng..'
--bc: tg
select gv.*
from GIAOVIEN gv
where not exists(
	(select * from DETAI dt, CHUDE cd
	where dt.MACD = cd.MACD and cd.TENCD = N'Ứng dụng công nghệ' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT)))
)

--Q66
--kq: gv - ten
--c: dt [gvcn = 'Trà Hương']
--bc: tg
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	(select * from DETAI dt, GIAOVIEN gv2
	where dt.GVCNDT = gv2.MAGV and gv2.HOTEN = N'Trần Trà Hương' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT)))
)

--Q67
--kq: dt - tendt
--c: gv khoa cntt: gv, bm
--bc: tg
select dt.TENDT
from  DETAI dt
where not exists(
	(select * from GIAOVIEN gv, BOMON bm
	where gv.MABM = bm.MABM and bm.MAKHOA = N'CNTT' and not exists(
		(select * from THAMGIADT tg
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV)))
)

--Q68
--kq: gv - ten (gv)
--c: cv dt 'Nghiên cứu..' (madt,stt)
--bc: tg
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	(select * from CONGVIEC cv, DETAI dt
	where cv.MADT = dt.MADT and dt.TENDT = N'Nghiên cứu tế bào gốc' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = cv.MADT and tg.STT = cv.SOTT)))
)

--Q69
--kq: gv
--c: dt có dt.kinhphi > 100tr
--bc: tg
select gv.*
from GIAOVIEN gv
where not exists(
	(select * from DETAI dt
	where dt.KINHPHI > 100 and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT)))
)

--Q70
--kq: dt - tendt
--c: gv khoa 'Sinh'
--bc: tg
select dt.TENDT
from DETAI dt
where not exists(
	(select * from GIAOVIEN gv, KHOA k, BOMON bm
	where gv.MABM = bm.MABM and bm.MAKHOA = k.MAKHOA and k.TENKHOA = N'Sinh học' 
		and not exists(
			(select * from THAMGIADT tg
			where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT))))

--Q71
--kq: gv - magv, hoten, ngsinh
--c: cv thuộc dt "Ứng...'
--bc: tg
select gv.MAGV, gv.HOTEN, gv.NGSINH
from GIAOVIEN gv
where not exists(
	(select * from CONGVIEC cv, DETAI dt
	where cv.MADT = dt.MADT and dt.TENDT = N'Ứng dụng hóa học xanh' and not exists(
		(select * from THAMGIADT tg
		where tg.MAGV = gv.MAGV and tg.MADT = cv.MADT and tg.STT = cv.SOTT)))
)

--q71: Cho"biết"mã"số,"họ"tên,"ngày"sinh"của"giáo"viên"tham"gia"tất"cả"các"công"việc"của"đề"tài"“Ứng"dụng"hóa"học"xanh”.
--c: cv thuộc dt '...'
--kq: gv
--bc: tgdt
select gv.MAGV, gv.HOTEN, gv.NGSINH
from GIAOVIEN gv
where not exists(
	select *
	from CONGVIEC cv join DETAI dt on cv.MADT = dt.MADT
	where dt.TENDT = N'Ứng dụng hóa học xanh' and not exists(
		select *
		from THAMGIADT tg
		where tg.MADT = cv.MADT and tg.STT = cv.SOTT
			and tg.MAGV = gv.MAGV))

--Q72
--kq: gv
--c: dt thuộc cd.tencd = 'Nghiên..'
--bc: tg
select gv.MAGV, gv.HOTEN, bm.TENBM, qlcm.HOTEN as TEN_GVQLCM
from GIAOVIEN gv, BOMON bm, GIAOVIEN qlcm
where gv.MABM = bm.MABM 
	and gv.GVQLCM is not null and qlcm.MAGV = gv.GVQLCM
	and not exists(
		(select * from DETAI dt, CHUDE cd
		where dt.MACD = cd.MACD and cd.TENCD = N'Nghiên cứu phát triển' and not exists(
			(select * from THAMGIADT tg
			where tg.MAGV = gv.MAGV and tg.MADT = dt.MADT)))
)

--q72: Cho"biết"mã"số,"họ"tên,"tên"bộ"môn"và"tên"người"quản"lý"chuyên"môn"của"giáo"viên"tham"gia"tất"cả"các"đề"tài"thuộc"chủ"đề"“Nghiên"cứu"phát"triển”."
--c: dt thuộc cd '..'
--kq: gv + bm
--bc: tgdt
select gv.magv, gv.HOTEN, bm.TENBM, gvql.HOTEN
from GIAOVIEN gv, BOMON bm, GIAOVIEN gvql
where gv.GVQLCM = gvql.MAGV and gv.MABM = bm.MABM and not exists(
	select *
	from DETAI dt join CHUDE cd on dt.MACD = cd.MACD
	where cd.TENCD = N'Nghiên cứu phát triển' and not exists(
		select *
		from THAMGIADT tg
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV))


select *
from GIAOVIEN gv
where not exists(
	select *
	from DETAI dt join CHUDE cd on dt.MACD = cd.MACD
	where cd.TENCD = N'Nghiên cứu phát triển' and not exists(
		select *
		from THAMGIADT tg
		where tg.MADT = dt.MADT and tg.MAGV = gv.MAGV))









