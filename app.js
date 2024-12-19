const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

const Customer = require('./models/Customer');
const User = require('./models/User');
const Story = require('./models/Story');
const Category = require('./models/Category');



const app = express();
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());

function isAuthenticated(req, res, next) {
    if (req.cookies.user) {
        return next();
    } else {
        res.redirect('/login');
    }
}

// Route to check authentication and redirect accordingly
app.get('/', isAuthenticated, (req, res) => {
    res.redirect('/customers');
});

app.get('/client/login', (req, res) => {
    res.render('client_login');
});

app.post('/client/login', (req, res) => {
    const { phone, email } = req.body;

    // Add your authentication logic here
    // For example, you can query the database to check if the user exists

    // If authentication is successful
    res.redirect('/client/home'); // Redirect to the home page

    // If authentication fails
    // res.render('client_login', { error: 'Invalid phone number or email' });
});

// Route to view login form
app.get('/login', (req, res) => {
    res.render('login');
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    User.authenticate(username, password, (err, user) => {
        if (err) throw err;
        if (user) {
            // Authentication successful, set cookie
            res.cookie('user', { id: user.mataikhoan, username: user.tentaikhoan }, { httpOnly: true });
            res.redirect('/customers');
        } else {
            // Authentication failed
            res.redirect('/login');
        }
    });
});

app.get('/loaitruyen', (req, res) => {
    Category.getAll((err, results) => {
        if (err) throw err;
        res.render('loaitruyen', { categories: results });
    });
});

app.post('/loaitruyen/add', (req, res) => {
    Category.add(req.body, (err) => {
        if (err) throw err;
        res.redirect('/loaitruyen');
    });
});

app.post('/loaitruyen/delete/:id', (req, res) => {
    Category.delete(req.params.id, (err) => {
        if (err) throw err;
        res.redirect('/loaitruyen');
    });
});

app.post('/loaitruyen/update/:id', (req, res) => {
    Category.update(req.params.id, req.body, (err) => {
        if (err) throw err;
        res.redirect('/loaitruyen');
    });
});

// Route to view stories
app.get('/stories', (req, res) => {
    Story.getAll((err, results) => {
        if (err) throw err;
        res.render('stories', { stories: results });
    });
});

// Route to add story
app.post('/stories/add', (req, res) => {
    Story.add(req.body, (err) => {
        if (err) throw err;
        res.redirect('/stories');
    });
});

// Route to delete story
app.post('/stories/delete/:id', (req, res) => {
    Story.delete(req.params.id, (err) => {
        if (err) throw err;
        res.redirect('/stories');
    });
});

// Route to update story
app.post('/stories/update/:id', (req, res) => {
    Story.update(req.params.id, req.body, (err) => {
        if (err) throw err;
        res.redirect('/stories');
    });
});

// Route to view data
app.get('/customers', (req, res) => {
    Customer.getAll((err, results) => {
        if (err) throw err;
        res.render('customers', { customers: results });
    });
});

// Route to add data
app.post('/customers/add', (req, res) => {
    Customer.add(req.body, (err) => {
        if (err) throw err;
        res.redirect('/customers');
    });
});

// Route to delete data
app.post('/customers/delete/:id', (req, res) => {
    Customer.delete(req.params.id, (err) => {
        if (err) throw err;
        res.redirect('/customers');
    });
});

// Route to update data
app.post('/customers/update/:id', (req, res) => {
    Customer.update(req.params.id, req.body, (err) => {
        if (err) throw err;
        res.redirect('/customers');
    });
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});