# Bài tập Hệ quản trị cơ sở dữ liệu (TEE560)
## Thông tin sinh viên:
+ **Họ và tên:** Trần Lâm Vũ
+ **Lớp:** K59KMT.K01
+ **Mã số sinh viên:** K235510205299
+ **Trường:** Đại học Kỹ thuật Công nghiệp Thái Nguyên
---
### Phần 1: Thiết kế và Khởi tạo Cấu trúc Dữ liệu
1. Chọn đề tài: *Quản lý lớp học*, tạo database
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/14b7783c-e2e1-4376-84a2-44e905451f90" />

2. Tạo ít nhất 3 bảng có quan hệ với nhau
+ Tạo bảng [SinhVien]
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/48d9e01c-1382-4bb7-8762-ca50ad4e7abe" />

+ Tạo bảng [MonHoc]
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/1e592cc9-723b-4199-825b-83a194ce26b2" />

+ Tạo bảng [DangKy]
<img width="1918" height="1076" alt="image" src="https://github.com/user-attachments/assets/38c45b95-43c1-4201-8beb-7d3890ed410e" />

3. Kết quả tạo database + bảng
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/d69b16b2-4658-4711-96ce-4db2c7d0c00f" />

### Phần 2: Xây dựng Function
#### Các loại hàm Build_in Funtion trong SQL Server:

+ Hàm xử lý chuỗi: `LEN()`, `UPPER()`, `LOWER()`

+ Hàm số học: `ABS()`, `ROUND()`

+ Hàm ngày tháng: `GETDATE()`, `DATEDIFF()`

+ Hàm tổng hợp: `SUM()`, `AVG()`, `COUNT()`

+ Hàm chuyển đổi: `CAST()`, `CONVERT()`

#### Một số ví dụ khai thác các hàm:

+ `DATEDIFF()` – tính tuổi sinh viên
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/583ad335-a85e-4675-b946-80b4dadb114b" />

+ `LEN()` – độ dài tên sinh viên
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/52e90b79-f5fe-4519-91f5-40245d0b833b" />

+ `UPPER()` – viết hoa tên
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/35861970-0d34-40da-93ae-d2cff5b11685" />

+ `AVG()` – tính điểm trung bình
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/f50aa948-b4c5-4428-bbdc-869b4a86a0d5" />

#### Hàm do người dùng tự viết trong SQL (User-defined Function)
Mục đích:
- Tái sử dụng các đoạn xử lý nhiều lần 
- Làm câu lệnh SQL ngắn gọn, dễ đọc hơn 
- Xử lý các nghiệp vụ riêng của bài toán (ví dụ: xếp loại sinh viên, tính điểm, lọc dữ liệu)

#### Các loại hàm:
1. Scalar Function
- Trả về 1 giá trị duy nhất 
- Dùng khi cần tính toán hoặc xử lý đơn lẻ

2. Inline Table-Valued Function
- Trả về 1 bảng dữ liệu
- Chỉ gồm 1 câu SELECT đơn giản
- Dùng khi lọc danh sách theo điều kiện

3. Multi-statement Table-Valued Function
- Trả về 1 bảng dữ liệu
- Có thể chứa nhiều lệnh, dùng biến bảng
- Dùng khi xử lý logic phức tạp nhiều bước

#### Tại sao vẫn cần tự viết function ?
Mặc dù SQL Server có nhiều system function (built-in), nhưng:
- Chúng chỉ giải quyết các bài toán chung
- Không đáp ứng được yêu cầu riêng của từng hệ thống 

=> Vì vậy cần tự viết function để:
- Xử lý logic đặc thù (ví dụ: quy tắc xếp loại riêng) 
- Tái sử dụng nhiều lần 
- Giúp code rõ ràng, dễ bảo trì 

