#import pytest
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
        "file":open("images/happy1.jpg","rb")
    })
    assert result.json["error"] == False and result.json["dominant_emotion"] == "happy"
    
    
    
