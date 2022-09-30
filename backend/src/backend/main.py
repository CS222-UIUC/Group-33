from flask import Flask


# here is our main running function
def create_app():
    app = Flask(__name__)

    # we make sure that the users cannot make large files
    app.config['MAX_CONTENT_LENGTH'] = 6 * 1000 * 1000

    # get our blueprint from backend.py
    from .backend import backend
    app.register_blueprint(backend)

    return app
