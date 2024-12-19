const db = require('../db');

class Story {
    static getAll(callback) {
        db.query('SELECT * FROM truyen', (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }

    static add(story, callback) {
        const { matruyen, tentruyen, tacgia, soluong, giathue, maloaitruyen } = story;
        db.query('INSERT INTO truyen (matruyen, tentruyen, tacgia, soluong, giathue, maloaitruyen) VALUES (?, ?, ?, ?, ?, ?)',
            [matruyen, tentruyen, tacgia, soluong, giathue, maloaitruyen], (err, results) => {
                if (err) return callback(err);
                callback(null, results);
            });
    }

    static delete(id, callback) {
        db.query('DELETE FROM truyen WHERE matruyen = ?', [id], (err, results) => {
            if (err) return callback(err);
            callback(null, results);
        });
    }

    static update(id, story, callback) {
        const { tentruyen, tacgia, soluong, giathue, maloaitruyen } = story;
        db.query('UPDATE truyen SET tentruyen = ?, tacgia = ?, soluong = ?, giathue = ?, maloaitruyen = ? WHERE matruyen = ?',
            [tentruyen, tacgia, soluong, giathue, maloaitruyen, id], (err, results) => {
                if (err) return callback(err);
                callback(null, results);
            });
    }
}

module.exports = Story;