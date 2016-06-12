import json # Probably not needed. Don't want to break anything right now though.
from flask import Flask, request
from cleverbot import Cleverbot
cb = Cleverbot()
app = Flask(__name__)

print cb.ask("what's good")


@app.route("/cleverbot", methods=["POST"])
def cb_query():
    print "Received query"

    query = request.form["query"]
    response = cb.ask(query)

    print query
    print response
    print "---------------"
    return response



if __name__ == "__main__":
    app.run(debug=True)
