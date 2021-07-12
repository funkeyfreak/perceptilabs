#FROM ubuntu
FROM continuumio/anaconda3
WORKDIR /app
LABEL org.dalinwillims.net.authors="support@dalinwilliams.com"

EXPOSE 8080/tcp
EXPOSE 8080/udp

#RUN apt update
#RUN apt -y install curl
#RUN apt -y install git
#RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
#RUN bash Anaconda3-2021.05-Linux-x86_64.sh -b -p /usr/bin/conda
#RUN . ~/.bashrc
#RUN which conda
#RUN conda init bash
RUN conda create --name my_env python=3.7
# RUN echo $(find . -type f -name 'conda')
# RUN /root/anaconda3/condo
# RUN . ~/anaconda3/bin/activate my_env
#RUN . ~/.bashrc
RUN echo "conda activate my_env" >> ~/.bashrc
RUN conda info --envs
SHELL ["/bin/bash", "--login", "-c"]
RUN pip install perceptilabs==0.11.8 --no-cache
RUN pip install django==3.1.8

ENTRYPOINT ["perceptilabs"]