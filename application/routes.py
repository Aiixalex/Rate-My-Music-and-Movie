"""Application routes"""
from . import db
from .models import User, Movie
from flask import current_app as app
from flask import Flask, render_template, session
from flask_sqlalchemy import SQLAlchemy
from flask_login import login_user, login_required, logout_user, current_user
from werkzeug.security import generate_password_hash


@app.route('/settings', methods=['GET', 'POST'])
@login_required
def settings():
    if request.method == 'POST':
        name = request.form['name']

        if not name or len(name) > 20:
            flash('Invalid input.')
            return redirect(url_for('settings'))
        allUser = User.query.all()
        for user_ in allUser:
            if current_user.username == user_.username:
                user_.username = name
                db.session.commit()
                flash('Settings updated.')
                return redirect(url_for('index'))
    return render_template('setting.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if not username or not password:
            flash('Invalid input.')
            return redirect(url_for('login'))

        allUser = User.query.filter_by(username=username)
        print(allUser)
        for user_ in allUser:
            if username == user_.username and user_.validate_password(password):
                login_user(user_)
                flash('Login success.')
                return redirect(url_for('index'))

        flash('Invalid username or password.')
        return redirect(url_for('login'))

    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Goodbye.')
    return redirect(url_for('index'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        if not request.form['username'] or not request.form['password'] or not request.form['email']:
            flash('Please enter all the fields', 'error')
        else:
            username = request.form['username']
            password = generate_password_hash(request.form['password'])
            email = request.form['email']
            if User.query.filter_by(email=email).first():
                flash("email is exist, please change another email.")
                return redirect(url_for('register'))
            user_ = User.query.first()
            if user_ is None:
                id = 1;
            else:
                id = len(User.query.all()) + 1
            t_user = User(id=id, email=email, username=username, password=password)
            db.session.add(t_user)
            db.session.commit()
            flash('Add user ' + request.form['username'] + ' successfully. ')
            return redirect(url_for('login'))
    return render_template('reg.html')


@app.route('/userinfo')
def show_all():
    a_user = User.query.all()
    return render_template('show_all.html', users=a_user)


@app.route('/user/delete/<int:user_id>', methods=['GET'])
@login_required
def delete(user_id):
    user_ = User.query.get_or_404(user_id)
    db.session.delete(user_)
    db.session.commit()
    flash('Item deleted.')
    return redirect(url_for('index'))


@app.route('/')
def index():
    isLogin = False
    username = ""
    if 'username' in session:
        username = session['username']
        isLogin = True

    return render_template('home.html', user=username, login=isLogin)

@app.route('/movie')
def mov():
    Movie.query.all()
    return render_template('movie.html', posts=Movie.query.all())
