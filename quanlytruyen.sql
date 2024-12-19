-- Bảng: KhachHang
CREATE TABLE khachhang
(
    makhachhang VARCHAR(10) PRIMARY KEY,                       -- Mã khách hàng [KH0001, KH0002...]
    hoten       VARCHAR(50) NOT NULL,                          -- Họ và tên (không được để trống)
    ngaysinh    DATE,                                          -- Ngày sinh
    gioitinh    VARCHAR(10) CHECK (gioitinh IN ('Nam', 'Nữ')), -- Giới tính chỉ cho phép "Nam" hoặc "Nữ"
    diachi      VARCHAR(100),
    sodienthoai VARCHAR(15) ,                            -- Số điện thoại phải là duy nhất
    email       VARCHAR(50) UNIQUE,                            -- Email phải là duy nhất
    tentaikhoan VARCHAR(50) UNIQUE,                            -- Tên tài khoản (duy nhất)
    matkhau     VARCHAR(100) NOT NULL                          -- Mật khẩu không được để trống
);

-- Bảng: TaiKhoan
CREATE TABLE taikhoan
(
    mataikhoan    VARCHAR(10) PRIMARY KEY,      -- Mã tài khoản [TK0001, TK0002...]
    tentaikhoan   VARCHAR(50)  NOT NULL UNIQUE, -- Tên tài khoản (duy nhất)
    matkhau       VARCHAR(100) NOT NULL,        -- Mật khẩu không được để trống
    chucvu        VARCHAR(50)  NOT NULL,        -- Chức vụ
    hotennv       VARCHAR(50)  NOT NULL,        -- Họ tên nhân viên
    sodienthoainv VARCHAR(15) UNIQUE            -- Số điện thoại phải là duy nhất
);

-- Bảng: LoaiTruyen
CREATE TABLE loaitruyen
(
    maloaitruyen VARCHAR(10) PRIMARY KEY,    -- Mã loại truyện [LT0001, LT0002...]
    tenloai      VARCHAR(50) NOT NULL UNIQUE -- Tên loại truyện phải là duy nhất
);

-- Bảng: Truyen
CREATE TABLE truyen
(
    matruyen     VARCHAR(10) PRIMARY KEY,            -- Mã truyện [TR0001, TR0002...]
    tentruyen    VARCHAR(50) NOT NULL,               -- Tên truyện không được để trống
    tacgia       VARCHAR(50),                        -- Tác giả
    soluong      INT CHECK (soluong >= 0),           -- Số lượng >= 0
    giathue      DECIMAL(10, 2) CHECK (giathue > 0), -- Giá thuê phải lớn hơn 0
    maloaitruyen VARCHAR(10) NOT NULL,               -- Mã loại truyện
    FOREIGN KEY (maloaitruyen) REFERENCES loaitruyen (maloaitruyen)
);

-- Bảng: HoatDongThue
CREATE TABLE hoatdongthue
(
    mahoatdong    VARCHAR(10) PRIMARY KEY,         -- Mã hoạt động thuê [HD0001, HD0002...]
    mataikhoan    VARCHAR(10)            NOT NULL, -- Mã tài khoản
    makhachhang   VARCHAR(10)            NOT NULL, -- Mã khách hàng
    ngaylap       DATE DEFAULT CURDATE() NOT NULL, -- Ngày lập hóa đơn, mặc định là ngày hiện tại
    hantra        DATE                   NOT NULL, -- Hạn trả phải lớn hơn ngày lập hóa đơn
    trangthaithue VARCHAR(20)            NOT NULL, -- Trạng thái thuê
    FOREIGN KEY (mataikhoan) REFERENCES taikhoan (mataikhoan),
    FOREIGN KEY (makhachhang) REFERENCES khachhang (makhachhang)
);

-- Bảng: ChiTietThue
CREATE TABLE chitietthue
(
    mahoatdong VARCHAR(10),                        -- Mã hoạt động thuê
    matruyen   VARCHAR(10),                        -- Mã truyện
    soluong    INT CHECK (soluong > 0),            -- Số lượng thuê > 0
    giathue    DECIMAL(10, 2) CHECK (giathue > 0), -- Giá thuê > 0
    PRIMARY KEY (mahoatdong, matruyen),            -- Khóa chính kết hợp
    FOREIGN KEY (mahoatdong) REFERENCES hoatdongthue (mahoatdong),
    FOREIGN KEY (matruyen) REFERENCES truyen (matruyen)
);

