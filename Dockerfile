FROM python:3.9-slim
ARG port

USER root
COPY . /simple-cnn-app
WORKDIR /simple-cnn-app

ENV PORT=$port

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install curl \
    && apt-get install libgomp1

RUN chgrp -R 0 /simple-cnn-app \
    && chmod -R g=u /simple-cnn-app \
    && pip install pip --upgrade \
    && pip install -r requirements.txt
EXPOSE $PORT

CMD gunicorn app:server --bind 0.0.0.0:$PORT --preload
