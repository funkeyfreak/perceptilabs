#FROM ubuntu
FROM continuumio/anaconda3:latest
WORKDIR /app
LABEL org.dalinwillims.net.authors="support@dalinwilliams.com"

EXPOSE 8080/tcp
EXPOSE 8080/udp

RUN conda create --name my_env python=3.7
RUN echo "conda activate my_env" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]
RUN pip install perceptilabs==0.11.8 --no-cache
RUN pip install django==3.1.8 --no-cache

ENTRYPOINT ["perceptilabs"]