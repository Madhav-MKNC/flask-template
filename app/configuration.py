import os

class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'sqlite:///app.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class ProductionConfig(Config):
	SQLALCHEMY_DATABASE_URI = 'mysql://user@localhost/foo'
	SQLALCHEMY_TRACK_MODIFICATIONS = False

class DevelopmentConfig(Config):
	DEBUG = True

class TestingConfig(Config):
	TESTING = True