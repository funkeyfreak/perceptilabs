# Introduction
So, you wanna use [perceptilabs labs](https://www.perceptilabs.com/)? We have you covered.

The following instructions have been tested out on Docker for Mac and Docker on Linux.

## Why Does this Container Exist?
This allows you to run perceptilabs from a docker container - obviously. This is method of using Perceptilabs not supported by [AFAIK] by the Perceptilabs team. If you run into any issues, please submit an issue. Thank you!


## Cool! How does this work?
As you may know, running a native python application on a docker container is... complicated.

To compensate, we use [ssh remote port-forwarding](https://www.ssh.com/academy/ssh/tunneling/example) to connect the perceptilabs application to the docker host platform. This way, you will be able to access perceptilabs directly from your browser.

## What Versions of Perceptilabs Does This Dockerfile Host
We are expanding the versions of perceptilabs which we are planning on supporting. Have a version which you would like to see? Raise an issue and tag it as a feature. The list below contains the versions of Perceptilabs which we are current hosting.

- [DEPRECATED] 0.11.8 -> funkeyfreak/perceptilabs:version-0.1.0
- 0.11.9 -> funkeyfreak/perceptilabs:version-0.2.0

## What Still Needs to be Completed?
Great question - I've included a nifty collection of checkboxes to help track the progress of this project

- [x] Perceptilabs runs in docker
- [ ] Enable volume access on an off the docker container


# Getting Started


## Prerequisites
Ensure you have properly setup ssh on your local machine. Your `ssh-agent` must be running in the current shell environment.

First, create a new certificate in the your local directory
```sh
ssh-keygen perceptilabs
# ensure you save the certificate to the current directory
```

Add the certificate to your agent, and export the public key to the authorized_keys files
```sh
ssh-add perceptilabs
cat perceptilabs >> ~/.ssh/authorized_keys
```

Now, you should be good to run the container
```sh
docker run --name my_perceptilabs -e NOST_NAME=<The docker-host host name> -it funkeyfreak/perceptilabs:version-<version>
```

You should be able to navigate to http://localhost:8080 and navigate to your preceptilabs instance!