import json # Probably not needed. Don't want to break anything right now though.
from flask import Flask, request
import cleverbot
cb1 = cleverbot.Cleverbot()
app = Flask(__name__)


@app.route("/cleverbot", methods=["POST"])
def cb_query():
    print "Received query"

    query = request.form["query"]
    response = cb1.ask(query)

    print query
    print response
    print "---------------"
    return response



if __name__ == "__main__":
    app.run(debug=True)
