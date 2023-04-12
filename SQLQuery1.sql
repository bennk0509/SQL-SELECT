use DB_QLDeTai_21127635
go

--Cho  biết  mã  của  các  giáo  viên  có  họ  tên  bắt  đầu  là  “Nguyễn”  và  lương  trên  $2000  hoặc, 
--giáo  viên  là  trưởng  bộ  môn  nhận  chức  sau  năm  1995.

select g.MAGV
from GIAOVIEN g
where g.HOTEN = N'Nguyễn%' and g.LUONG > 2000
union
select giaovien.magv
from GIAOVIEN join BOMON on GIAOVIEN.MAGV = BOMON.TRUONGBM
where datediff(y,BOMON.NGAYNHANCHUC,1995) < 0 

--Cho  biết  tên  những  giáo  viên  khoa  Công  nghệ  thông  tin.

select GIAOVIEN.HOTEN
from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM join KHOA on khoa.MAKHOA = BOMON.MAKHOA
where KHOA.TENKHOA = N'Công nghệ thông tin'

--Cho  biết  thông  tin  của  bộ  môn  cùng  thông  tin  giảng  viên  làm  trưởng  bộ  môn  đó.
select BOMON.*, GIAOVIEN.*
from BOMON join GIAOVIEN on BOMON.TRUONGBM = GIAOVIEN.MAGV

--Với  mỗi  giáo  viên,  hãy  cho  biết  thông  tin  của  bộ  môn  mà  họ  đang  làm  việc.

select GIAOVIEN.MAGV, BOMON.*
from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM

--Cho  biết  tên  người  chủ  nhiệm  đề  tài  của  những  đề  tài  thuộc  chủ  đề  Quản  lý  giáo  dục.

select distinct GIAOVIEN.HOTEN
from  DETAI join GIAOVIEN on GIAOVIEN.MAGV = DETAI.GVCNDT
join CHUDE on CHUDE.MACD = DETAI.MACD
where CHUDE.TENCD = N'Quản lý giáo dục'

--Cho  biết  số  lượng  giáo  viên  viên  và  tổng  lương  của  họ.
select count(GIAOVIEN.MAGV) as SLGV, sum(GIAOVIEN.LUONG) as TL
from GIAOVIEN

--Cho  biết  số  lượng  giáo  viên  và  lương  trung  bình  của  từng  bộ  môn.
select COUNT(GIAOVIEN.MAGV), avg(GIAOVIEN.LUONG)
from GIAOVIEN
group by GIAOVIEN.MABM
--Cho  biết  tên  chủ  đề  và  số  lượng  đề  tài  thuộc  về  chủ  đề  đó.
select CHUDE.TENCD, count(DETAI.MADT)
from CHUDE join DETAI on CHUDE.MACD = DETAI.MACD
group by CHUDE.TENCD
--Cho  biết  tên  giáo  viên  và  số  lượng  đề  tài  mà  giáo  viên  đó  tham  gia.
select g.HOTEN , count(t.MADT)
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
group by g.HOTEN, g.MAGV

--Cho  biết  tên  giáo  viên  và  số  lượng  đề  tài  mà  giáo  viên  đó  làm  chủ  nhiệm.
select GIAOVIEN.HOTEN, count(DETAI.MADT)
from GIAOVIEN join DETAI on GIAOVIEN.MAGV = DETAI.GVCNDT
group by GIAOVIEN.HOTEN, GIAOVIEN.MAGV

--Cho  biết  tên  những  giáo  viên  đã  tham  gia  từ  1  đề  tài  trở  lên.
select GIAOVIEN.HOTEN
from GIAOVIEN join THAMGIADT on GIAOVIEN.MAGV = THAMGIADT.MAGV
group by GIAOVIEN.MAGV, GIAOVIEN.HOTEN
having count(distinct THAMGIADT.MADT) > 1

--Cho  biết  mức  lương  cao  nhất  của  các  giảng  viên.
select max(GIAOVIEN.LUONG)
from GIAOVIEN

select distinct g.LUONG
from GIAOVIEN g
where g.LUONG >= all (
	select g2.LUONG
	from GIAOVIEN g2)
