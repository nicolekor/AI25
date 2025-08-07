import streamlit as st
from openai import OpenAI
from dotenv import load_dotenv
import os

# .env에서 API 키 불러오기
load_dotenv()
openai_api_key = os.getenv("OPENAI_API_KEY")

# API 키가 없으면 중단
if not openai_api_key:
    st.error("❌ .env에 OPENAI_API_KEY가 설정되지 않았습니다.")
    st.stop()

# Streamlit 제목
st.title("💬 나만의 ChatGPT")

# 초기 메시지 설정
if "messages" not in st.session_state:
    st.session_state.messages = [{"role": "assistant", "content": "무엇을 도와드릴까요?"}]

# 이전 대화 메시지 출력
for msg in st.session_state.messages:
    st.chat_message(msg["role"]).write(msg["content"])

# 사용자 입력 처리
if prompt := st.chat_input("메시지를 입력하세요"):
    # OpenAI 클라이언트 인스턴스 생성
    client = OpenAI(api_key=openai_api_key)

    # 사용자 메시지 추가 및 출력
    st.session_state.messages.append({"role": "user", "content": prompt})
    st.chat_message("user").write(prompt)

    # GPT 응답 생성
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=st.session_state.messages,
    )

    # 응답 메시지 출력 및 기록
    msg = response.choices[0].message.content
    st.session_state.messages.append({"role": "assistant", "content": msg})
    st.chat_message("assistant").write(msg)