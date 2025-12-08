FROM python:3.9-buster
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /src

# pipを使ってpoetryをインストール
RUN pip install poetry

# poetryの定義ファイルをコピー (存在する場合)
COPY pyproject.toml* poetry.lock* ./

# poetryでライブラリをインストール (pyproject.tomlが既にある場合)
# コンテナ内の仮想環境をプロジェクト外に作成し、ホストの .venv と衝突しないようにする
RUN poetry config virtualenvs.in-project false
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# アプリ本体をコピー（docker-compose の volume 指定がなくても動くように）
COPY . .

EXPOSE 8000

# uvicornのサーバーを立ち上げる（api/main.py を参照）
ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
