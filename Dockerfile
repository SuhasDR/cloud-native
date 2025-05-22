# Frontend (Node.js)
FROM node:16-alpine AS frontend
WORKDIR /app
COPY frontend/ .  # Ensure only frontend files are copied
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]

# Backend (Python)
FROM python:3.9 AS backend
WORKDIR /app
COPY backend/ .  # Ensure only backend files are copied
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