//lam sao sinh dc script nay, lam sao bo 
-- INSERT Bảng KhachHang
INSERT INTO khachhang (makhachhang, hoten, ngaysinh, gioitinh, diachi, sodienthoai, email, tentaikhoan, matkhau)
VALUES ('KH0001', 'Nguyen Van A', STR_TO_DATE('1990-01-01', '%Y-%m-%d'), 'Nam', 'Hanoi', '0123456789', 'a@example.com', 'nguyenvana', 'password123'),
       ('KH0002', 'Tran Thi B', STR_TO_DATE('1992-05-10', '%Y-%m-%d'), 'Nữ', 'Ho Chi Minh', '0987654321', 'b@example.com', 'tranthib', 'password456'),
       ('KH0003', 'Le Van C', STR_TO_DATE('1985-07-15', '%Y-%m-%d'), 'Nam', 'Da Nang', '0932123456', 'c@example.com', 'levanc', 'password789'),
       ('KH0004', 'Pham Thi D', STR_TO_DATE('2000-03-25', '%Y-%m-%d'), 'Nữ', 'Can Tho', '0912345678', 'd@example.com', 'phamthid', 'password012');

-- INSERT Bảng TaiKhoan
INSERT INTO taikhoan (mataikhoan, tentaikhoan, matkhau, chucvu, hotennv, sodienthoainv)
VALUES ('TK0001', 'admin', 'password123', 'Quản lý', 'Nguyen Van Quan', '0901234567'),
       ('TK0002', 'nhanvien01', 'password456', 'Nhân viên', 'Le Thi Linh', '0918765432');

-- INSERT Bảng LoaiTruyen
INSERT INTO loaitruyen (maloaitruyen, tenloai)
VALUES ('LT0001', 'Truyện tranh'),
       ('LT0002', 'Tiểu thuyết'),
       ('LT0003', 'Truyện ngắn');

-- INSERT Bảng Truyen
INSERT INTO truyen (matruyen, tentruyen, tacgia, soluong, giathue, maloaitruyen)
VALUES ('TR0001', 'Doraemon', 'Fujiko F. Fujio', 10, 5000, 'LT0001'),
       ('TR0002', 'Conan', 'Gosho Aoyama', 8, 6000, 'LT0001'),
       ('TR0003', 'Harry Potter', 'J.K. Rowling', 5, 8000, 'LT0002'),
       ('TR0004', 'Truyen Kieu', 'Nguyen Du', 7, 7000, 'LT0003');

-- INSERT Bảng HoatDongThue
INSERT INTO hoatdongthue (mahoatdong, mataikhoan, makhachhang, ngaylap, hantra, trangthaithue)
VALUES ('HD0001', 'TK0001', 'KH0001', STR_TO_DATE('2024-12-01', '%Y-%m-%d'), STR_TO_DATE('2024-12-10', '%Y-%m-%d'), 'Đang thuê'),
       ('HD0002', 'TK0002', 'KH0002', STR_TO_DATE('2024-12-03', '%Y-%m-%d'), STR_TO_DATE('2024-12-12', '%Y-%m-%d'), 'Đã trả');

-- INSERT Bảng ChiTietThue
INSERT INTO chitietthue (mahoatdong, matruyen, soluong, giathue)
VALUES ('HD0001', 'TR0001', 2, 5000),
       ('HD0001', 'TR0003', 1, 8000),
       ('HD0002', 'TR0002', 1, 6000);


-- PROCEDURE: tao_khachhang_moi
DELIMITER //

CREATE PROCEDURE tao_khachhang_moi (
    IN ten VARCHAR(50),
    IN ngaysinh DATE,
    IN gioitinh VARCHAR(10),
    IN diachi VARCHAR(100),
    IN sdt VARCHAR(15),
    IN email VARCHAR(50)
)
BEGIN
    DECLARE ma_khach_moi VARCHAR(10);

SELECT CONCAT('KH', LPAD(COALESCE(MAX(CAST(SUBSTRING(makhachhang, 3) AS UNSIGNED)), 0) + 1, 4, '0'))
INTO ma_khach_moi
FROM khachhang;

INSERT INTO khachhang (makhachhang, hoten, ngaysinh, gioitinh, diachi, sodienthoai, email)
VALUES (ma_khach_moi, ten, ngaysinh, gioitinh, diachi, sdt, email);
END //

DELIMITER ;

-- PROCEDURE: capnhat_khachhang
DELIMITER //

CREATE PROCEDURE capnhat_khachhang (
    IN ma_khach VARCHAR(10),
    IN ten VARCHAR(50),
    IN ngaysinh DATE,
    IN gioitinh VARCHAR(10),
    IN diachi VARCHAR(100),
    IN sdt VARCHAR(15),
    IN email VARCHAR(50)
)
BEGIN
UPDATE khachhang
SET hoten = ten,
    ngaysinh = ngaysinh,
    gioitinh = gioitinh,
    diachi = diachi,
    sodienthoai = sdt,
    email = email
