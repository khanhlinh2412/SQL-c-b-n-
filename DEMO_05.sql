CREATE DATABASE DEMO_05
CREATE TABLE GIAOVIEN(
MAGV VARCHAR(10) PRIMARY KEY,
HOTEN NVARCHAR(50),
NGAYSINH DATE,
QUEQUAN NVARCHAR(50),
GTINH NVARCHAR(10),
)

CREATE TABLE DETAI(
MADT VARCHAR(10) PRIMARY KEY ,
TENDT NVARCHAR(50),
NAMTHHIEN INT,
MAGV VARCHAR(10) REFERENCES GIAOVIEN(MAGV),
)
CREATE TABLE SINHVIEN(
MASV VARCHAR(10) PRIMARY KEY ,
HOTEN NVARCHAR(50),
NGAYSINH DATE,
QUEQUAN NVARCHAR(50),
DIEM INT,
MADT VARCHAR(10) REFERENCES DETAI(MADT),
)

INSERT INTO GIAOVIEN VALUES ('Gv01',N'Trần Thị Loan','1978-5-6',N'Nam Định',N'NỮ')
INSERT INTO GIAOVIEN VALUES ('Gv02',N'Lê Viết Thịnh','1989-5-3',N'Hà Tĩnh','Nam')
INSERT INTO GIAOVIEN VALUES ('Gv03',N'Trần Hữu Thiện','1991-9-1',N'Hà Nội','Nam')

INSERT INTO DETAI VALUES ('D01',N'Công nghệ 4.0',2017,'Gv01')
INSERT INTO DETAI VALUES ('D02',N'Công nghệ Blockchain',2018,'Gv03')
INSERT INTO DETAI VALUES ('D03',N'Bitcoin',2018,'Gv03')

INSERT INTO SINHVIEN VALUES ('S001',N'Lê Quang Tèo','2000-1-1',N'Hà Nội',7,'D02')
INSERT INTO SINHVIEN VALUES ('S002',N'Đỗ Mỹ Linh','1998-5-8',N'Hà Tĩnh',10,'D01')
INSERT INTO SINHVIEN VALUES ('S003',N'Mai Phương Thúy','19996-9',N'Nghệ An',8,'D02')

SELECT * FROM SINHVIEN
SELECT * FROM DETAI 
SELECT * FROM SINHVIEN 

--Câu 2: Đưa ra thông tin: mã sinh viên, họ tên, tên đề tài của các đề tài được giáo viên ‘Trần Thị Loan’   hướng dẫn. (1đ)
SELECT MASV,SINHVIEN.HOTEN,TENDT FROM SINHVIEN
JOIN DETAI ON SINHVIEN.MADT=DETAI.MADT
WHERE MAGV=(SELECT MAGV FROM GIAOVIEN WHERE HOTEN=N'TRẦN THỊ LOAN')

--Câu 3: Đưa ra thông tin: Masv, Hoten, Tuoi của những sinh viên có tuổi>18 và Quequan là ‘Hà Nội’ (1đ)
SELECT MASV,HOTEN,N'TUỔI'=YEAR(GETDATE())-YEAR(NGAYSINH) FROM SINHVIEN
WHERE QUEQUAN=N'HÀ NỘI'

--Câu 4: Đưa ra thông tin giáo viên hướng dẫn nhiều đề tài nhất.Thông tin hiển thị gồm có: Magv, Hoten, số đề tài hướng dẫn (1đ)
SELECT TOP 1 GIAOVIEN.MAGV,HOTEN,COUNT(DETAI.MAGV) FROM GIAOVIEN
JOIN DETAI ON GIAOVIEN.MAGV=DETAI.MAGV 
GROUP BY GIAOVIEN.MAGV,HOTEN
ORDER BY COUNT(DETAI.MAGV) DESC 

--Câu 5: Đưa ra danh sách các đề tài và điểm trung bình của từng đề tài (điểm trung bình của từng đề tài = trung bình cộng điểm của các sinh viên tham gia vào đề tài đó).
--thông tin gồm: Madt, Tendt, Điểm TB. 
SELECT DETAI.MADT,TENDT,'TB'=(SUM(SINHVIEN.DIEM)/COUNT(SINHVIEN.DIEM)) FROM DETAI
JOIN SINHVIEN ON SINHVIEN.MADT=DETAI.MADT 
GROUP BY DETAI.MADT,TENDT

--Câu 6: Thêm một bản ghi mới vào bảng,dữ liệu phù hợp( không được nhập giá trị null). (1đ)
--Câu 7: Thay đổi quê quán của giáo viên Trần thị Loan  thành ‘Hà Nội’
UPDATE GIAOVIEN SET QUEQUAN=N'HÀ NỘI' WHERE HOTEN=N'TRẦN THỊ LOAN'

--Câu 8: Xóa đề tài không có sinh viên chọn. (1đ)
DELETE DETAI WHERE MADT NOT IN (SELECT MADT FROM SINHVIEN)
SELECT * FROM DETAI 