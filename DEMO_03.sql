create database demo_03
create table khachhang(
makh varchar(10) primary key,
tenkh nvarchar(20),
taikhoan varchar(10),
)
insert into khachhang values ('kh1',N'Tùng','00054502')
insert into khachhang values ('kh2','Nga','00082347')
insert into khachhang values ('kh3',N'Vân','00056341')
select * from khachhang

create table sach(
mas varchar(10) primary key,
tieude nvarchar(20),
dongia int,
ghichu nvarchar(20),
)
insert into sach values ('S01',N'Tin học',75000,N'Mới nhập')
insert into sach values ('S02',N'Văn học',82000,N'Hết sách')
insert into sach values ('S03',N'công nghệ',110000,N'còn sách')
select * from sach

create table donhang(
madh varchar(10) primary key,
makh varchar(10) references khachhang(makh),
mas varchar(10) references sach(mas),
soluong int,
)
insert into donhang values ('001','kh1','S02',7)
insert into donhang values ('002','kh1','S03',10)
insert into donhang values ('003','kh3','S02',20)
select * from donhang 

--Câu 2: Hiển thị thông tin: MaKH, TenKH, Masach, soluong, dongia, thanhtien (1 điểm)
select khachhang.makh,tenkh,sach.mas,soluong,dongia,(dongia*soluong) as N'Thành tiền' from khachhang
join donhang on donhang.makh=khachhang.makh
join sach on sach.mas=donhang.mas 


--Câu 3: Hiển thị Top 2 khách hàng mua hàng với số tiền nhiều nhất gồm các thông tin sau:
--MaKH, Masach, soluong, dongia, thanhtien 
select top 2 makh,donhang.mas,soluong,dongia,(dongia * soluong) as N'Thành tiền' from donhang
join sach on donhang.mas=sach.mas
group by makh,donhang.mas,soluong,dongia
order by (dongia * soluong) desc

select top 2 makh,donhang.mas,soluong,dongia,N'Thành tiền'=sum(dongia * soluong) from donhang
join sach on sach.mas=donhang.mas 
group by makh,donhang.mas,soluong,dongia
order by N'Thành tiền' desc 


--Câu 4: Hiển thị các sách có số lượng nằm trong khoảng từ 10 đến 20.
select * from sach join donhang on sach.mas=donhang.mas where soluong between 10 and 20 

--Câu 5: Hiển thị MaDH, MaKH, tổng thành tiền đã mua trong từng đơn hàng.
--Chỉ hiển thị những đơn hàng có tổng thành tiền >=500.000 và sắp xếp theo thứ tự giảm dần của cột tổng thành tiền. 
select madh,makh, sum(dongia * soluong) as N'Tổng thành tiền' from donhang
join sach on sach.mas=donhang.mas 
group by madh,makh
having sum(dongia * soluong) >=500000

--Câu 6: Hiển thị tên sách có số lượng  đặt mua nhỏ hơn số lượng mua trung bình của các sách. 
select tieude from sach 
join donhang on donhang.mas=sach.mas
where soluong <(select avg(soluong) from donhang)

--Câu 8: Cập nhật lại số TAIKHOAN của khách hàng  KH3 là: “00000001” 
update khachhang set taikhoan='00000001' where makh='kh3'
select * from khachhang 