WHERE makhachhang = ma_khach;
END //

DELIMITER ;

-- PROCEDURE: xoa_khachhang
DELIMITER //

CREATE PROCEDURE xoa_khachhang (
    IN ma_khach VARCHAR(10)
)
BEGIN
DELETE FROM khachhang
WHERE makhachhang = ma_khach;
END //

DELIMITER ;

-- PROCEDURE: tao_taikhoan_moi
DELIMITER //

CREATE PROCEDURE tao_taikhoan_moi (
    IN ten_tk VARCHAR(50),
    IN mk VARCHAR(100),
    IN chuc_vu VARCHAR(50),
    IN ten_nv VARCHAR(50),
    IN sdt_nv VARCHAR(15)
)
BEGIN
    DECLARE ma_tk_moi VARCHAR(10);

SELECT CONCAT('TK', LPAD(COALESCE(MAX(CAST(SUBSTRING(mataikhoan, 3) AS UNSIGNED)), 0) + 1, 4, '0'))
INTO ma_tk_moi
FROM taikhoan;

INSERT INTO taikhoan (mataikhoan, tentaikhoan, matkhau, chucvu, hotennv, sodienthoainv)
VALUES (ma_tk_moi, ten_tk, mk, chuc_vu, ten_nv, sdt_nv);
END //

DELIMITER ;

-- PROCEDURE: capnhat_soluong_truyen
DELIMITER //

CREATE PROCEDURE capnhat_soluong_truyen (
    IN ma_truyen VARCHAR(10),
    IN so_luong INT
)
BEGIN
UPDATE truyen
SET soluong = so_luong
WHERE matruyen = ma_truyen;
END //

DELIMITER ;





-- Trigger: kiemtra_soluong_thue_before_insert
DELIMITER //

CREATE TRIGGER kiemtra_soluong_thue_before_insert
    BEFORE INSERT ON chitietthue
    FOR EACH ROW

BEGIN
    DECLARE sl_hientai INT;
    SELECT soluong
    INTO sl_hientai
    FROM truyen
    WHERE matruyen = NEW.matruyen;

    IF NEW.soluong > sl_hientai THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng thuê vượt quá số lượng truyện hiện có.';
END IF;
END //

DELIMITER ;

-- Trigger: kiemtra_soluong_thue_before_update
DELIMITER //

CREATE TRIGGER kiemtra_soluong_thue_before_update
    BEFORE UPDATE ON chitietthue
    FOR EACH ROW
BEGIN
    DECLARE sl_hientai INT;
    SELECT soluong
    INTO sl_hientai
    FROM truyen
    WHERE matruyen = NEW.matruyen;

    IF NEW.soluong > sl_hientai THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng thuê vượt quá số lượng truyện hiện có.';
END IF;
END //

DELIMITER ;

-- Trigger: log_capnhat_khachhang
DELIMITER //

CREATE TRIGGER log_capnhat_khachhang
    AFTER UPDATE ON khachhang
    FOR EACH ROW
BEGIN
    INSERT INTO log_table (action, table_name, record_id, timestamp)
    VALUES ('UPDATE', 'khachhang', OLD.makhachhang, NOW());
END //

DELIMITER ;

-- Trigger: prevent_delete_khachhang
DELIMITER //

CREATE TRIGGER prevent_delete_khachhang
    BEFORE DELETE ON khachhang
    FOR EACH ROW
BEGIN
    DECLARE active_rentals INT;
    SELECT COUNT(*)
    INTO active_rentals
    FROM hoatdongthue
    WHERE makhachhang = OLD.makhachhang
      AND trangthaithue = 'Đang thuê';

    IF active_rentals > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete customer with active rentals.';
END IF;
END //

DELIMITER ;

-- Trigger: log_taikhoan_moi
DELIMITER //

CREATE TRIGGER log_taikhoan_moi
    AFTER INSERT ON taikhoan
    FOR EACH ROW
BEGIN
    INSERT INTO log_table (action, table_name, record_id, timestamp)
    VALUES ('INSERT', 'taikhoan', NEW.mataikhoan, NOW());
END //

DELIMITER ;

-- Trigger: capnhat_soluong_sau_thue
DELIMITER //

CREATE TRIGGER capnhat_soluong_sau_thue
    AFTER INSERT ON chitietthue
    FOR EACH ROW
BEGIN
    UPDATE truyen
    SET soluong = soluong - NEW.soluong
    WHERE matruyen = NEW.matruyen;
END //

DELIMITER ;


