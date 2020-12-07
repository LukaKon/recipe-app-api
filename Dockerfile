FROM python:3.7-alpine3.7

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create user
RUN adduser -D user
# switch to created user
USER user