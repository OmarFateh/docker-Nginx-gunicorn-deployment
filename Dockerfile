# pull official base image
FROM python:3.9.6-alpine

# set work directory
WORKDIR /django_on_docker

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
RUN pip3 install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /django_on_docker/entrypoint.sh
RUN chmod +x /django_on_docker/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/django_on_docker/entrypoint.sh"]