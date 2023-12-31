FROM python:3.12-slim as base

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY requirements.txt .

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  && pip install --upgrade pip pip-tools \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000" ]

FROM base as prod

RUN python manage.py collectstatic --noinput

CMD [ "gunicorn", "althaia.wsgi:application", \
  "--bind", "0.0.0.0:8000", \
  "--workers", "1", \
  "--threads", "3", \
  "--access-logfile", "-",\
  "--error-logfile", "-" \
]
