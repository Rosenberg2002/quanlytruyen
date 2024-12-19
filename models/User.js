const db = require('../db');

class User {
    static authenticateAdmin(username, password, callback) {
        db.query('SELECT * FROM taikhoan WHERE tentaikhoan = ? AND matkhau = ?', [username, password], (err, results) => {
            if (err) return callback(err);
            if (results.length > 0) {
                return callback(null, results[0]);
            } else {
                return callback(null, null);
            }
        });
    }

    static authenticateCustomer(phone, email, callback) {
        db.query('SELECT * FROM khachhang WHERE sodienthoai = ? AND email = ?', [phone, email], (err, results) => {
            if (err) return callback(err);
            if (results.length > 0) {
                return callback(null, results[0]);
            } else {
                return callback(null, null);
            }
        });
    }
}

module.exports = User;