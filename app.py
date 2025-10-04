from flask import Flask, request, jsonify, send_file
from openai import OpenAI

client = OpenAI(
    api_key="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",
    base_url="https://api.groq.com/openai/v1"
)

app = Flask(__name__)

@app.route("/")
def home_page():
    return send_file("index.html")

@app.route("/chatpage")
def chat_page():
    return send_file("chat.html")

@app.route("/chat", methods=["POST"])
def chat():
    user_input = request.json.get("message", "")
    response = client.chat.completions.create(
        model="llama-3.1-8b-instant",
        messages=[
            {"role": "system", "content": "You are a friendly helpful chatbot."},
            {"role": "user", "content": user_input}
        ]
    )
    bot_reply = response.choices[0].message.content
    return jsonify({"reply": bot_reply})

if __name__ == "__main__":
    app.run(debug=True)
