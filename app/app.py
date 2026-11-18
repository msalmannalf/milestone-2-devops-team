#!/usr/bin/env python3
import json
import logging
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

PORT = int(os.environ.get("APP_PORT", "8000"))
logging.basicConfig(
    filename="/var/log/webapp/app.log",
    level=logging.INFO,
    format="%(asctime)s %(message)s",
)

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body = {"status": "ok"}
        else:
            body = {
                "app": "Enterprise Multi-Tier Backend",
                "client_ip": self.headers.get("X-Real-IP", self.client_address[0]),
                "proto": self.headers.get("X-Forwarded-Proto", "http"),
            }
data = json.dumps(body).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)
        logging.info("GET %s from %s", self.path, body.get("client_ip", "-"))

    def log_message(self, fmt, *args):
        pass

if __name__ == "__main__":
    ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
