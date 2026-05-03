# Bài tập Hệ quản trị cơ sở dữ liệu (TEE560)
## Thông tin sinh viên:
+ **Họ và tên:** Trần Lâm Vũ
+ **Lớp:** K59KMT.K01
+ **Mã số sinh viên:** K235510205299
+ **Trường:** Đại học Kỹ thuật Công nghiệp Thái Nguyên

---
### Phần 1: Thiết kế và Khởi tạo Cấu trúc Dữ liệu
1. Chọn đề tài: *Quản lý lớp học*, tạo database `QuanLyLopHoc_K235510205299`
```sql
CREATE DATABASE [QuanLyLopHoc_K235510205299];
GO
USE [QuanLyLopHoc_K235510205299];
GO
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/14b7783c-e2e1-4376-84a2-44e905451f90" />

2. Tạo ít nhất 3 bảng có quan hệ với nhau
+ Tạo bảng [SinhVien]
```sql
CREATE TABLE [SinhVien] (
    [SinhVienID] INT IDENTITY(1,1) PRIMARY KEY, -- PK
    [HoTen] NVARCHAR(100) NOT NULL,
    [NgaySinh] DATE,
    [GioiTinh] NVARCHAR(10) 
        CHECK ([GioiTinh] IN (N'Nam', N'Nữ')), -- CK
    [DiemTB] FLOAT 
        CHECK ([DiemTB] BETWEEN 0 AND 10) -- CK
);
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/48d9e01c-1382-4bb7-8762-ca50ad4e7abe" />

+ Tạo bảng [MonHoc]
```sql
CREATE TABLE [MonHoc] (
    [MonHocID] INT IDENTITY(1,1) PRIMARY KEY, -- PK
    [TenMonHoc] NVARCHAR(100) NOT NULL,
    [SoTinChi] INT 
        CHECK ([SoTinChi] > 0), -- CK
    [HocPhi] DECIMAL(10,2) 
        CHECK ([HocPhi] >= 0) -- CK
);
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/1e592cc9-723b-4199-825b-83a194ce26b2" />

+ Tạo bảng [DangKy]
```sql
CREATE TABLE [DangKy] (
    [DangKyID] INT IDENTITY(1,1) PRIMARY KEY, -- PK
    [SinhVienID] INT,
    [MonHocID] INT,
    [NgayDangKy] DATE DEFAULT GETDATE(),
    [Diem] FLOAT 
        CHECK ([Diem] BETWEEN 0 AND 10), -- CK

    CONSTRAINT [FK_DangKy_SinhVien]
        FOREIGN KEY ([SinhVienID]) 
        REFERENCES [SinhVien]([SinhVienID]), -- FK

    CONSTRAINT [FK_DangKy_MonHoc]
        FOREIGN KEY ([MonHocID]) 
        REFERENCES [MonHoc]([MonHocID]) -- FK
);
```
<img width="1918" height="1076" alt="image" src="https://github.com/user-attachments/assets/38c45b95-43c1-4201-8beb-7d3890ed410e" />

3. Kết quả tạo database + bảng
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/d69b16b2-4658-4711-96ce-4db2c7d0c00f" />

---
### Phần 2: Xây dựng Function
#### Các loại hàm Build_in Funtion trong SQL Server:

+ Hàm xử lý chuỗi: `LEN()`, `UPPER()`, `LOWER()`

+ Hàm số học: `ABS()`, `ROUND()`

+ Hàm ngày tháng: `GETDATE()`, `DATEDIFF()`

+ Hàm tổng hợp: `SUM()`, `AVG()`, `COUNT()`

+ Hàm chuyển đổi: `CAST()`, `CONVERT()`

#### Một số ví dụ khai thác các hàm:

+ `DATEDIFF()` – tính tuổi sinh viên
```sql
SELECT 
    [HoTen],
    [NgaySinh],
    DATEDIFF(YEAR, [NgaySinh], GETDATE()) AS [Tuoi]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/583ad335-a85e-4675-b946-80b4dadb114b" />

