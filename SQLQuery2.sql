/*
Ho va ten: Nguyen Khanh Anh Kiet
MSSV: 21127635
Email: nkakiet21@clc.fitus.edu.vn
*/

use DB_QLDeTai_21127635
go

--Cho biet ten giao vien nao ma tham gia de tai du tat ca cac chu de
select gv.HOTEN
from GIAOVIEN gv
where not exists(
		(select cd.macd from CHUDE cd)
		except
		(select dt.macd
		from GIAOVIEN gv1 join THAMGIADT t on gv1.MAGV=t.MAGV
		join DETAI dt on t.MADT=dt.MADT
		where gv1.HOTEN = gv.HOTEN)
)

select gv.HOTEN
from GIAOVIEN gv
where not exists (
	select *
	from CHUDE c
	where not exists(
	select *
	from GIAOVIEN gv1 join THAMGIADT t on gv1.MAGV = t.MAGV join DETAI d on d.MADT = t.MADT
	where d.MACD = c.MACD and gv1.HOTEN = gv.HOTEN
	)
)

SELECT GV1.HOTEN
FROM GIAOVIEN GV1 JOIN THAMGIADT TGDT ON GV1.MAGV = TGDT.MAGV JOIN DETAI DT ON TGDT.MADT = DT.MADT
GROUP BY GV1.HOTEN
HAVING COUNT(DISTINCT DT.MACD) = (
	SELECT COUNT(DISTINCT MACD)
	FROM CHUDE
) 

--Cho biet ten de tai nao ma duoc tat ca cac giao vien cua bo mon HTTT tham gia
select dt.TENDT
from DETAI dt
where not exists (
		(select g.MAGV from GIAOVIEN g where g.MABM = N'HTTT')
		except
		(select gv.MAGV
		from THAMGIADT tg join GIAOVIEN gv on tg.MAGV = gv.MAGV
		join DETAI d on d.MADT  = tg.MADT
		where dt.TENDT = d.TENDT and gv.MABM = N'HTTT')
)

--Cho biet ten de tai co tat ca giang vien bo mon 'He thong thong tin' tham gia
select dt.TENDT
from DETAI dt
where not exists(
		(select gv.MAGV from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM where bm.TENBM = N'Hệ thống thông tin')
		except
		(
		select tg.MAGV
		from THAMGIADT tg 
		join GIAOVIEN gv1 on tg.MAGV = gv1.MAGV 
		join BOMON bm1 on bm1.MABM = gv1.MABM
		join DETAI d on d.MADT = tg.MADT
		where d.TENDT = dt.TENDT and bm1.TENBM = N'Hệ thống thông tin'
		)
)

--Cho biet cac giao vien nao da tham gia tat ca cac de tai co ma chu de la QLGD
select gv.*
from GIAOVIEN gv
where not exists(
		(select dt.MADT from DETAI dt where dt.MACD = N'QLGD')
		except
		(select tgdt.MADT
		from GIAOVIEN gv1 join THAMGIADT tgdt on tgdt.MAGV = gv1.MAGV
		join DETAI dt1 on dt1.MADT = tgdt.MADT
		where dt1.MACD = N'QLGD' and gv1.MAGV = gv.MAGV)
)

--Cho biet ten giao vien nao tham gia tat ca cac de tai ma giao vien tran tra huong da tham gia
select gv.HOTEN
from GIAOVIEN gv
where not exists(
		(select tgdt.MADT
		from THAMGIADT tgdt join GIAOVIEN gv1 on tgdt.MAGV = gv1.MAGV
		where gv1.HOTEN = N'Trần Trà Hương'
		)
		except
		(
		select tg1.MADT
		from GIAOVIEN gv2 join THAMGIADT tg1 on gv2.MAGV = tg1.MAGV
		where gv2.HOTEN = gv.HOTEN and gv2.HOTEN not like N'Trần Trà Hương'
		)
)
--Cho biet ten de tai nao ma duoc tat ca cac giao vien cua bo mon Hoa Huu Co tham gia
select dt.TENDT
from DETAI dt
where not exists(
		(select gv.MAGV 
		from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM
		where bm.TENBM = N'Hóa hữu cơ'
		)
		except 
		(select tgdt.MAGV
		from THAMGIADT tgdt 
		join GIAOVIEN gv1 on tgdt.MAGV = gv1.MAGV
		join DETAI dt1 on dt1.MADT = tgdt.MADT
		join BOMON bm1 on bm1.MABM = gv1.MABM
		where dt1.TENDT = dt.TENDT and bm1.TENBM = N'Hóa hữu cơ'
		)
)
--Cho biet ten giao vien nao ma tham gia tat ca cac cong viec cua de tai 006
select gv.HOTEN
from GIAOVIEN gv
where not exists(
		(select cv.MADT, cv.SOTT from CONGVIEC cv where cv.MADT = N'006')
		except
		(select tg.MADT, tg.STT
		from THAMGIADT tg join GIAOVIEN gv1 on tg.MAGV = gv1.MAGV
		where gv.HOTEN= gv1.HOTEN)
)

--Cho biet giao vien nao da tham gia tat ca cac de tai cua chu de ung dung cong nghe
select gv.*
from GIAOVIEN gv
where not exists(
	(select dt.MADT from DETAI dt join CHUDE cd on cd.MACD = dt.MACD where cd.TENCD = N'Ứng dụng công nghệ')
	except
	(select tg.MADT
	from GIAOVIEN gv1 join THAMGIADT tg on gv1.MAGV = tg.MAGV
	join DETAI dt1 on tg.MADT = dt1.MADT 
	join CHUDE cd1 on dt1.MACD = cd1.MACD
	where cd1.TENCD = N'Ứng dụng công nghệ' and gv1.MAGV = gv.MAGV
	)
)


