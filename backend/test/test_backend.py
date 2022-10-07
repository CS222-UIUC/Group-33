#import pytest
import os.path
from src.backend.main import create_app

# so here we have to test if the software can run its desiganted functionality
# first we must test if there is an error

def test_basic():
    # this will create the application, we need to know that works before anything else
    assert create_app()
    

def test_tryImage():
    # Here we test some sample images (which I got from the public domain)
    server = create_app()

    client = server.test_client()

    # we should be posting images to the server, and getting results back
    result = client.post("/check", data={
        "file":open("test/images/happy1.jpg","rb")
    })
    assert result.json["error"] == False and result.json["dominant_emotion"] == "happy"


def test_tryBadFiles():
    # we test what happens when someone forgets to upload a file
    server = create_app()

    client = server.test_client()

    # we post but fail to upload the file
    result = client.post("/check", data={})
    # TODO (aAccount11) make the messages global variables, that we can check against
    assert result.json["error"] == True and result.json["msg"] == "There was no file in the request"

    # ok well what happens if we load an image with two faces?
    result = client.post("/check", data={
        "file":open("test/images/twofaces.jpg","rb")
    })
    raise Exception(str(result.json))
    assert result.json["error"] == True and result.msg["msg"] == "Too many faces"

    # finaly what happens if we load an image with out a face
    result = client.post("/check", data={
        "file":open("test/images/unknown.png","rb")
    })
    assert result.json["error"] == True and result.json["msg"] == "An error occured in the processing of the image"
    
