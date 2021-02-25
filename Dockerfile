FROM python:3.7-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./helloworld/main.py /usr/src/app/main.py

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

EXPOSE 8080

CMD [ "python", "main.py"]