--Cho biet ten giao vien nao da tham gia tat ca cac de tai do tran tra huong chu nhiem
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	(select dt.MADT
	from GIAOVIEN gv1 join DETAI dt on dt.GVCNDT = gv1.MAGV
	where gv1.HOTEN = N'Trần Trà Hương')
	except
	(select tg.MADT
	from THAMGIADT tg join GIAOVIEN gv2 on tg.MAGV = gv2.MAGV
	where gv.HOTEN = gv2.HOTEN)
)

-- Cho biet ten de tai nao ma duoc tat ca cac giao vien cua khoa CNTT tham gia
select dt.TENDT
from DETAI dt
where not exists(
	(select magv
	from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM
	join KHOA on BOMON.MAKHOA = KHOA.MAKHOA 
	where KHOA.TENKHOA = N'Công nghệ thông tin')
	except
	(select magv
	from THAMGIADT join DETAI on THAMGIADT.MADT = DETAI.MADT
	where dt.TENDT = DETAI.TENDT)
)


--Cho biet ten giao vien nao ma tham gia tat ca cac cong viec cua de tai Nghien cuu te bao goc
select gv.HOTEN
from GIAOVIEN gv
where not exists(
	(select CONGVIEC.MADT
	from CONGVIEC join DETAI on CONGVIEC.MADT = DETAI.MADT
	where DETAI.TENDT = N'Nghiên cứu tế bào gốc')
	except
	(select TGDT.MADT, TGDT.STT 
	from THAMGIADT TGDT JOIN GIAOVIEN GV1 ON TGDT.MAGV = GV2.MAGV
	where gv.HOTEN = GV1.HOTEN)
)


--Tim ten cac giao vien duoc phan cong lam tat ca cac de tai co kinh phi tren 100 trieu
select gv.hoten
from GIAOVIEN gv
where not exists(
	(select madt from DETAI where KINHPHI > 100)
	except
	(select madt from THAMGIADT where MAGV = gv.MAGV)
)

--Cho biet ten de tai nao ma duoc tat ca cac giao vien cua khoa Sinh Hoc tham gia
select dt.tendt
from DETAI dt
where not exists (
		(select magv from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM
		join KHOA on BOMON.MAKHOA = KHOA.MAKHOA where TENKHOA = N'Sinh học')
		except
		(select magv from THAMGIADT join DETAI on THAMGIADT.MADT = DETAI.MADT
		WHERE DETAI.TENDT = DT.TENDT)
)

--Cho biet ma so, ho ten, ngay sinh cua giao vien tham gia tat ca cac cong viec cua de tai Ung dung hoa hoc xanh
SELECT GV1.MAGV, GV1.HOTEN, GV1.NGSINH
FROM GIAOVIEN GV1
WHERE EXISTS (
	(SELECT CONGVIEC.MADT, CONGVIEC.SOTT FROM CONGVIEC JOIN DETAI ON CONGVIEC.MADT = DETAI.MADT WHERE DETAI.TENDT = N'Ứng dụng hóa học xanh')
	EXCEPT
	(SELECT TGDT.MADT, TGDT.STT 
	FROM THAMGIADT TGDT JOIN GIAOVIEN GV2 ON TGDT.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = GV1.HOTEN AND GV2.MAGV = GV1.MAGV AND GV1.NGSINH = GV2.NGSINH)
)

--Cho biet ma so, ho ten, ten bo mon va ten nguoi quan ly chuyen mon cua giao vien tham gia tat cac cac de tai thuoc chu de nghien cuu phat trien

SELECT GV1.MAGV, GV1.HOTEN, BOMON.TENBM, GVV.HOTEN as TenNguoiQuanLy
FROM GIAOVIEN GV1 JOIN BOMON ON BOMON.MABM = GV1.MABM JOIN GIAOVIEN GVV ON GV1.GVQLCM = GVV.MAGV
WHERE NOT EXISTS(
	(SELECT DETAI.MADT FROM DETAI JOIN CHUDE ON DETAI.MACD = CHUDE.MACD WHERE CHUDE.TENCD = N'Nghiên cứu phát triển')
	EXCEPT 
	(SELECT TGDT.MADT
	FROM GIAOVIEN GV2 JOIN THAMGIADT TGDT ON GV2.MAGV = TGDT.MAGV JOIN DETAI DT ON TGDT.MADT = DT.MADT JOIN CHUDE CD ON DT.MACD = CD.MACD
	WHERE CD.TENCD = N'Nghiên cứu phát triển' AND GV2.MAGV = GV1.MAGV)
)

--Cho biet ho ten, ngay sinh, ten khoa, ten truong khoa cua giao vien tham gia tat ca cac de tai co giao vien Nguyen Hoai An tham gia
SELECT GV1.HOTEN, GV1.NGSINH, KH.TENKHOA, GVV.HOTEN as TenTruongKhoa
FROM GIAOVIEN GV1 JOIN BOMON ON BOMON.MABM = GV1.MABM JOIN KHOA KH ON BOMON.MAKHOA = KH.MAKHOA JOIN GIAOVIEN GVV ON GV1.GVQLCM = GVV.MAGV
WHERE NOT EXISTS(
	(SELECT TGDT1.MADT FROM GIAOVIEN GV2 JOIN THAMGIADT TGDT1 ON GV2.MAGV = TGDT1.MAGV WHERE GV2.HOTEN = N'Nguyễn Hoài An')
	EXCEPT
	(SELECT TGDT2.MADT FROM GIAOVIEN GV3 JOIN THAMGIADT TGDT2 ON GV3.MAGV = TGDT2.MAGV
	WHERE GV3.HOTEN = GV1.HOTEN)
)


