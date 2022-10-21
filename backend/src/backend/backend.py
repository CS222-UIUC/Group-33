# ok so here is what our basic flask server will look like
import cv2
import numpy as np
from flask import Blueprint, request, current_app
from deepface import DeepFace


backend = Blueprint("check", __name__)


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
        # make a deep face readable image
        extracted_file_data = np.frombuffer(file.read(), dtype=np.uint8)
        image = cv2.imdecode(extracted_file_data, cv2.IMREAD_COLOR)

        # have deepface look for an emotion
        result = DeepFace.analyze(
            img_path=image, 
            actions=['emotion'],
            prog_bar=False
        )
    except ValueError as err:
        # TODO (aAccount11) 
        # perhaps I could make a dumpfile for the instances when this error occures.
        current_app.logger.debug(str(err))
        return generate_error("An error occured in the processing of the image")

    except BaseException as err:  # pylint: disable=broad-except
        current_app.logger.debug(str(err))
        return generate_error(f"Unknown Error '{err=}' has occured of type '{type(err)=}'")

    # TODO (aAccount11) make
    # this will result in JSON
    return generate_success(result)