--Cho  biết  những  giáo  viên  có  lương  lớn  nhất.
select *
from GIAOVIEN
where GIAOVIEN.LUONG >= all (select LUONG from GIAOVIEN)

--Cho  biết  tên  những  giáo  viên  khoa  Công  nghệ  thông  tin  mà  chưa  tham  gia  đề  tài  nào.
-- r : s , r: giao vien, s: tham gia de tai
select g.HOTEN
from GIAOVIEN g join BOMON b on g.MABM = b.MABM
join KHOA k on k.MAKHOA = b.MAKHOA
where k.TENKHOA = N'Công nghệ thông tin'and
 not exists(
		(select THAMGIADT.MAGV from THAMGIADT)
		except
		(
		select gv.MAGV
		from GIAOVIEN gv join BOMON b on gv.MABM = b.MABM
join KHOA k on k.MAKHOA = b.MAKHOA
		where gv.HOTEN = g.HOTEN and k.MAKHOA = N'Công nghệ thông tin'
		)
)

select g.HOTEN
from GIAOVIEN g join BOMON b on g.MABM = b.MABM
	join KHOA k on b.MAKHOA = k.MAKHOA
where k.TENKHOA = N'Công nghệ thông tin' and g.MAGV not in (
	select magv
	from THAMGIADT)

--Tìm  những  trưởng  bộ  môn  tham  gia  tối  thiểu  1  đề  tài
select GIAOVIEN.HOTEN
from GIAOVIEN join BOMON on GIAOVIEN.MAGV = BOMON.TRUONGBM
where exists (select magv from THAMGIADT)

select distinct g.HOTEN
from GIAOVIEN g join BOMON b on g.MAGV = b.TRUONGBM
	join THAMGIADT t on g.MAGV = t.MAGV
--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  đề  tài  đủ  tất  cả  các  chủ  đề
-- R: GIAO VIEN THAM GIA DE TAI (MAGV , MADT )
-- S:  NHUNG DE TAI GOM TAT CA CAC CHU DE
-- kHONG TON TAI GIAO VIEN CHUA THAM GIA DAY DU CAC CHU DE <-> 
SELECT DISTINCT G.HOTEN
FROM GIAOVIEN G JOIN THAMGIADT ON G.MAGV = THAMGIADT.MAGV
WHERE NOT EXISTS (
	(SELECT DISTINCT MACD FROM CHUDE)
	EXCEPT
	(SELECT DISTINCT MACD
	FROM GIAOVIEN GV JOIN THAMGIADT ON GV.MAGV = THAMGIADT.MAGV JOIN DETAI D ON D.MADT = THAMGIADT.MADT
	WHERE GV.HOTEN = G.HOTEN)
)

select gv.HoTen
from GiaoVien gv
join ThamGiaDT tgdt on gv.MaGV = tgdt.MaGV
join DeTai dt on dt.MaDT = tgdt.MaDT
group by (gv.HoTen)
having count(distinct(dt.MaCD)) = (
	select count(distinct(MaCD))
	from ChuDe
)


--Cho  biết  tên  đề  tài  nào  mà  được  tất  cả  các  giáo  viên  của  bộ  môn  HTTT tham  gia.
SELECT D.TENDT
FROM DETAI D
WHERE NOT EXISTS(
	(SELECT MAGV FROM GIAOVIEN WHERE GIAOVIEN.MABM = N'HTTT')
	EXCEPT
	(
	SELECT MAGV
	FROM DETAI D1 JOIN THAMGIADT T ON D1.MADT = T.MADT
	WHERE D1.TENDT = D.TENDT 
	)
)

