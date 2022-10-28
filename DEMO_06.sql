﻿CREATE DATABASE DEMO_06
CREATE TABLE KHACHHANG(
MAKH VARCHAR(10) PRIMARY KEY,
HOTEN NVARCHAR(50),
NGAYSINH DATE,
QUEQUAN NVARCHAR(50),
GTINH NVARCHAR(10),
)
CREATE TABLE NHANVIEN(
MANV VARCHAR(10) PRIMARY KEY,
HOTENNV NVARCHAR(50),
NAMLAMVIEC INT,
LUONG INT,
)
CREATE TABLE DONDATHANG(
SOHD VARCHAR(10)PRIMARY KEY,
MAKH VARCHAR(10) REFERENCES KHACHHANG(MAKH),
MANV VARCHAR(10) REFERENCES NHANVIEN(MANV),
SANPHAM NVARCHAR(20),
)
INSERT INTO KHACHHANG VALUES ('Kh01',N'Trần Thị Hoa','1977-5-4',N'Hà Nội',N'Nữ')
INSERT INTO KHACHHANG VALUES ('Kh02',N'Nguyễn Phong','1999-3-5',N'Hà Tĩnh','Nam')
INSERT INTO KHACHHANG VALUES ('Kh03',N'Đặng Bảo Nam','1991-1-5',N'Nam Định','Nam')

INSERT INTO NHANVIEN VALUES ('Nv1',N'Trần An Nhiên',2013,60000000)
INSERT INTO NHANVIEN VALUES ('Nv2',N'Lê Bình An',2018,90000000)
INSERT INTO NHANVIEN VALUES ('Nv3',N'Phan Huy Văn',2020,50000000)

INSERT INTO DONDATHANG VALUES ('H001',N'Kh01','Nv1',N'BÁNH GẠO')
INSERT INTO DONDATHANG VALUES ('H002',N'Kh02','Nv1',N'GIÀY')
INSERT INTO DONDATHANG VALUES ('H003',N'Kh03','Nv2',N'TÚI')

SELECT * FROM KHACHHANG
SELECT * FROM NHANVIEN
SELECT * FROM DONDATHANG 

--Câu 2: Đưa ra thông tin: 
--mã khách hàng, họ tên,  giới tính của những khách hàng đặt sản phẩm giày. (1đ)
SELECT KHACHHANG.MAKH,HOTEN,GTINH FROM KHACHHANG
JOIN DONDATHANG ON KHACHHANG.MAKH=DONDATHANG.MAKH 
WHERE SANPHAM=N'GIÀY'

--Câu 3: Đưa ra thông tin: Makh, Hoten, Tuoi của những khách hàng có tuổi>18 và Quequan là ‘Hà Nội’ (1đ)
SELECT MAKH,HOTEN,N'TUỔI'=YEAR(GETDATE())-YEAR(NGAYSINH) FROM KHACHHANG
WHERE YEAR(GETDATE())-YEAR(NGAYSINH) >18 AND QUEQUAN=N'HÀ NỘI'

--Câu 4: Đưa ra thông tin nhân viên bán được nhiều sản phẩm nhất Thông tin hiển thị gồm có: 
--Manv, HotenNV, số lượng sản phẩm (1đ)
SELECT TOP 1 NHANVIEN.MANV,HOTENNV,'SLSP'=COUNT(DONDATHANG.MANV) FROM NHANVIEN
JOIN DONDATHANG ON NHANVIEN.MANV=DONDATHANG.MANV 
GROUP BY NHANVIEN.MANV,HOTENNV
ORDER BY COUNT(DONDATHANG.MANV) DESC 

--Câu 5: Đưa ra danh sách :manv, hotenNV của những nhân viên có lương trên mức lương trung bình của nhân viên. (1đ)
SELECT MANV,HOTENNV FROM NHANVIEN WHERE LUONG>(SELECT AVG(LUONG) FROM NHANVIEN)

--Câu 6: Thêm một bản ghi mới vào bảng,dữ liệu phù hợp( không được nhập giá trị null). (1đ)
--Câu 7: Thay đổi năm làm việc của nhân viên Lê Bình An  thành 2010. (1đ)
--Câu 8: Xóa nhân viên không đặt được đơn hàng nào. (1đ)
DELETE NHANVIEN WHERE MANV NOT IN (SELECT MANV FROM DONDATHANG)
SELECT * FROM NHANVIEN 