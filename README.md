
# AI-Powered Document Generation

DocGen is an offline documentation generator that turns source code into structured docs using a local LLM.
It includes a React frontend, Django REST backend, and Ollama (`qwen2.5-coder:7b`).

## Features

- Generate documentation from pasted or uploaded code
- Export results as Markdown, PDF, and DOCX
- JWT authentication and user-based document history
- Fully local workflow (no external AI API required)

## Tech Stack

- Frontend: React, Tailwind CSS
- Backend: Django, Django REST Framework
- Auth: SimpleJWT
- AI: Ollama + `qwen2.5-coder:7b`
- Export: ReportLab (PDF), `python-docx` (DOCX)

## Project Structure

```text
DocGen/
│
├── backend/
│   ├── backend/
│   │   ├── __init__.py
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── asgi.py
│   │   └── wsgi.py
│   │
│   ├── generator/
│   │   ├── migrations/
│   │   ├── admin.py
│   │   ├── apps.py
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   └── utils.py
│   │
│   ├── manage.py
│   └── requirements.txt
│
├── frontend/
│   ├── public/
│   │   ├── index.html
│   │   ├── favicon.ico
│   │   └── manifest.json
│   │
│   ├── src/
│   │   ├── components/
│   │   │   ├── Login.jsx
│   │   │   ├── Dashboard.jsx
│   │   │   ├── Editor.jsx
│   │   │   └── History.jsx
│   │   │
│   │   ├── services/
│   │   │   └── api.js
│   │   │
│   │   ├── App.js
│   │   ├── index.js
│   │   └── App.css
│   │
│   ├── package.json
│   ├── tailwind.config.js
│   └── postcss.config.js
│
├── .gitignore
└── README.md
```

## Quick Start

### Prerequisites

- Python 3.10+
- Node.js + npm
- Ollama installed

### 1. Run Ollama

```bash
ollama pull qwen2.5-coder:7b
ollama serve
```

### 2. Run Backend

```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 8000
```

### 3. Run Frontend

```bash
cd frontend
npm install
npm start
```

Frontend: `http://localhost:3000`  
Backend: `http://127.0.0.1:8000`

## API Endpoints

- `POST /api/generate/` - Generate documentation
- `POST /api/pdf/` - Export PDF
- `POST /api/docx/` - Export DOCX
