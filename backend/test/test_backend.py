#import pytest
from src.backend.main import create_app

# so here we have to test if the software can run its desiganted functionality
# first we must test if there is an error

def test_basic():
    print("I fixed the CI now here is a test to see"
          +" if I can print and load my flask object")
    assert create_app()
