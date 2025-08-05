from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('openai_api_key')
client = OpenAI(api_key=api_key)

# API 요청 함수
def get_ai_response(messages):
    response = client.chat.completions.create(
        model="gpt-4o",
        temperature=0.9,
        messages=messages,
    )
    return response.choices[0].message['content']

# 대화 내용 초기 설정
messages = [
    {"role": "system", "content": "너는 사용자를 도와주는 상담사야"},
]

while True:
    user_input = input("사용자: ")
    
    # 종료 조건
    if user_input.lower() == "exit":
        break

    # 사용자 메시지 추가
    messages.append({"role": "user", "content": user_input})
    
    # AI 응답 받기
    ai_response = get_ai_response(messages)
    
    # AI의 응답을 대화에 추가
    messages.append({"role": "assistant", "content": ai_response})
    
    # AI의 응답 출력
    print("AI: " + ai_response)
