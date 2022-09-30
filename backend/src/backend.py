# ok so here is what our basic flask server will look like
import tempfile

from flask import Flask
from flask import request
from deepface import DeepFace


backend = Flask(__name__)

# we prevent super large file sizes
backend.config['MAX_CONTENT_LENGTH'] = 6 * 1000 * 1000

# We use JSON to respond to an API call in this project
#
# Generaly we will get a message with
# {error : True, msg: "<problem with input or server>"}
# if there is a problem


# msg is a string, which contains the error message to be 
def generate_error(msg):
    return {
        "error": True,
        "msg": msg
    }


# otherwise we will get a result involving this function

# this takes a deepface result and generates a json output for our app
def generate_success(result):
    return {
        "dominant_emotion": result["dominant_emotion"],
        "emotion": result["emotion"],
        "error": False
    }


# this is our main handle for the server, you call a post request to this 
@backend.route('/check', methods=["POST"])
def check():
    # we assume the POST method is used based on the API's handler
    if "file" not in request.files:
        return generate_error("There was no file in the request")

    file = request.files["file"]

    result = {}
    try:
        result = DeepFace.anaylize(
            img_path=tempfile.gettempdir() + "/" + file.filename, 
            actions=['emotion']
        )
    except ValueError as err:
        # TODO (aAccount11) 
        # perhaps I could make a dumpfile for the instances when this error occures.
        backend.logger.debug(str(err))
        return generate_error("An error occured in the processing of the image")
    except BaseException as err:
        backend.logger.debug(str(err))
        return generate_error(f"Unknown Error '{err=}' has occured of type '{type(err)=}'")

    # this will result in JSON
    if "dominant_emotion" in result:
        # this implies that both emotion and dominant emotion are present
        return generate_success(result)

    return generate_error("Failed understand image")
