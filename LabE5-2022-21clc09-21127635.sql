/*
Ho ten: Nguyen Khanh Anh Kiet
MSSV: 21127635
Email: nkakiet21@clc.fitus.edu.vn
*/

--Cho biet thong tin cua bo mon cung thong tin giang vien lam truong bo mon do
select* 
from BOMON b left join GIAOVIEN g on b.TRUONGBM = g.MAGV 

-- Voi moi giao vien, hay cho biet thong tin cua bo mon ma ho dang lam viec
select g.MAGV, b.*
from BOMON b right join GIAOVIEN g on b.MABM=g.MABM

--Cho biet ten de tai va giao vien chu nhiem de tai
select d.TENDT, g.*
from DETAI d join GIAOVIEN g on d.GVCNDT = g.MAGV

--Voi moi khoa cho biet thong tin truong khoa
select k.MAKHOA,g.*
from KHOA k join GIAOVIEN g on k.TRUONGKHOA = g.MAGV

--Cho biet cac giao vien cua bo mon vi sinh co tham gia de tai 006
select g.*
from GIAOVIEN g join BOMON b on g.MABM = b.MABM
where b.TENBM = N'Vi sinh'
intersect
select g.*
from GIAOVIEN g join THAMGIADT t on g.MAGV = t.MAGV
where t.MADT = N'006'

--Voi nhung de tai thuoc cap quan ly 'Thanh pho', cho biet ma de tai
--de tai thuoc chu de nao, ho ten nguoi chu nhiem de tai cung voi ngay sinh va dia chi cua nguoi ay

select d.MADT, c.TENCD , g.HOTEN, g.NGSINH,g.DIACHI
from DETAI d
inner join CHUDE c on d.MACD = c.MACD 
inner join GIAOVIEN g on d.GVCNDT = g.MAGV
where d.CAPQL = N'Thành phố'

--Tim ho ten cua tung giao vien va nguoi phu trach chuyen mon truc tiep cua giao vien do
select g.HOTEN, gvpt.HOTEN as HOTENNGUOIPHUTRACH
from GIAOVIEN g join GIAOVIEN gvpt on g.GVQLCM = gvpt.MAGV

--Tim ho ten cua nhung giao vien duoc Nguyen Thanh Tung phu trach truc tiep
select gv.HOTEN
from GIAOVIEN gv join GIAOVIEN ntt on gv.GVQLCM = ntt.MAGV
where ntt.HOTEN = N'Nguyễn Thanh Tùng'

--Cho biet ten giao vien la truong bo mon he thong thong tin
select gv.HOTEN
from BOMON bm join GIAOVIEN gv on bm.TRUONGBM = gv.MAGV
where bm.TENBM = N'Hệ thống thông tin'

--Cho biet ten nguoi chu nhiem de tai cua nhung de tai thuoc chu de quan ly giao duc
select distinct g.HOTEN as CHUNHIEMDETAI
from DETAI d 
join GIAOVIEN g on d.GVCNDT = g.MAGV
join CHUDE c on d.MACD = c.MACD 
where c.TENCD = N'Quản lý giáo dục'

-- Cho biet ten cac cong viec cua de tai HTTT quan ly cac truong DH co thoi gian bat dau trong 3/2008

select c.TENCV
from CONGVIEC c
join DETAI d on d.MADT = c.MADT
where d.TENDT = N'HTTT quản lý các trường ĐH'
and datediff(m, c.NGAYBD, '2008/03/01') <= 0 and datediff(m, '2008/04/01', c.NGAYBD) <= 0

-- Cho biet ten giao vien va ten nguoi quan ly chuyen mon cua giao vien do
select g.HOTEN, gvpt.HOTEN as HOTENNGUOIPHUTRACH
from GIAOVIEN g join GIAOVIEN gvpt on g.GVQLCM = gvpt.MAGV

--Cho cac cong viec bat dau trong khoang tu 01/01/2007 den 01/08/2007
select CONGVIEC.* from CONGVIEC
where datediff(d,'2007/01/01',CONGVIEC.NGAYBD) >= 0 and datediff(d,'2007/08/01',CONGVIEC.NGAYBD) <= 0