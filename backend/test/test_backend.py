#import pytest
from main import create_app

# so here we have to test if the software can run its desiganted functionality
# first we must test if there is an error

def test_basic():
    assert create_app()
