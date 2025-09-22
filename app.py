# -*- coding: utf-8 -*-
from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.get("/")
def index():
    return jsonify({
        "message": "Hello Simar - containerized and ready!",
        "hostname": socket.gethostname()
    })

@app.get("/healthz")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    # Dev mode only. In Docker we'll use Gunicorn (see CMD in Dockerfile).
    app.run(host="0.0.0.0", port=8000, debug=False)



