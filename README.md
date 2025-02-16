Ghidra with Guacamole Docker Setup
This project provides a Dockerized setup for running Ghidra (a reverse engineering tool) and Apache Guacamole (a web-based remote desktop gateway). With this setup, you can access Ghidra via a web browser using Guacamole.

Features

Ghidra: A powerful reverse engineering tool developed by the NSA.
Guacamole: A web-based remote desktop gateway that allows you to access Ghidra via a browser.
Dockerized: Easy to set up and run using Docker and Docker Compose.
Prerequisites

Before you begin, ensure you have the following installed:

Docker
Docker Compose
Getting Started

1. Clone the Repository

Clone this repository to your local machine:

bash
Copy
git clone https://github.com/your-username/ghidra-guacamole-docker.git
cd ghidra-guacamole-docker
2. Build and Run the Docker Containers

Use Docker Compose to build and run the containers:

bash
Copy
docker-compose up --build
This will:

Build the Ghidra Docker image.
Start the Ghidra, Guacamole, and Guacd containers.
Expose Ghidra on port 5901 (VNC) and Guacamole on port 8080.
3. Access Ghidra via Guacamole

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
Project Structure

Copy
ghidra-guacamole-docker/
├── Dockerfile          # Dockerfile for Ghidra
├── docker-compose.yml  # Docker Compose configuration
├── entrypoint.sh       # Entrypoint script for Ghidra
├── ghidra_projects/    # Directory to store Ghidra projects
└── README.md           # This README file
Customization

Ghidra Version

To use a different version of Ghidra, update the download URL in the Dockerfile:

Dockerfile
Copy
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.2_build/ghidra_10.1.2_PUBLIC_20220125.zip -O /tmp/ghidra.zip
VNC Password

To change the VNC password, update the vncpasswd command in the Dockerfile:

Dockerfile
Copy
RUN echo "new_password" | vncpasswd -f > /root/.vnc/passwd
Troubleshooting

1. VNC Server Not Starting

If the VNC server fails to start:

Check the VNC logs:
bash
Copy
docker exec -it ghidra cat /root/.vnc/*.log
Ensure Xvfb is running:
bash
Copy
docker exec -it ghidra ps -ax | grep Xvfb
2. Guacamole Cannot Connect to Ghidra

If Guacamole cannot connect to the Ghidra container:

Verify that the ghidra container is running:
bash
Copy
docker ps
Test connectivity from the guacamole container:
bash
Copy
docker exec -it guacamole telnet ghidra 5901
3. Ghidra GUI Errors

If Ghidra fails to start with GUI-related errors:

Ensure Xvfb is running and the DISPLAY environment variable is set:
bash
Copy
docker exec -it ghidra echo $DISPLAY
Check the Ghidra logs:
bash
Copy
docker exec -it ghidra cat /root/.ghidra/.ghidra_*/application.log
License

This project is licensed under the MIT License. See the LICENSE file for details.

Acknowledgments

Ghidra: Developed by the National Security Agency (NSA).
Apache Guacamole: A web-based remote desktop gateway.
By following this guide, you should be able to set up and run Ghidra with Guacamole in Docker. Let us know if you encounter any issues or have suggestions for improvement!