select d.TENDT
from  DETAI d
where not exists(
	(select distinct g.magv 
	from GIAOVIEN g
	where g.mabm = 'HTTT')
	except
	(select distinct g2.MAGV
	from giaovien g2 join THAMGIADT t on g2.MAGV = t.MAGV
	where t.MADT = d.MADT)
)
--Cho  biết  giáo  viên  nào  đã  tham  gia  tất  cả  các  đề  tài  có  mã  chủ  đề  là  QLGD.
SELECT G.HOTEN
FROM GIAOVIEN G JOIN THAMGIADT T ON G.MAGV = T.MAGV JOIN DETAI ON DETAI.MADT = T.MADT
WHERE DETAI.MACD = N'GLGD' AND NOT EXISTS (
	(SELECT MADT FROM DETAI)
	EXCEPT
	(
	SELECT T.MADT
	FROM GIAOVIEN G2 JOIN THAMGIADT T ON G2.MAGV = T.MAGV JOIN DETAI ON T.MADT = DETAI.MADT
	WHERE DETAI.MACD = N'QLGD'
	)
)

select g.HOTEN
from giaovien g
where not exists (
	(select distinct MADT
	from DETAI
	where MACD = 'QLGD')
	except
	(select distinct d.MADT
	from THAMGIADT t join DETAI d on t.MADT = d.MADT
	where t.MAGV = g.MAGV and d.MACD = 'QLGD')
)
--Cho  biết  tên  giáo  viên  nào  mà  tham  gia  tất  cả  các  công  việc  của  đề  tài  006.

SELECT G.HOTEN
FROM GIAOVIEN G
WHERE NOT EXISTS (
		(SELECT MADT,SOTT FROM CONGVIEC WHERE MADT = N'006')
		EXCEPT
		(
		SELECT T.MADT, T.STT
		FROM GIAOVIEN G2 JOIN THAMGIADT T ON G2.MAGV = T.MAGV JOIN CONGVIEC ON CONGVIEC.MADT = T.MADT
		WHERE T.MADT = N'006' AND G2.HOTEN = G.HOTEN
		)
)


--Q1. Cho biết họ tên và mức lương của các giáo viên nữ.
select HOTEN, LUONG
from GIAOVIEN  
where PHAI = N'Nữ'

--Q2. Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
select HOTEN, LUONG*1.1 as LUONG
from GIAOVIEN


--Q6. Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
select distinct BOMON.*
from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM

--Q8. Với mỗi khoa cho biết thông tin trưởng khoa.
select khoa.MAKHOA, GIAOVIEN.*
from KHOA join GIAOVIEN on KHOA.TRUONGKHOA = GIAOVIEN.MAGV


--Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
select GIAOVIEN.HOTEN, COUNT(THAMGIADT.MADT) AS SLDT
from GIAOVIEN join THAMGIADT on GIAOVIEN.MAGV = THAMGIADT.MAGV
group by GIAOVIEN.HOTEN,THAMGIADT.MAGV

--Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.

SELECT GIAOVIEN.HOTEN, COUNT(DETAI.MADT)
FROM GIAOVIEN JOIN DETAI ON GIAOVIEN.MAGV = DETAI.GVCNDT
GROUP BY GIAOVIEN.HOTEN, DETAI.MADT

--Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó.
SELECT GIAOVIEN.HOTEN, COUNT(NGUOITHAN.TEN)
FROM GIAOVIEN JOIN NGUOITHAN ON GIAOVIEN.MAGV = NGUOITHAN.MAGV
GROUP BY GIAOVIEN.HOTEN, NGUOITHAN.MAGV

--Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
SELECT GIAOVIEN.HOTEN
FROM GIAOVIEN JOIN THAMGIADT ON THAMGIADT.MAGV = GIAOVIEN.MAGV
GROUP BY GIAOVIEN.HOTEN, THAMGIADT.MAGV
HAVING COUNT(THAMGIADT.MADT)>3



--Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
SELECT HOTEN
FROM GIAOVIEN JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE DATEDIFF(D,GIAOVIEN.NGSINH,GETDATE()) >= ALL (SELECT DATEDIFF(D,GIAOVIEN.NGSINH, GETDATE()) FROM GIAOVIEN)

--Q39. Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.

SELECT HOTEN
FROM GIAOVIEN JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE DATEDIFF(D,GIAOVIEN.NGSINH,GETDATE()) <= ALL (SELECT DATEDIFF(D,GIAOVIEN.NGSINH, GETDATE()) FROM GIAOVIEN)

