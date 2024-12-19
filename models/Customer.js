const db = require('../db');

class Customer {
    static getAll(callback) {
        db.query('SELECT * FROM khachhang', callback);
    }

    static add(data, callback) {
        const { ten, ngaysinh, gioitinh, diachi, sdt, email } = data;
        db.query('CALL tao_khachhang_moi(?, ?, ?, ?, ?, ?)', [ten, ngaysinh, gioitinh, diachi, sdt, email], callback);
    }

    static delete(id, callback) {
        db.query('CALL xoa_khachhang(?)', [id], callback);
    }

    static update(id, data, callback) {
        const { ten, ngaysinh, gioitinh, diachi, sdt, email } = data;
        db.query('CALL capnhat_khachhang(?, ?, ?, ?, ?, ?, ?)', [id, ten, ngaysinh, gioitinh, diachi, sdt, email], callback);
    }
}

module.exports = Customer;