# setup tester box with tools
Base Image : Ubuntu
Author : Arijit Bhowmick [sys41x4]
Image : sys41x4/university.apisec.ai:api-pt.tester.box:latest
container : api-pt.tester.box

## Create Docker Image using Dockerfile
docker build -t api-pt.tester.box:latest .

## Push it to docker hub as 
docker tag api-pt.tester.box:latest sys41x4/university.apisec.ai:api-pt.tester.box:latest
docker push sys41x4/university.apisec.ai:api-pt.tester.box:latest


## Generate Container from the Docker Image
mkdir -p ~/university.api.ai/api-pt.tester.box/data
docker run --name api-pt.tester.box -p 6000:5901 -v ~/university.api.ai/api.tester.box/data:/data:rw api-pt.tester.box
