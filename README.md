# TeamMarusya Deploy

Deployment-ready версия проекта анализа новостей для Railway.

## Структура

```
├── backend/          # FastAPI + ML модели
│   ├── src/          # API код
│   ├── code/         # ML модули
│   └── models/       # Модели (Git LFS)
├── frontend/         # Next.js
└── README.md
```

## Деплой на Railway

### 1. Инициализация Git LFS

```bash
git lfs install
git lfs track "*.pkl"
git lfs track "*.bin"
git lfs track "*.safetensors"
```

### 2. Создание репозитория

```bash
git init
git add .
git commit -m "Initial deploy setup"
git remote add origin git@github.com:YOUR_USERNAME/teammarusya-deploy.git
git push -u origin main
```

### 3. Railway

1. Создай новый проект на [railway.com](https://railway.com)
2. Добавь **2 сервиса** из одного репо:
   - Backend: укажи `backend/` как Root Directory
   - Frontend: укажи `frontend/` как Root Directory

### 4. Environment Variables

**Backend:**
- Не требует обязательных env vars

**Frontend:**
```
NEXT_PUBLIC_API_BASE=https://YOUR-BACKEND.railway.app
```

## Локальная проверка

```bash
# Backend
cd backend
docker build -t backend .
docker run -p 8000:8000 backend

# Frontend
cd frontend
npm install
NEXT_PUBLIC_API_BASE=http://localhost:8000 npm run dev
```

## Endpoints

- `GET /health` — проверка здоровья
- `POST /clickbait/analyze` — детекция кликбейта
- `POST /water/analyze` — анализ "воды" в тексте
- `POST /analyze` — полный анализ новости