-- Với mỗi khoa hãy cho biết giáo viên có lương cao nhất
select gv.*, k1.MAKHOA
from KHOA k1 Left Join BOMON bm On bm.MAKHOA = k1.MAKHOA Join GIAOVIEN gv On gv.MABM = bm.MABM
where gv.LUONG >= ALL ( 
	select gv1.LUONG
	from KHOA k2 Left Join BOMON bm On bm.MAKHOA = k2.MAKHOA Join GIAOVIEN gv1 On gv1.MABM = bm.MABM 
	Where k1.MAKHOA = k2.MAKHOA
)

select g.*, k1.MAKHOA
from KHOA k1 left join BOMON b on k1.MAKHOA = b.MAKHOA join GIAOVIEN g on b.MABM = g.MABM
where g.LUONG >= all(
	select g1.LUONG
	from KHOA k2 left join BOMON b1 on k2.MAKHOA = b1.MAKHOA join GIAOVIEN g1 on g1.MABM = b1.MABM
	where k1.MAKHOA = k2.MAKHOA
)

--Q41. Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select gv.*
from GIAOVIEN gv join BOMON bm on gv.MABM = bm.MABM
where gv.LUONG >= all
	(
	select gv1.luong
	from GIAOVIEN gv1 join BOMON bm1 on gv1.MABM = bm1.MABM
	where bm.MABM = bm1.MABM
)
--Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
select distinct dt.MADT,dt.TENDT
from DETAI dt 
where dt.MADT not in(
	select distinct t1.MADT
	from THAMGIADT t1 join GIAOVIEN g on g.MAGV = t1.MAGV
	where g.HOTEN = N'Nguyễn Hoài An'
)

--Q43. Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
select distinct dt.MADT,dt.TENDT, g1.HOTEN
from DETAI dt join GIAOVIEN g1 on dt.GVCNDT = g1.MAGV 
where dt.MADT not in(
	select distinct t1.MADT
	from THAMGIADT t1 join GIAOVIEN g on g.MAGV = t1.MAGV
	where g.HOTEN = N'Nguyễn Hoài An'
)

--Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
select distinct g1.HOTEN
from THAMGIADT t join GIAOVIEN g1 on t.MAGV = g1.MAGV
where t.MADT not in (
	select t1.MADT
	from GIAOVIEN g join THAMGIADT t1 on g.MAGV = t1.MAGV
	join BOMON b on b.MABM = g.MABM
	join KHOA k on k.MAKHOA = b.MAKHOA
	where k.TENKHOA = N'Công nghệ thông tin'
)

--Q45. Tìm những giáo viên không tham gia bất kỳ đề tài nào
select GIAOVIEN.*
from GIAOVIEN 
where GIAOVIEN.MAGV not in (
		select THAMGIADT.MAGV
		from THAMGIADT
)

--Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
select g.HOTEN
from BOMON b join GIAOVIEN g on b.TRUONGBM = g.MAGV
where b.TRUONGBM in (select MAGV from THAMGIADT)

--Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Công nghệ phần mềm”
select GIAOVIEN.*
from GIAOVIEN
where GIAOVIEN.LUONG >= (select g.luong from GIAOVIEN g join BOMON b on g.MABM = b.MABM where b.TENBM = N'Công nghệ phần mềm')

--Q51. Cho biết tên khoa có đông giáo viên nhất
select k.TENKHOA
from KHOA k join BOMON b on k.MAKHOA = b.MAKHOA join GIAOVIEN g on g.MABM = b.MABM
group by k.TENKHOA,k.MAKHOA
having count(g.MAGV) >= all(
		select count(g1.MAGV)
		from KHOA k1 join BOMON b1 on k1.MAKHOA = b1.MAKHOA join GIAOVIEN g1 on g1.MABM = b1.MABM
		group by k1.MAKHOA
)		

--Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
select GIAOVIEN.HOTEN, GIAOVIEN.MAGV
from GIAOVIEN join DETAI on GIAOVIEN.MAGV = DETAI.GVCNDT
group by GIAOVIEN.HOTEN, GIAOVIEN.MAGV
having count(DETAI.MADT) >= all (select count(d1.madt) 
from DETAI d1 join GIAOVIEN g1 on g1.MAGV = d1.GVCNDT
group by g1.MAGV)

--Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
select b.MABM
from BOMON b join GIAOVIEN g on b.MABM = g.MABM
group by b.MABM
having count(g.MAGV) >= all(select count(g1.magv) from GIAOVIEN g1 join BOMON b1 on g1.MABM = b1.MABM
group by b1.MABM)

--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
select g.HOTEN, g.MABM
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV join BOMON b on b.MABM = g.MABM
group by g.HOTEN,g.MABM, g.MAGV
having count(t.MADT) >= all(
			select count(t1.MADT)
			from THAMGIADT t1 join GIAOVIEN g1 on t1.MAGV = g1.MAGV
			group by g1.MAGV
)
--Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
select g.HOTEN
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
where g.MABM = N'HTTT'
group by t.MAGV,g.HOTEN
having count(t.MADT) >= all(
					select count(t1.MADT)
					from THAMGIADT t1 join GIAOVIEN g1 on g1.MAGV = t1.MAGV
					where g1.MABM = N'HTTT'
					group by t1.MAGV 
)

--Q58. Cho biết tên giáo viên nào mà tham gia đề tài đủ tất cả các chủ đề.
-- r: giao vien x tham gia de tai
-- s: de tai x chu de

-- khong ton tai nhung de tai day du tat cac cac chu de -> 
 select distinct g.HOTEN
 from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
 where not exists
 (
	(select distinct  c.MACD from CHUDE c)
	except
	(
	select distinct d.MACD
	from GIAOVIEN g2 join THAMGIADT t2 on g2.MAGV = t2.MAGV join DETAI d on d.MADT = t2.MADT
	where g2.HOTEN = g.HOTEN
	)
 )

SELECT DISTINCT G.HOTEN
FROM GIAOVIEN G JOIN THAMGIADT ON G.MAGV = THAMGIADT.MAGV
WHERE NOT EXISTS (
	(SELECT DISTINCT MACD FROM CHUDE)
	EXCEPT
	(SELECT DISTINCT MACD
	FROM GIAOVIEN GV JOIN THAMGIADT ON GV.MAGV = THAMGIADT.MAGV JOIN DETAI D ON D.MADT = THAMGIADT.MADT
	WHERE GV.HOTEN = G.HOTEN)
)

Select distinct gv.HoTen
From GiaoVien gv
Join ThamGiaDT tgdt On gv.MaGV = tgdt.MaGV
Where not Exists (
	Select dt.MaDT From ChuDe cd Join DeTai dt On dt.MaCD = cd.MaCD Where not Exists (
		Select tgdt1.MaDT From GiaoVien gv1 Join ThamGiaDT tgdt1 On tgdt1.MaGV = tgdt.MaGV
	)
)
--Q59. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
select d.TENDT
from DETAI d
where not exists(
		(select GIAOVIEN.MAGV 
			from GIAOVIEN  
			where GIAOVIEN.MABM = N'HTTT')
		except
		(
		select t.MAGV
		from DETAI d1 join THAMGIADT t on d1.MADT = t.MADT
		where d.TENDT = d1.TENDT
		)
)

--Q60. Cho biết tên đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia
select d.TENDT
from DETAI d
where not exists(
	(select g.MAGV from GIAOVIEN g join BOMON b on g.MABM = b.MABM where b.TENBM = N'Hệ thống thông tin')
	except
	(
		select t2.MAGV
		from DETAI d1 join THAMGIADT t2 on d1.MADT = t2.MADT
		where d.TENDT = d1.TENDT
	)
)

--Q61. Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là --QLGD.

select g.HOTEN
from GIAOVIEN g
where not exists
(
	(select d.MADT
	from DETAI d
	where d.MACD = N'QLGD')
	except
	(
		select t.MADT
		from GIAOVIEN g1 join THAMGIADT t on g1.MAGV = t.MAGV
		where g1.HOTEN = g.HOTEN
	)
)

--Q62. Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.

select g.HOTEN
from GIAOVIEN g
where not exists
(
	(select d.MADT from DETAI d join THAMGIADT t on t.MADT = d.MADT join GIAOVIEN g on g.MAGV = t.MAGV
	where t.MAGV = N'Trần Trà Hương')
	except
	(
		select t.MADT
		from THAMGIADT t join GIAOVIEN g1 on g1.MAGV = t.MAGV
		where g.HOTEN = g1.HOTEN
	)
)
--Q63. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn Hóa Hữu Cơ tham gia.

