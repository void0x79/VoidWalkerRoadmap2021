FROM python:latest

COPY ./spotify.py .

RUN chmod +x spotify.py && \
    pip install spotipy

CMD [ "python", "./spotify.py"]