from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('openai_api_key')
client = OpenAI(api_key=api_key)

while True:
  user_input = input("사용자: ")

  if user_input == "exit":
    break

response = client.chat.completions.create(
    model="gpt-4o",  # 또는 gpt-4, gpt-3.5-turbo 등
    temperature=0.9,
    messages=[
        {"role": "system", "content": "너는 사용자를 도와주는 상담사야"},
        {"role": "user", "content": user_input},
    ]
)

# 🔍 결과 출력

print('-----')
print("AI:  " + response.choices[0].message.content)