select d.TENDT
from DETAI d
where not exists (
		(select GIAOVIEN.MAGV
		from GIAOVIEN join BOMON on GIAOVIEN.MABM = BOMON.MABM
		where BOMON.TENBM = N'Hóa Hữu Cơ')
		except
		(
			select t1.MAGV
			from DETAI d1 join THAMGIADT t1 on d1.MADT = t1.MADT
			where d.TENDT =  d1.TENDT
		)
)

--Q64. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006.

SELECT G.HOTEN
FROM GIAOVIEN G
WHERE NOT EXISTS (
		(SELECT MADT,SOTT FROM CONGVIEC WHERE MADT = N'006')
		EXCEPT
		(
		SELECT T.MADT, T.STT
		FROM GIAOVIEN G2 JOIN THAMGIADT T ON G2.MAGV = T.MAGV
		WHEre G2.HOTEN = G.HOTEN
		)
)

--Q65. Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề Ứng dụng công nghệ.
select g.HOTEN
from GIAOVIEN g
where not exists 
(
		(select d.MADT
		from DETAI d join CHUDE c on d.MACD = c.MACD where c.TENCD = N'Ứng dụng công nghệ')
		except
		(
			select t.MADT
			from GIAOVIEN g1 join THAMGIADT t on g1.MAGV = t.MAGV
			where g.HOTEN = g1.HOTEN
		)
)

--Q66. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
select g.HOTEN
from GIAOVIEN g
where not exists
(
	(select d.MADT
	from DETAI d join GIAOVIEN g1 on d.GVCNDT = g1.MAGV where g1.HOTEN = N'Trần Trà Hương')
	except
	(
		select t.MADT
		from GIAOVIEN g2 join THAMGIADT t on t.MAGV = g2.MAGV
		where g2.HOTEN = g.HOTEN
	)
)

--Q67. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia.
select d.TENDT
from DETAI d
where not exists
(
	(select g.MAGV
	from GIAOVIEN g join BOMON b on g.MABM = b.MABM where b.MAKHOA = N'CNTT')
	except
	(
		select t1.MAGV
		from DETAI d1 join THAMGIADT t1 on d1.MADT = t1.MADT
		where d.TENDT = d1.TENDT
	)
)

--Q68. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài Nghiên cứu tế bào gốc.
select g.HOTEN
from GIAOVIEN g
where not exists
(
	(select c.SOTT,c.MADT
	from CONGVIEC c join DETAI d on c.MADT = d.MADT where d.TENDT = N'Nghiên cứu tế bào gốc')
	except
	(
		select t.MADT,t.STT
		from GIAOVIEN g1 join THAMGIADT t on g1.MAGV = t.MAGV
		where g.HOTEN = g1.HOTEN
	)
)

--Q69. Tìm tên các giáo viên được phân công làm tất cả các đề tài có kinh phí trên 100 triệu?
select g.HOTEN
from GIAOVIEN g
where not exists
(
	(select d.MADT
	from DETAI d where d.KINHPHI >100000000)
	except
	(
		select t.MADT
		from GIAOVIEN g1 join THAMGIADT t on g1.MAGV = t.MAGV
		where g.HOTEN = g1.HOTEN
	)
)

--Q70. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
select d.TENDT
from DETAI d
where not exists
(
	(select g.MAGV from GIAOVIEN g join BOMON b on g.MABM = b.MABM join KHOA k on k.MAKHOA = b.MAKHOA where k.TENKHOA = N'Sinh Học')
	except
	(
		select t.MAGV
		from DETAI d1 join THAMGIADT t on d1.MADT = t.MADT
		where d1.TENDT = d.TENDT
	)
)

