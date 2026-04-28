# Bài tập Hệ quản trị cơ sở dữ liệu (TEE560)
## Thông tin sinh viên:
+ **Họ và tên:** Trần Lâm Vũ
+ **Lớp:** K59KMT.K01
+ **Mã số sinh viên:** K235510205299
+ **Trường:** Đại học Kỹ thuật Công nghiệp Thái Nguyên
---
### 1. Cài đặt _SQL Server 2025 Developer_, cài đặt với 2 kiểu login (Mixed Mode): _Windows authentication_ và _SQL Server authentication_ 
<img width="1919" height="1018" alt="Screenshot 2026-04-07 105204" src="https://github.com/user-attachments/assets/35b7ce7f-4f1a-4621-a3b9-253e86ae4c81" />
 
### 2&3. Cấu hình _SQL Server_

+ Các service đang chạy
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/24beeb5e-75f4-49f9-871a-571210aa76dc" />

+ Enable TCP/IP
<img width="842" height="482" alt="image" src="https://github.com/user-attachments/assets/8dd9025e-bb67-432a-b563-c4f3cd5846e7" />

+ Cấu hình chi tiết cho TCP/IP
<img width="1920" height="1080" alt="Screenshot (1)" src="https://github.com/user-attachments/assets/c5d1ec14-f2ae-4757-8aea-5cf2346cda7c" />

+ Listen ALL = YES
<img width="1920" height="1080" alt="Screenshot (2)" src="https://github.com/user-attachments/assets/5cfb5b67-029c-4fe6-bfbb-3b295973ecd1" />

+ IP address + Dynamic Port với cổng `35299`
<img width="1920" height="1080" alt="Screenshot (3)" src="https://github.com/user-attachments/assets/fbc8c06c-09be-42a9-a0e3-17873ea1974a" />

+ Thông báo Mọi thứ đã được lưu lại, restart SQL Server mới có hiệu lực
<img width="1920" height="1080" alt="Screenshot (5)" src="https://github.com/user-attachments/assets/cf44f4a0-0f6e-4d49-a30d-a251ba6ea741" />

+ Restart SQL Server
<img width="1920" height="1080" alt="Screenshot (6)" src="https://github.com/user-attachments/assets/f633bb58-a774-4794-a22f-3593b493b0e5" />

+ Kiểm tra cổng `35299` có đang mở bằng lệnh cmd `netstat -ano | findstr LISTENING`
<img width="1920" height="1080" alt="Screenshot 2026-04-07 220352" src="https://github.com/user-attachments/assets/0de02574-a86a-4561-b7a7-5e8729b0b4e5" />

+ Kiểm tra lại bằng tool _CurrPorts v2.61 - Monitoring Opened TCP/IP network ports_
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/27f5fd95-6c40-4168-b5e9-979533f0119d" />

+ SQL Server đang mở cổng `35299`
<img width="1920" height="1080" alt="Screenshot (10)" src="https://github.com/user-attachments/assets/5c60ecc9-082b-41b4-9ddc-58e75d34d073" />

### 4. Cài đặt _SQL Server Management Studio 22_
<img width="1920" height="1080" alt="Screenshot (11)" src="https://github.com/user-attachments/assets/881790b4-ebe7-473d-bedf-8a0196d9b6ec" />

### 5. Đăng nhập vào _SQL Server Management Studio 22_ bằng 2 cách: _Windows authentication_ và _SQL Server authentication_

* Kết nối bằng _Windows authentication_:
<img width="1920" height="1080" alt="Screenshot (12)" src="https://github.com/user-attachments/assets/e97295e7-e664-479d-8818-e1eba3798249" />

* Kết nối bằng _SQL Server authentication_
<img width="1920" height="1080" alt="Screenshot (13)" src="https://github.com/user-attachments/assets/0d3e5db4-5f12-4708-871d-944daa3cda77" />

* Kết quả login bằng 2 cách
<img width="1920" height="1080" alt="Screenshot 2026-04-07 223059" src="https://github.com/user-attachments/assets/457ac5dd-dbb4-4d56-bb23-8827a9809a7f" />

