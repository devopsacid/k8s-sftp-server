# SFTP Docker Server
Project is created by Michal Maxian
Date 10/2023

This project consists of a Dockerized SFTP server where users can be easily added and managed by modifying a text file.

## Prerequisites
Before you begin, make sure you have installed Docker and Docker Compose on your machine.
[Link to docker installation instructions](https://docs.docker.com/engine/install/ubuntu/)

## How to Use
1. Build the Docker image. Use the docker build command and tag the image as sftp-server.

2. Update the `users.txt` file to add or modify users. Each user should be on a new line in the format `username:password:homedir`. If you don't specify a home directory, it defaults to `/home/username`.

3. Start the service using Docker Compose. Use the docker-compose up -d command to start the service in the background.

4. Connect to the SFTP server locally using any SFTP client. The server runs on localhost and listens on port 22.

5. To stop the service, use the docker-compose down command.

## Security Note
Storing passwords in plain text poses a security risk. For enhanced security, consider using SSH keys for authentication or securely hashing and salting the passwords. Also, ensure that the `users.txt` file is not accessible by unauthorized persons.