--Q71. Cho biết mã số, họ tên, ngày sinh của giáo viên tham gia tất cả các công việc của đề tài “Ứng dụng hóa học xanh”.
select g.MAGV, g.HOTEN, g.NGSINH
from GIAOVIEN g
where not exists
(
	(select c.MADT,c.SOTT from CONGVIEC c join DETAI d on c.MADT = d.MADT where d.TENDT = N'Ứng dụng hóa học xanh')
	except
	(
	select t.MADT, t.STT
	from GIAOVIEN g2 join THAMGIADT t on g2.MAGV = t.MAGV
	where g.MAGV = g2.MAGV and g.HOTEN = g2.HOTEN and g.NGSINH = g2.NGSINH
	)
)

SELECT GV1.MAGV, GV1.HOTEN, GV1.NGSINH
FROM GIAOVIEN GV1
WHERE not EXISTS (
	(SELECT CONGVIEC.MADT, CONGVIEC.SOTT FROM CONGVIEC JOIN DETAI ON CONGVIEC.MADT = DETAI.MADT WHERE DETAI.TENDT = N'Ứng dụng hóa học xanh')
	EXCEPT
	(SELECT TGDT.MADT, TGDT.STT 
	FROM THAMGIADT TGDT JOIN GIAOVIEN GV2 ON TGDT.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = GV1.HOTEN AND GV2.MAGV = GV1.MAGV AND GV1.NGSINH = GV2.NGSINH)
)
--Q72. Cho biết mã số, họ tên, tên bộ môn và tên người --quản lý chuyên môn của giáo viên tham gia tất cả các đề
--tài thuộc chủ đề “Nghiên cứu phát triển”.
-- r: 
-- s cac de tai thuoc chu de nghien cuu phat trien
select g.MAGV,g.HOTEN, b.TENBM , nqlcm.HOTEN as QLCM
from GIAOVIEN nqlcm join GIAOVIEN g on g.GVQLCM = nqlcm.MAGV join BOMON b on g.MABM = b.MABM
where not exists
(
	(select d.MADT from DETAI d join CHUDE c on d.MACD = c.MACD where c.TENCD = N'Nghiên cứu phát triển')
	except
	(
		select t.MADT
		from GIAOVIEN nqlcm1 join GIAOVIEN g1 on g1.GVQLCM = nqlcm1.MAGV join BOMON b1 on g1.MABM = b1.MABM join THAMGIADT t on t.MAGV = g1.MAGV
		where g.MAGV = g1.MAGV and g.HOTEN = g1.HOTEN and b.TENBM = b1.TENBM and nqlcm.HOTEN = nqlcm1.HOTEN
	)
)

SELECT GV1.MAGV, GV1.HOTEN, BOMON.TENBM, GVV.HOTEN as TenNguoiQuanLy
FROM GIAOVIEN GV1 JOIN BOMON ON BOMON.MABM = GV1.MABM JOIN GIAOVIEN GVV ON GV1.GVQLCM = GVV.MAGV
WHERE NOT EXISTS(
	(SELECT DETAI.MADT FROM DETAI JOIN CHUDE ON DETAI.MACD = CHUDE.MACD WHERE CHUDE.TENCD = N'Nghiên cứu phát triển')
	EXCEPT 
	(SELECT TGDT.MADT
	FROM GIAOVIEN GV2 JOIN THAMGIADT TGDT ON GV2.MAGV = TGDT.MAGV JOIN DETAI DT ON TGDT.MADT = DT.MADT JOIN CHUDE CD ON DT.MACD = CD.MACD
	WHERE CD.TENCD = N'Nghiên cứu phát triển' AND GV2.MAGV = GV1.MAGV)
)

--Q73. Cho biết họ tên, ngày sinh, tên khoa, tên trưởng khoa của giáo viên tham gia tất cả các đề tài có giáo viên “Nguyễn Hoài An” tham gia.
select g.HOTEN, g.NGSINH, k.TENKHOA, TK.HOTEN
from GIAOVIEN g join BOMON b on g.MABM = b.MABM 
join KHOA k on k.MAKHOA = b.MAKHOA 
join GIAOVIEN TK on TK.MAGV = K.TRUONGKHOA
where G.HOTEN NOT LIKE N'Nguyễn Hoài An' and not exists
(
	(select T.MADT from  THAMGIADT t  join GIAOVIEN g2 on g2.MAGV = t.MAGV where g2.HOTEN = N'Nguyễn Hoài An')
	except
	(
		select t1.MADT
		from GIAOVIEN g1 join THAMGIADT t1 on g1.MAGV = t1.MAGV 
		join BOMON b1 on g1.MABM = b1.MABM 
		join KHOA k1 on k1.MAKHOA = b1.MAKHOA 
		join GIAOVIEN TK1 on TK1.MAGV = K1.TRUONGKHOA
		where g.HOTEN = G1.HOTEN AND g.NGSINH = G1.NGSINH AND K1.TENKHOA = K.TENKHOA AND TK.HOTEN = TK1.HOTEN
	)
)

