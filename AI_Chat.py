from streamlit.web import cli as stcli
from streamlit import chat_input, chat_message, error, markdown, session_state, title
from openai import OpenAI
from os import getenv
from dotenv import load_dotenv
import sys

# Load environment variables
load_dotenv()

# Set up OpenAI client
client = OpenAI(api_key=getenv("OPENAI_API_KEY"))

# System message with added context
SYSTEM_MESSAGE = {
    "role": "system",
    "content": "We are using a Windows 10 computer. The user is generally inexperienced with computers but able to follow detailed instructions."
}

def get_ai_response(messages):
    try:
        response = client.chat.completions.create(
            model='gpt-4o-mini',  # or another appropriate model
            messages=[SYSTEM_MESSAGE] + messages
        )
        return response.choices[0].message.content
    except Exception as e:
        error(f"Error: {str(e)}")
        return None

def main():
    title("Chat with AI Assistant")

    # Initialize chat history
    if "messages" not in session_state:
        session_state.messages = []

    # Display chat messages from history on app rerun
    for message in session_state.messages:
        with chat_message(message["role"]):
            markdown(message["content"])

    # React to user input
    if prompt := chat_input("What is your message?"):
        # Add user message to chat history
        session_state.messages.append({"role": "user", "content": prompt})
        # Display user message in chat message container
        with chat_message("user"):
            markdown(prompt)

        # Get AI response
        ai_response = get_ai_response(session_state.messages)

        # Display assistant response in chat message container
        with chat_message("assistant"):
            markdown(ai_response)

        # Add assistant response to chat history
        session_state.messages.append({"role": "assistant", "content": ai_response})

if __name__ == "__main__":
    main()