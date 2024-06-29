from flask import Flask
helloworld = Flask(__name__)
@helloworld.route("/")
def run():
    return "{\"message\":\"Hey Guys !! Welcome to the world of Python Docker\"}"
if __name__ == "__main__":
    helloworld.run(host="0.0.0.0", port=int("5001"), debug=True)
