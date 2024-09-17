# GPT_EXE 🤖💬

<p align="center">
  <img src="logo.png" alt="GPT_EXE Logo" width="200"/>
</p>

A simple way to turn your LLM API key into an .exe file your friends and family can install.

## 🌟 Features

- Easy installation for non-technical users
- Automatic setup of Python, pip, Streamlit, and OpenAI
- One-click access to LLM chat interface
- Customizable system prompt

## 🚀 Quick Start

### For Developers

1. Clone this repository
2. Add your API key to the `.env` file
3. Install [NSIS](https://nsis.sourceforge.io/Download)
4. Run the NSIS script from the directory with all files to create the installer:
   ```
   & 'C:\Program Files (x86)\NSIS\makensis.exe' install.nsi
   ```
5. Share the resulting .exe file with your friends and family

### For End Users

1. Download the .exe file provided by your developer friend
2. Run the installer (you may need to bypass Windows security warnings)
3. Click the new program icon on your desktop to start chatting!

## ⚙️ Technical Details

- Designed for Windows 8 and higher
- Uses Streamlit for the user interface
- Currently configured for OpenAI's API (can be modified for other LLMs)
- Running in a new environment with only the required libraries will yield a smaller exe file

## ⚠️ Important Notes

- All API usage will be charged to the developer's account
- Consider customizing the system prompt for specific use cases

## 🛠️ Customization

To modify the LLM backend or adjust other settings, edit the `AI_Chat.py` file before creating the installer.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
---

Made with ❤️ by [Your Name/Organization]