+ `LEN()` – độ dài tên sinh viên
```sql
SELECT 
    [HoTen],
    LEN([HoTen]) AS [DoDaiTen]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/52e90b79-f5fe-4519-91f5-40245d0b833b" />

+ `UPPER()` – viết hoa tên
```sql
SELECT 
    UPPER([HoTen]) AS [TenInHoa]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/35861970-0d34-40da-93ae-d2cff5b11685" />

+ `AVG()` – tính điểm trung bình
```sql
SELECT 
    AVG([DiemTB]) AS [DiemTrungBinh]
FROM [SinhVien];
```
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

#### Hàm Scalar Function (Hàm trả về một giá trị):
Idea: Xếp loại sinh viên theo điểm trung bình
```sql
-- Tạo hàm
CREATE FUNCTION [fn_XepLoai] (@Diem FLOAT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @KQ NVARCHAR(20);

    IF (@Diem >= 8)
        SET @KQ = N'Gioi';
    ELSE IF (@Diem >= 6.5)
        SET @KQ = N'Kha';
    ELSE IF (@Diem >= 5)
        SET @KQ = N'Trung Binh';
    ELSE
        SET @KQ = N'Yeu';

    RETURN @KQ;
END;
GO
-- Khai thác hàm
SELECT 
    [HoTen],
    [DiemTB],
    dbo.fn_XepLoai([DiemTB]) AS [XepLoai]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/9b3377a2-b4c5-4f7d-84ce-66ba4d70bf8c" />

#### Hàm Inline Table-Valued Function:
Idea: Lấy danh sách sinh viên có điểm ≥ giá trị nhập vào
```sql
-- Tạo hàm
CREATE FUNCTION [fn_SinhVienDiemCao] (@Diem FLOAT)
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM [SinhVien]
    WHERE [DiemTB] >= @Diem
);
GO

-- Khai thác hàm
SELECT * 
FROM dbo.fn_SinhVienDiemCao(7);
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/f7dbb357-3f9e-4cac-bd55-823c950e3773" />

#### Hàm Multi-statement Table-Valued Function:
Idea: Tạo danh sách sinh viên kèm xếp loại
```sql
-- Tạo hàm
CREATE FUNCTION [fn_DanhSachXepLoai]()
RETURNS @KQ TABLE (
    [HoTen] NVARCHAR(100),
    [DiemTB] FLOAT,
    [XepLoai] NVARCHAR(20)
)
AS
BEGIN
    INSERT INTO @KQ
    SELECT 
        [HoTen],
        [DiemTB],
        dbo.fn_XepLoai([DiemTB])
    FROM [SinhVien];

    RETURN;
END;
GO

-- Khai thác hàm
SELECT * 
FROM dbo.fn_DanhSachXepLoai();
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/1032a95c-9e29-4799-b3aa-fad89fa40fb5" />

---
### Phần 3: Xây dựng Store Procedure
#### Stored Procedure (SP) có sẵn trong SQL Server
Trong SQL Server có các System Stored Procedure (SP) là các thủ tục được xây dựng sẵn để:
- Quản lý database
- Xem thông tin bảng, cột
- Hỗ trợ lập trình và quản trị

*Thường có tiền tố: `sp_`*

### Một số System SP em tìm hiểu được:
1. `sp_help` – Xem thông tin bảng
```sql
EXEC sp_help 'SinhVien';
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/076eb60b-9a60-4f4f-896c-802541e9f074" />

2. `sp_columns` – Xem chi tiết cột
```sql
EXEC sp_columns 'SinhVien';
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/aec60bff-7a26-4e55-97d4-3124263c098b" />

3. `sp_helpconstraint` – Xem ràng buộc
```sql
EXEC sp_helpconstraint 'DangKy';
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/032083d6-e74f-4b2f-93fb-d5d59c6cf134" />

