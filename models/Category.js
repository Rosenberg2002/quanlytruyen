const db = require('../db');

class Category {
    static getAll(callback) {
        db.query('SELECT * FROM loaitruyen', (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }

    static add(category, callback) {
        const { maloaitruyen, tenloaitruyen } = category;
        db.query('INSERT INTO loaitruyen (maloaitruyen, tenloaitruyen) VALUES (?, ?)', [maloaitruyen, tenloaitruyen], (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }

    static delete(id, callback) {
        db.query('DELETE FROM loaitruyen WHERE maloaitruyen = ?', [id], (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }

    static update(id, category, callback) {
        const { tenloaitruyen } = category;
        db.query('UPDATE loaitruyen SET tenloaitruyen = ? WHERE maloaitruyen = ?', [tenloaitruyen, id], (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }
}

module.exports = Category;