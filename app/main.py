from fastapi import FastAPI, Response
import os, time, platform

app = FastAPI(title="GitOps Lab App", version="1.0.0")

@app.get("/health")
async def health():
    """Эндпоинт для проверки работоспособности (liveness/readiness)"""
    return {
        "status": "ok",
        "pod": os.getenv("HOSTNAME", "unknown"),
        "commit": os.getenv("GIT_COMMIT", "unknown"),
        "ts": int(time.time())
    }

@app.get("/metrics")
async def metrics():
    """Простые метрики для демонстрации мониторинга"""
    return Response(
        content=f'app_uptime_seconds {int(time.time() - start_time)}\n'
                f'app_requests_total 42\n',
        media_type="text/plain"
    )

@app.get("/version")
async def version():
    """Версия приложения с хэшем коммита"""
    return {
        "app": "gitops-lab",
        "version": "1.0.0",
        "commit": os.getenv("GIT_COMMIT", "unknown"),
        "node": platform.node()
    }

start_time = time.time()