--Q74. Cho biết họ tên giáo viên khoa “Công nghệ thông tin” tham gia tất cả các công việc của đề tài có 
--trưởng bộ môn của bộ môn đông nhất khoa “Công nghệ thông tin” làm chủ nhiệm.
--r:
--s:
--trưởng bộ môn của bộ môn đông nhất khoa “Công nghệ thông tin” làm chủ nhiệm.
select b.TRUONGBM, count(g.MAGV) 
from BOMON b join KHOA k on b.MAKHOA = k.MAKHOA join GIAOVIEN g on g.MABM = b.MABM
where k.TENKHOA = N'Công nghệ thông tin'
group by (b.TRUONGBM)
having count(g.MAGV) >= all( select count(g.magv) from BOMON b join KHOA k on b.MAKHOA = k.MAKHOA join GIAOVIEN g on g.MABM = b.MABM  where k.TENKHOA = N'Công nghệ thông tin' group by (b.TRUONGBM) 
) 
--
Select bm.TruongBM
From GiaoVien gv Join BoMon bm On bm.MaBM = gv.MaBM Join Khoa k On k.MaKhoa = bm.MaKhoa 
Where k.TenKhoa like N'Công nghệ thông tin'
Group By (bm.TruongBM)
Having count(gv.MaGV) >= All ( 
	Select count(gv1.MaGV)
	From GiaoVien gv1 Join BoMon bm1 On bm1.MaBM = gv1.MaBM Join Khoa k1 On k1.MaKhoa = bm1.MaKhoa 
	Where k1.TenKhoa like N'Công nghệ thông tin'
	Group By (bm1.TruongBM)
)
--Q74. Cho biết họ tên giáo viên khoa “Công nghệ thông tin” tham gia tất cả các công việc của đề tài có 
--trưởng bộ môn của bộ môn đông nhất khoa “Công nghệ thông tin” làm chủ nhiệm.
select g1.HOTEN
from GIAOVIEN g1 join BOMON b1 on g1.MABM = b1.MABM join KHOA k1 on k1.MAKHOA = b1.MAKHOA
where k1.TENKHOA = N'Công nghệ thông tin' and
not exists
(
	(select c.MADT,c.SOTT from DETAI d join CONGVIEC c on d.MADT = c.MADT )
	except
	(
		select t.MADT,t.STT
		from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
		where g1.HOTEN = g.HOTEN and g.MAGV = (select b.TRUONGBM
		from BOMON b join KHOA k on b.MAKHOA = k.MAKHOA join GIAOVIEN g on g.MABM = b.MABM
		where k.TENKHOA = N'Công nghệ thông tin' and g1.HOTEN = g.HOTEN
		group by (b.TRUONGBM)
		having count(g.MAGV) >= all( select count(g.magv) from BOMON b join KHOA k on b.MAKHOA = k.MAKHOA join GIAOVIEN g on g.MABM = b.MABM  where k.TENKHOA = N'Công nghệ thông tin' group by (b.TRUONGBM)) 
)

	)
) 

--Q75. Cho biết họ tên giáo viên và tên bộ môn họ làm trưởng bộ môn nếu có

--Q76. Cho danh sách tên bộ môn và họ tên trưởng bộ môn đó nếu có

--Q77. Cho danh sách tên giáo viên và các đề tài giáo viên đó chủ nhiệm nếu có
	select *
	from DETAI join GIAOVIEN on GIAOVIEN.MAGV = DETAI.GVCNDT



