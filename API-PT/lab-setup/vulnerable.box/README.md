## crAPI vulnerable box setup

Requirements:
1. Docker must be installed in the system
2. current user must be in docker group

```bash
$ mkdir -p ~/lab/crAPI && cd ~/lab/crAPI
$ curl -o docker-compose.yml https://raw.githubusercontent.com/OWASP/crAPI/main/deploy/docker/docker-compose.yml
$ docker compose pull
$ docker compose -f docker-compose.yml --compatibility up -d
```

---

## vAPI vulnerable box setup

Requirements:
1. Docker must be installed in the system
2. current user must be in docker group

```bash
$ cd ~/lab
$ git clone https://github.com/roottusk/vapi.git
$ cd /vapi
$ docker compose up -d
```

---

Successfully Tested in `Fedora Linux 38 (Workstation Edition) x86_64`
