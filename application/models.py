"""Data models"""
from . import db
from flask import current_app as app
from flask_login import LoginManager, UserMixin
from werkzeug.security import check_password_hash

#many-Many relation for act
acts = db.Table('act',
    db.Column('movie_id', db.INTEGER(), db.ForeignKey('movie.id'), primary_key=True),
    db.Column('actor_id', db.INTEGER(), db.ForeignKey('actor.id'), primary_key=True)
)
#many-Many relation for direct
directs = db.Table('direct',
    db.Column('movie_id', db.INTEGER(), db.ForeignKey('movie.id'), primary_key=True),
    db.Column('director_id', db.INTEGER(), db.ForeignKey('director.id'), primary_key=True)
)

movie_comments = db.Table('moviecomment',
    db.Column('movie_id', db.INTEGER(), db.ForeignKey('movie.id')),
    db.Column('user_id', db.INTEGER(), db.ForeignKey('user.id')),
    db.Column('comment_id', db.INTEGER(), primary_key = True, autoincrement=True),
    db.Column('createtime', db.DATETIME()),
    db.Column('content',db.TEXT())
)

movie_ratings = db.Table('movierating',
    db.Column('movie_id', db.INTEGER(), db.ForeignKey('movie.id'), primary_key=True),
    db.Column('user_id', db.INTEGER(), db.ForeignKey('user.id'), primary_key=True),
    db.Column('createtime', db.DATETIME()),
    db.Column ('value', db.INTEGER())
)

album_artists = db.Table('albumartist',
    db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id'), primary_key=True),
    db.Column('artist_id', db.INTEGER(), db.ForeignKey('artist.id'), primary_key=True)
)

album_comments = db.Table('albumcomment',
    db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id')),
    db.Column('user_id', db.INTEGER(), db.ForeignKey('user.id')),
    db.Column('comment_id', db.INTEGER(), primary_key = True, autoincrement=True),
    db.Column('createtime', db.DATETIME()),
    db.Column ('content', db.TEXT())
)

album_ratings = db.Table('albumrating',
    db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id'), primary_key = True),
    db.Column('user_id', db.INTEGER(), db.ForeignKey('user.id'), primary_key = True),
    db.Column('createtime', db.DATETIME()),
    db.Column('value', db.INTEGER())
)

track_artists = db.Table('trackartist',
    db.Column('track_id', db.INTEGER(), db.ForeignKey('track.id'), primary_key=True),
    db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id'), primary_key=True),
    db.Column('artist_id', db.INTEGER(), db.ForeignKey('artist.id'), primary_key=True)
)

track_ratings = db.Table('trackrating',
    db.Column('track_id', db.INTEGER(), db.ForeignKey('track.id'), primary_key=True),
    db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id'), primary_key = True),
    db.Column('user_id', db.INTEGER(), db.ForeignKey('user.id'), primary_key = True),
    db.Column('createtime', db.DATETIME()),
    db.Column('value', db.INTEGER())
)

login_manager = LoginManager(app)
login_manager.login_view = 'login'

class User(db.Model,UserMixin):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    email = db.Column('email', db.VARCHAR(255), unique=True)
    music_rating_weight = db.Column('music_rating_weight', db.FLOAT(255))
    movie_rating_weight = db.Column('movie_rating_weight', db.FLOAT(255))
    username = db.Column('username', db.VARCHAR(255), unique=True)
    password = db.Column('password', db.VARCHAR(255))
    certification_information = db.Column('certification_information', db.VARCHAR(255))
    movie_comments = db.relationship('Movie', secondary=movie_comments, back_populates="comment_users")
    movie_ratings = db.relationship('Movie', secondary=movie_ratings, back_populates="rating_users")
    album_comments = db.relationship('Album', secondary=album_comments, back_populates="comment_users")
    album_ratings = db.relationship('Album', secondary=album_ratings, back_populates="rating_users")
    track_ratings = db.relationship('Track', secondary=track_ratings, back_populates="rating_users")
        
    def validate_password(self, password):
        return check_password_hash(self.password, password)

@login_manager.user_loader
def load_user(user_id):
    user = User.query.get(int(user_id))
    return user

class Movie(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    title = db.Column('title', db.VARCHAR(255))
    release_date = db.Column ('release_date', db.VARCHAR(255))
    country = db.Column ('country', db.VARCHAR(255))
    detailed_information = db.Column ('detailed_information', db.TEXT())
    genre_id = db.Column('genre_id', db.INTEGER(), db.ForeignKey('genre.id'))
    acts = db.relationship('Actor', secondary=acts, back_populates='movie')
    directs = db.relationship('Director', secondary=directs, back_populates='movie')
    movie_comments = db.relationship('User', secondary=movie_comments, back_populates='comment_movies')
    movie_ratings = db.relationship('User', secondary=movie_ratings, back_populates='rating_movies')

class Actor(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    name = db.Column('name', db.VARCHAR(255))
    country = db.Column ('country', db.VARCHAR(255))
    date_of_birth = db.Column ('date_of_birth', db.VARCHAR(255))
    acts = db.relationship('Movie', secondary=acts, back_populates='actors')

class Director(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    name = db.Column('name', db.VARCHAR(255))
    country = db.Column ('country', db.VARCHAR(255))
    date_of_birth = db.Column ('date_of_birth', db.VARCHAR(255))
    directs = db.relationship('Movie', secondary=directs, back_populates='directors')

class Album(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    cover = db.Column ('cover', db.VARCHAR(255))
    name = db.Column('name', db.VARCHAR(255))
    album_or_ep = db.Column ('album_or_ep', db.INTEGER())
    releaseDate= db.Column ('releaseDate', db.DATETIME() )
    detailedInfo= db.Column ('detailedInfo', db.TEXT())
    genre_id = db.Column('genre_id', db.INTEGER(), db.ForeignKey('genre.id'))
    album_artists = db.relationship('Artist', secondary=album_artists, back_populates='albums')
    album_comments = db.relationship('User', secondary=album_comments, back_populates='comment_albums')
    album_ratings = db.relationship('User', secondary=album_ratings, back_populates='rating_albums')
    tracks = db.relationship('Track', backref='album', lazy=True)

class Artist(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    name = db.Column('name', db.VARCHAR(255))
    portrait = db.Column ('portrait', db.VARCHAR(255)) 
    detailedInfo = db.Column ('detailedInfo', db.VARCHAR(255))
    company = db.Column ('company', db.VARCHAR(255))
    country = db.Column ('country', db.VARCHAR(255))
    genre_id = db.Column ('genre_id', db.INTEGER(), db.ForeignKey('genre.id'))
    album_artists = db.relationship('Album', secondary=album_artists, back_populates='artists')

class Genre(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    name = db.Column('name', db.VARCHAR(255))
    album_track_artist_movie = db.Column ('album_track_artist_movie', db.INTEGER())
    artists = db.relationship('artist', backref='genre', lazy=True)
    albums = db.relationship('album', backref='genre', lazy=True)
    tracks = db.relationship('track', backref='genre', lazy=True)
    movies = db.relationship('movie', backref='genre', lazy=True)

class Track(db.Model):
    id = db.Column('id', db.INTEGER(), primary_key=True)
    name = db.Column('name', db.VARCHAR(255))
    album_id = db.Column('album_id', db.INTEGER(), db.ForeignKey('album.id'), primary_key=True)
    genre_id = db.Column('genre_id', db.INTEGER(), db.ForeignKey('genre.id'))