4. `sp_databases` – Xem danh sách database
```sql
EXEC sp_databases;
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/5fbd1c2b-8501-4951-9c6d-05e25e3657d3" />

#### Stored Procedure INSERT (có kiểm tra điều kiện)
Idea: Thêm sinh viên mới nhưng điểm phải từ 0 → 10, nếu sai thì không cho thêm.
```sql
-- Tạo SP
CREATE PROCEDURE [sp_ThemSinhVien]
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiemTB FLOAT
AS
BEGIN
    IF (@DiemTB < 0 OR @DiemTB > 10)
    BEGIN
        PRINT N'Diem khong hop le';
        RETURN;
    END

    INSERT INTO [SinhVien] ([HoTen], [NgaySinh], [GioiTinh], [DiemTB])
    VALUES (@HoTen, @NgaySinh, @GioiTinh, @DiemTB);
END;
GO

-- Gọi SP
EXEC sp_ThemSinhVien 
    N'Pham Van D', '2005-03-10', N'Nam', 8.2;
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/61422cf2-d9a2-4c50-a0df-681c5902f173" />

#### Stored Procedure có OUTPUT
Idea: Tính điểm trung bình của toàn bộ sinh viên và trả về qua biến OUTPUT.
```sql
-- Tạo SP
CREATE PROCEDURE [sp_TinhDiemTrungBinh]
    @DiemTB FLOAT OUTPUT
AS
BEGIN
    SELECT @DiemTB = AVG([DiemTB])
    FROM [SinhVien];
END;
GO

-- Gọi SP
DECLARE @KQ FLOAT;

EXEC sp_TinhDiemTrungBinh @KQ OUTPUT;

SELECT @KQ AS [DiemTrungBinh];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/b38faa23-fa00-4e75-81ed-6c922385a752" />

#### Stored Procedure JOIN nhiều bảng
Idea: Lấy danh sách sinh viên + tên môn học + điểm từ bảng đăng ký.
```sql
-- Tạo SP
CREATE PROCEDURE [sp_DanhSachDangKy]
AS
BEGIN
    SELECT 
        sv.[HoTen],
        mh.[TenMonHoc],
        dk.[Diem]
    FROM [DangKy] dk
    INNER JOIN [SinhVien] sv 
        ON dk.[SinhVienID] = sv.[SinhVienID]
    INNER JOIN [MonHoc] mh 
        ON dk.[MonHocID] = mh.[MonHocID];
END;
GO

-- Gọi SP
EXEC sp_DanhSachDangKy;
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/8694316f-fea8-44a2-81f9-52e4e6eb38f8" />

---
### Phần 4: Trigger và Xử lý logic nghiệp vụ
+ Trigger để tự động làm gì đó tại 1 bảng A khi mà dữ liệu thay đổi dữ liệu ở bảng B:
Idea: Khi cập nhật điểm trong bảng DangKy → Tự động cập nhật điểm trung bình trong bảng SinhVien
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/34a700db-f736-4b21-aeed-9b39a269c10e" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/0e2e7b25-1b76-4a93-8f23-96bc7b058c23" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/56a21397-a393-4abf-92c4-33ad2eb6330d" />
Trigger A → B (SinhVien → DangKy)
Khi thêm dữ liệu vào bảng SinhVien, trigger sẽ tự động tạo một bản ghi tương ứng trong bảng DangKy. Điều này giúp hệ thống tự động đăng ký môn học cho sinh viên mà không cần nhập thủ công.
Insert SinhVien → Trigger chạy → Thêm dữ liệu vào DangKy

