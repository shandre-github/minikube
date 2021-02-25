import os

from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    name = os.environ.get('MY_POD_NAME')
    return 'Hello World from {name}'.format(name=name)

app.run(host='0.0.0.0', port=8080)