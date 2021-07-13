ARG certpath=
ARG certname=perceptilabs
ARG hostname=

# Build the base image using miniconda3
FROM continuumio/miniconda3:latest as to-squash
WORKDIR /app
ARG certpath
ARG certname
ENV CERT_PATH=$certpath
ENV CERT_NAME=$certname
COPY ${CERT_PATH}/${CERT_NAME} .

RUN conda create --name perceptilabs_env python=3.7
RUN echo "conda activate perceptilabs_env" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]
RUN pip install perceptilabs==0.11.9 django==3.1.8 opencv-python --no-cache
# RUN pip install django==3.1.8 opencv-python --no-cache
RUN pip install --upgrade pydantic==1.6.1

# Install specific tools for working with machine-learning projects
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6 libgl1-mesa-glx python3-opencv git -y

# Create the second stage for
FROM continuumio/miniconda3:latest as perceptilabs
WORKDIR /app
ARG certname
ARG hostname
ENV CERT_NAME=$certname
ENV HOST_NAME=$hostname

LABEL org.dalinwillims.net.authors="support@dalinwilliams.com",\
        maintainer="FunkeyFreak, Inc"
COPY --from=to-squash / /

ENTRYPOINT echo $hostname && eval `ssh-agent` && ssh-add ${CERT_NAME} && ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -fNT -R 8080:localhost:8080 -R 5000:localhost:5000 -R 8011:localhost:8011 -R 8000:localhost:8000 ${HOST_NAME}@host.docker.internal && /opt/conda/envs/perceptilabs_env/bin/perceptilabs -v=3