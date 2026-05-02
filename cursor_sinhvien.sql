-- Cursor tăng điểm có giới hạn max = 10

DECLARE @SinhVienID INT;
DECLARE @DiemTB FLOAT;
DECLARE @DiemTruoc FLOAT = NULL;
DECLARE @Tang FLOAT;

-- Bảng tạm để lưu kết quả
DECLARE @KetQua TABLE (
    SinhVienID INT,
    DiemCu FLOAT,
    DiemTang FLOAT,
    DiemMoi FLOAT
);

DECLARE cur_SV CURSOR
FOR
SELECT [SinhVienID], [DiemTB]
FROM [SinhVien]
ORDER BY [SinhVienID];

OPEN cur_SV;

FETCH NEXT FROM cur_SV INTO @SinhVienID, @DiemTB;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @DiemTruoc IS NULL
        SET @Tang = 1;
    ELSE
        SET @Tang = 
            CASE 
                WHEN @DiemTruoc < 5 THEN 0.5
                ELSE 1
            END;

    DECLARE @DiemMoi FLOAT =
        CASE 
            WHEN @DiemTB + @Tang > 10 THEN 10
            ELSE @DiemTB + @Tang
        END;

    INSERT INTO @KetQua
    VALUES (@SinhVienID, @DiemTB, @Tang, @DiemMoi);

    UPDATE [SinhVien]
    SET [DiemTB] = @DiemMoi
    WHERE [SinhVienID] = @SinhVienID;

    SET @DiemTruoc = @DiemTB;

    FETCH NEXT FROM cur_SV INTO @SinhVienID, @DiemTB;
END;

CLOSE cur_SV;
DEALLOCATE cur_SV;

SELECT * FROM @KetQua;
