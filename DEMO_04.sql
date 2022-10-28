create database demo04

create table loaiphong(
maph varchar(10) primary key,
tenphong nvarchar(50),
dongia int,
)
insert into loaiphong values('ph01',N'Phòng đơn',500000)
insert into loaiphong values('ph02',N'Phòng đôi',700000)
insert into loaiphong values('ph03',N'Phòng VIP',1000000)
select * from loaiphong


create table khachhang(
makh varchar(10) primary key,
tenkh nvarchar(50),
maph varchar(10) references loaiphong(maph),
ngaythue date,
ngaytra date,
)
insert into khachhang values ('kh01',N'Lê Văn Nghĩa','ph01','2020-02-15','2020-02-17')
insert into khachhang values ('kh02',N'Nguyễn Thị Lan','ph02','2020-01-12','2020-01-18')
insert into khachhang values ('kh03',N'Khánh linh','ph02','2020-01-22','2020-01-24')
select * from khachhang 

create table dichvu(
maph varchar(10) references loaiphong(maph),
makh varchar(10) references khachhang(makh),
ngay date,
tiendv int,
tendv nvarchar(20),
)
 insert into dichvu values  ('ph01','kh01','2020-02-16',30000,N'Giặt ủi')
 insert into dichvu values ('ph02','kh02','2020-01-17',10000,N'Điểm tâm')
 insert into dichvu values ('ph02','kh02','2020-01-18',20000,N'Điện thoại')
 select * from dichvu 

 --Câu 2. Viết lệnh SQL hiển thị thông tin: tenkh, tenphong, ngaythue, ngaytra, songaythue, dongia, tienphong.
 --Trong đó tienphong = songaythue * dongia. 
 select tenkh, tenphong, ngaythue, ngaytra, 
 'SNT'=(dAY(ngaytra)-DAY(ngaythue)), dongia,'TP'=((DAY(ngaytra)-DAY(ngaythue))*dongia) from khachhang
 join loaiphong on loaiphong.maph=khachhang.maph 

 --Câu 3. Tìm thông tin các khách hàng có họ là ‘Lê’ và thuê phòng trong tháng 2 năm 2020. 
 --Hiển thi kết quả có các trường: tenkh, maphong, ngaythue, ngaytra (1 điểm)
 select tenkh,maph,ngaythue,ngaytra from khachhang
 where tenkh like N'Lê%' AND MONTH(NGAYTHUE)=2 AND YEAR(NGAYTHUE)=2020
    
 --Câu 4. Viết lệnh SQL để liệt kê ra các khách có số ngày ở lớn nhất của mỗi phòng. Kết quả hiển thị có các trường sau: 
 --Tên khách hàng, Mã phòng, tên phòng và số ngày ở. (1 điểm)
 select tenkh,khachhang.maph,tenphong,'SNT'=(dAY(ngaytra)-DAY(ngaythue)) from khachhang
 join loaiphong on khachhang.maph=loaiphong.maph 

 --câu 5. Tìm các phòng chưa có khách thuê từ tháng 1 năm 2020. Hiển thị các thông tin: Maphong, tenphong, dongia. 

 --Câu 6. Viết lệnh: 
---	Chèn thêm một bản ghi mới  vào bảng DICHVU không chứa giá trị null. (1 điểm)
---	Xóa những khách thuê phòng trước ngày 01/01/2020. (1 điểm)
---	Giảm 50% đơn giá cho các phòng là “phòng đôi”  (1 điểm)
