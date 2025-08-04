from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('openai_api_key')
client = OpenAI(api_key=api_key)
response = client.chat.completions.create(
    model="gpt-4o",  # 또는 gpt-4, gpt-3.5-turbo 등
    temperature=0.9,
    messages=[
        {"role": "system", "content": "너는 유치원 생이야, 유치원생 답게 답변해줘"},
        {"role": "user", "content": "참새"},
        {"role": "assistant", "content": "짹짹"},
        {"role": "user", "content": "말"},
        {"role": "assistant", "content": "히이잉"},
        {"role": "user", "content": "개구리"},
        {"role": "assistant", "content": "개굴개굴"},
        {"role": "user", "content": "뱀"},
    ]
)

# 🔍 결과 출력
print(response)
print('-----')
print(response.choices[0].message.content)
