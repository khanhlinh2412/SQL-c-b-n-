create database demo_7
create table DUAN(
mada varchar (10) PRIMARY KEY,
tenda nvarchar (50),
nambatdau int,
)
 create table NHANVIEN(
 manv varchar(10) PRIMARY KEY,
 hoten nvarchar(50),
 ngaysinh date,
 luong int,
 Gtinh nvarchar (10)
 )

 create table chamcong(
 manv varchar(10) REFERENCES NHANVIEN(MANV),
 mada varchar(10) REFERENCES DUAN(MADA),
 sogio int,
 )

INSERT INTO DUAN VALUES ('DA1',N'PHẦN MỀM DẠY HỌC ONLINE',2019)
INSERT INTO DUAN VALUES ('DA2',N'MẠNG TOÀN CẦU',2020)
INSERT INTO DUAN VALUES ('DA3',N'QUẢN LÝ SÁCH',2021)
 SELECT * FROM DUAN 

 INSERT INTO NHANVIEN VALUES ('V01',N'TRẦN VĂN TÈO','1968-03-01',9000000,'NAM')
 INSERT INTO NHANVIEN VALUES ('V02',N'LÊ HUY','1988-03-03',60000000,'NAM')
 INSERT INTO NHANVIEN VALUES ('V03',N'ĐẶNG THỊ HIẾU','2001-01-05',60000000,N'NỮ')
 SELECT * FROM NHANVIEN

 INSERT INTO CHAMCONG VALUES ('V01','DA1',28)
 INSERT INTO CHAMCONG VALUES ('V01','DA2',200)
 INSERT INTO CHAMCONG VALUES ('V02','DA1',90)
 SELECT * FROM CHAMCONG 

 --Câu 2: Đưa ra thông tin: mã nv, hoten, tuổi của những nhân viên có giới tính nam và Tuổi>15. 
 SELECT MANV,HOTEN,N'TUỔI'=YEAR(GETDATE())-YEAR(NGAYSINH) FROM NHANVIEN
 WHERE GTINH='NAM' AND YEAR(GETDATE())-YEAR(NGAYSINH) >15

 --Câu 3: Đưa ra thông tin:MaDA, TenDA của những dự án do nhân viên Lê Huy Tham gia(1đ)
 SELECT DUAN.MADA,TENDA FROM DUAN
 JOIN CHAMCONG ON CHAMCONG.MADA=DUAN.MADA
 JOIN NHANVIEN ON CHAMCONG.MANV=NHANVIEN.MANV
 WHERE HOTEN=N'LÊ HUY'

 --Câu 4: Đưa ra thông tin nhân viên có tổng số giờ lớn nhất Thông tin hiển thị gồm có: 
 --Manv, Hoten, tổng so gio 
 SELECT TOP 1 NHANVIEN.MANV,HOTEN,SUM(CHAMCONG.SOGIO) FROM NHANVIEN 
 JOIN CHAMCONG ON CHAMCONG.MANV=NHANVIEN.MANV 
 GROUP BY NHANVIEN.MANV,HOTEN
 ORDER BY SUM(CHAMCONG.SOGIO) DESC 

 --Câu 5: Đưa ra danh sách 2 nhân viên đầu tiên thông tin gồm :manv, hoten, lương của những nhân viên tham gia dự án Mạng toàn cầu và sắp xếp giảm dần theo Hoten. 
 SELECT TOP 2 NHANVIEN.MANV,HOTEN,LUONG FROM NHANVIEN
 JOIN CHAMCONG ON CHAMCONG.MANV=NHANVIEN.MANV 
 JOIN DUAN ON DUAN.MADA=CHAMCONG.MADA
 WHERE TENDA=N'MẠNG TOÀN CẦU'
 GROUP BY NHANVIEN.MANV,HOTEN,LUONG
 ORDER BY HOTEN DESC 


 --Câu 6: Thêm một bản ghi mới vào bảng chamcong,dữ liệu phù hợp( không được nhập giá trị null). (1đ)
 INSERT INTO CHAMCONG VALUES ('V02','DA2',100)
 SELECT * FROM CHAMCONG 

 --Câu 7: Tăng lương cho mọi nhân viên có mã V02. 
 UPDATE NHANVIEN SET LUONG = LUONG +LUONG * 0.05 WHERE MANV='V02'
 SELECT * FROM NHANVIEN 

 --Câu 8: Xóa nhân viên không tham gia dự án nào (1đ)
 DELETE FROM NHANVIEN
 WHERE MANV NOT IN (SELECT CHAMCONG.MANV FROM CHAMCONG)
 SELECT * FROM NHANVIEN 