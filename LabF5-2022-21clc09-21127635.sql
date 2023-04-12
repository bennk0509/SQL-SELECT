/*
Ten: Nguyen Khanh Anh Kiet
MSSV: 21127635
Email: nkakiet21@clc.fitus.edu.vn
*/


--Cho biet so luong giao vien va tong luong cua ho
select count(MAGV) as SOLUONGGIAOVIEN, sum(LUONG) as TONGLUONG
from GIAOVIEN

--Cho biet so luong giao vien va luong trung binh cua tung bo mon
select count(MAGV) as SOLUONGGIAOVIEN, avg(LUONG) as LUONGTB
from GIAOVIEN

--Cho biet ten chu de va so luong de tai thuoc chu de do
select c.TENCD, count(d.MADT) as SOLUONGDETAI
from DETAI d join CHUDE c on d.MACD = c.MACD
group by TENCD

--Cho biet ten giao vien va so luong de tai ma giao vien do tham gia
select g.HOTEN, count(t.MAGV) as SOLUONGDETAI
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
group by g.HOTEN

-- Cho biet ten giao vien va so luong de tai ma giao vien do lam chu nhiem
select gv.HOTEN, COUNT(d.MADT) as SOLUONGDETAI
from GIAOVIEN gv join DETAI d on gv.MAGV =  d.GVCNDT
group by gv.HOTEN

-- Voi moi giao vien cho ten giao vien va so nguoi than cua giao vien do
select g.MAGV, count(n.TEN) as SONGUOITHAN
from GIAOVIEN g join NGUOITHAN n on g.MAGV = n.MAGV
group by g.MAGV

-- Cho biet ten nhung giao vien da tham gia tu 3 de tai tro len
select g.HOTEN, count(t.MAGV) as SOLUONGDETAI
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
group by g.HOTEN
having count (t.MADT) >=3
 
 --Cho biet so luong giao vien da tham gia de tai ung dung hoa hoc xanh
select count (distinct tg.MAGV) as SLGIAOVIENTGDTUDHH
from THAMGIADT tg join DETAI d on tg.MADT = d.MADT
where d.TENDT = N'Ứng dụng hóa học xanh'