### 6. Tạo cơ sở dữ liệu mới

+ Database: `Quanly_Sinhvien`
<img width="1604" height="897" alt="image" src="https://github.com/user-attachments/assets/2ac30b06-fe89-4c4c-a1cd-78f30cd70aa2" />

+ Đường dẫn (Path) lưu trữ file dữ liệu `Quanly_Sinhvien_Data` và file lưu log `Quanly_Sinhvien_Log` : `E:\SQLData`
<img width="1920" height="1080" alt="Screenshot (16)" src="https://github.com/user-attachments/assets/6b3c404d-2457-4ba7-9c1f-73a5f3e325ab" />

### 7. Tạo bảng dữ liệu với tên `SinhVien`, có Khóa chính (Primary Key) là trường `masv`
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2cc0281b-f923-47e8-92d9-29e758f28676" />

### 8. Import dữ liệu từ file mẫu `svtnut.csv`

+ Import dữ liệu
<img width="1920" height="1080" alt="Screenshot (21)" src="https://github.com/user-attachments/assets/7c169624-d2d5-464a-91bc-dcdf392817b2" />

+ Import dữ liệu thành công
<img width="1920" height="1080" alt="Screenshot (22)" src="https://github.com/user-attachments/assets/cfd24c03-42cf-44bf-89f0-1565793fa88d" />

### 9. Kiểm tra số dòng của bảng dữ liệu sau khi import
<img width="1920" height="1080" alt="Screenshot (25)" src="https://github.com/user-attachments/assets/b90ad1ff-be73-463f-accd-0703c2d57c69" />

### 10. Thêm dữ liệu cá nhân của sinh viên vào bảng

+ Thêm dữ liệu thành công
<img width="1920" height="1080" alt="Screenshot (24)" src="https://github.com/user-attachments/assets/e0365598-66ec-409f-8bc1-56daf410dc14" />

+ Kiểm tra dữ liệu sau khi nhập
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3f2f6330-166d-488f-9c70-b2dc97789802" />

### 11.  Gõ lệnh để update trường _noisinh_ thành 'Sao Hoả' cho những dòng có _noisinh_ và _diachi_ đều là NULL
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/e96111cd-9312-4fed-a2d2-bbff0aa7bb1e" />

### 12. Tạo bảng `SaoHoa` gồm những sinh viên có nơi sinh ở 'Sao Hoả'
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/a095bf12-1064-4a6b-82c5-5c106507d61e" />

+ Kiểm tra bảng `SaoHoa`
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/a0df9a35-a42c-42f5-a92a-5e612de0d9b7" />

### 13. Xóa những sinh viên có cùng họ Trần
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/d8a0c21e-31af-4528-a554-ab62d2971090" />

### 14. Xuất toàn bộ kết quả của các bước 6 -> 13 ra file `dulieu.sql`
<img width="1920" height="1080" alt="Screenshot (28)" src="https://github.com/user-attachments/assets/eb7ac844-e7e7-466d-82b4-f464e138705f" />

+ Xuất file `dulieu.sql` thành công
<img width="1920" height="1080" alt="Screenshot (29)" src="https://github.com/user-attachments/assets/775fc12d-0b91-423a-b466-518596d8cbb1" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/406a1017-f1a8-45b4-bb3e-dfd4593309db" />

### 15. Xóa cơ sở dữ liệu `Quanly_Sinhvien`
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/a987d656-5e2c-49ed-9820-9de8998f29b6" />

+ Kiểm tra path 
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/2d6f76a6-19eb-4915-9c15-d7f18f8aa91e" />

### 16. Mở file dữ liệu `dulieu.sql`
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/26d23cff-b621-48ee-8f8c-79c0f5fbff7f" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/11e43367-da2d-4026-9d2d-10ed60df536a" />

### 17. Upload file `dulieu.sql` lên Github repository của em
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/252987d6-3134-4216-830e-7ceb0ec44ad3" />