+ Trigger cho Bảng A : Khi insert thì cập nhật dữ liệu vào bảng B; sau đó viết trigger cho bảng B để khi B được cập nhật thì cập nhật sang bảng A
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/ffc56d75-32af-4cd7-9250-7bad891b9cee" />
<img width="1917" height="1077" alt="image" src="https://github.com/user-attachments/assets/44bf6532-0c41-4454-9835-23e0fd9085ea" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/5f70cb02-c492-4067-9560-2a64c4e50631" />
Trigger B → A (DangKy → SinhVien)
Khi cập nhật điểm trong bảng DangKy, trigger sẽ tự động tính lại điểm trung bình và cập nhật vào bảng SinhVien, giúp dữ liệu luôn chính xác.
Update DangKy → Trigger chạy → Cập nhật lại SinhVien

---
### Phần 5: Cursor và Duyệt dữ liệu
+ Script sử dụng CURSOR:
```sql
DECLARE @HoTen NVARCHAR(100);
DECLARE @DiemTB FLOAT;
DECLARE @XepLoai NVARCHAR(50);

DECLARE cur_SinhVien CURSOR
FOR
SELECT [HoTen], [DiemTB]
FROM [SinhVien];

OPEN cur_SinhVien;

FETCH NEXT FROM cur_SinhVien INTO @HoTen, @DiemTB;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @XepLoai =
        CASE 
            WHEN @DiemTB >= 8 THEN N'Gioi'
            WHEN @DiemTB >= 6.5 THEN N'Kha'
            WHEN @DiemTB >= 5 THEN N'Trung Binh'
            ELSE N'Yeu'
        END;

    PRINT N'SV: ' + @HoTen + N' - Xep loai: ' + @XepLoai;

    FETCH NEXT FROM cur_SinhVien INTO @HoTen, @DiemTB;
END;

CLOSE cur_SinhVien;
DEALLOCATE cur_SinhVien;
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/e44334e4-25f3-46e4-b8a4-b636b19bf19c" />
Khi đó:
- CURSOR duyệt từng dòng
- Mỗi sinh viên được xử lý riêng
- In ra kết quả từng người

+ Script không sử dụng CURSOR
```sql
SELECT 
    [HoTen],
    [DiemTB],
    CASE 
        WHEN [DiemTB] >= 8 THEN N'Gioi'
        WHEN [DiemTB] >= 6.5 THEN N'Kha'
        WHEN [DiemTB] >= 5 THEN N'Trung Binh'
        ELSE N'Yeu'
    END AS [XepLoai]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/e34b88a9-8ef5-491e-a2e6-388c522efc1e" />
Khi đó:
- SQL xử lý toàn bộ dữ liệu cùng lúc
- Không cần duyệt từng dòng
- Ngắn hơn + nhanh hơn

+ So sánh tốc độ giữa CURSOR và không dùng CURSOR
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/f2f7c264-b161-465a-a086-7b64e0dfcbe4" />
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/bdd4c137-bde9-4f13-9e18-3c2aafea4b50" />

Ý tưởng bài toán mà CURSOR thích hợp hơn
Tăng điểm từng sinh viên nhưng:
+ Nếu sinh viên trước < 5 → sinh viên sau chỉ được cộng 0.5
+ Nếu ≥ 5 → cộng 1
```sql
SELECT 
    [HoTen],
    [DiemTB],
    CASE 
        WHEN [DiemTB] >= 8 THEN N'Gioi'
        WHEN [DiemTB] >= 6.5 THEN N'Kha'
        WHEN [DiemTB] >= 5 THEN N'Trung Binh'
        ELSE N'Yeu'
    END AS [XepLoai]
FROM [SinhVien];
```
<img width="1918" height="1078" alt="image" src="https://github.com/user-attachments/assets/40d27e43-8f65-44c9-99a6-959d8a1f8103" />
CURSOR giúp xử lý từng sinh viên theo thứ tự và áp dụng logic phụ thuộc vào bản ghi trước, nhưng có nhược điểm là tốc độ chậm hơn so với các câu lệnh SQL thông thường. Tuy nhiên, trong những bài toán có logic phức tạp và phụ thuộc giữa các bản ghi, CURSOR lại phù hợp và dễ triển khai hơn so với SQL thuần.





