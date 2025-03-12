# Ghidra with Guacamole 

This project provides a Dockerized setup for running Ghidra (a reverse engineering tool) and Apache Guacamole (a web-based remote desktop gateway).
With this setup, you can access Ghidra via a web browser using Guacamole.

---

## Requirements

- Docker
- Docker Compose

Clone the Repository:
```
git clone https://github.com/your-username/ghidra-guacamole-docker.git
cd ghidra-guacamole-docker
```

Project structure:
```bash
ghidra-guacamole-docker/
├── Dockerfile          # Dockerfile for Ghidra
├── docker-compose.yml  # Docker Compose configuration
├── entrypoint.sh       # Entrypoint script for Ghidra
├── ghidra_projects/    # Directory to store Ghidra projects
└── README.md           # This README file
```

Use Docker Compose to build and run the containers:
```
docker-compose up --build
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql
```

This will:
1. Start the Ghidra, Guacamole, and Guacd containers.
2. Expose Ghidra on port 5901 (VNC) and Guacamole on port 8080.

Access Ghidra via Guacamole:
```
Open your browser and go to http://localhost:8080/guacamole.
Log in to Guacamole with the default credentials:
Username: guacadmin
Password: guacadmin
Add a new connection in Guacamole:
Name: Ghidra VNC
Protocol: VNC
Hostname: ghidra (the name of the Ghidra container).
Port: 5901 (default VNC port).
Password: password (as set in the Dockerfile).
Save the connection and connect to it.
```
## Customization

To use a different version of Ghidra, update the download URL in the Dockerfile:

Dockerfile
```Dockerfile
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_<VERSION>_build/ghidra_<VERSION>.zip -O /tmp/ghidra.zip
```

VNC Password

To change the VNC password, update the vncpasswd command in the Dockerfile:

```bash
RUN echo "new_password" | vncpasswd -f > /root/.vnc/passwd
```

## Troubleshooting

If the VNC server fails to start:

Check the VNC logs:
```bash
docker exec -it ghidra cat /root/.vnc/*.log
```

Ensure Xvfb is running:
```bash
docker exec -it ghidra ps -ax | grep Xvfb
```

Verify that the ghidra container is running:
```bash
docker ps
```

Test connectivity from the guacamole container:
```bash
docker exec -it guacamole telnet ghidra 5901
```

Check the Ghidra logs:
```bash
docker exec -it ghidra cat /root/.ghidra/.ghidra_*/application.log
```
