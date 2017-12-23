import os
from flask_script import Manager
from app import create_app, db
from app.models import User

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manager = Manager(app)


@app.shell_context_processor
def make_shell_context():
    return dict(db=db, User=User)


@manager.command
def create_db():
    db.create_all()


@manager.command
def drop_db():
    db.drop_all()


if __name__ == '__main__':
    manager.run()

