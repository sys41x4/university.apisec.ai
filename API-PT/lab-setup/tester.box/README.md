# setup tester box with tools
Base Image : Ubuntu<br>
Author : Arijit Bhowmick [sys41x4]<br>
Image : sys41x4/university.apisec.ai:box.tester_ubuntu22.04<br>
container : api-pt.tester.box<br>

## Run Docker Compose to run the tester.box

```bash
# Starting and creating new container from pulled.build image
docker compose up

# Stop the docker container
docker compose stop

# Remove the docker containers mentioned in the docker-compose.yml file and all its data

docker compose down

## Create Docker Image using Dockerfile

#docker build -t api-pt.tester.box:latest .
docker build -t api-pt.tester.box:latest -f ./Dockerfile .

### Push it to docker hub as 

docker tag api-pt.tester.box:latest sys41x4/university.apisec.ai:api-pt.tester.box:latest
docker push sys41x4/university.apisec.ai:api-pt.tester.box:latest
```

---

### Generate Container from the Docker Image

```bash
mkdir -p ~/university.api.ai/api-pt.tester.box/data
docker run --name api-pt.tester.box -p 5901:5901 -p 6901:6901 -v ~/university.api.ai/api.tester.box/data:/app/data:rw api-pt.tester.box
```
---

### The tools controller scripts can be found at $HOME/install/app/

```bash
1. Control Burpuite-Community using burpsuite-community.sh
> This script can install/remove/update Latest Burpsuite Community in the attached tools volume

2. Control Security Testing Tools using security-testing-apps.sh
> This script can install/remove/update Security Testing Tools
- nmap
- amass
- gobuster
- dirb
- dirbuster
- mitmproxy
- zaproxy
- nikto
- wfuzz
- crunch

3. Control JWT-Toolkit using using jwt_toolkit.sh
> This script can install/remove/update JWT Toolkit in the system
  Anyone having issue with pip's externally controlled environment must use jwt_toolkit-externally-managed-env.sh script

4. Control postman using postman.sh
> This script can install/remove/update postman in the attached tools volume
```

---

### The Wordlist controller scripts can be found at $HOME/install/wordlists/

```bash
1. Control Wordlists using wordlists-handler.sh
> This script can install/remove/update the below mentioned wordlists
- wordlists
- seclists
```
