# Install Passwork using Docker Compose 

Based upon https://github.com/passwork-me/docker

## Prerequisites

- [Docker Compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

## Setup

Clone this repository onto your production server.

```bash
git clone https://github.com/mll-lab/passwork-docker-compose.git passwork
```

Now initialize and update the actual site as a submodule.

```bash
git submodule init && git submodule update
```

This configuration enforces the use of SSL. Put your certificate and key under:
- `conf/ssl/prod.crt`
- `conf/ssl/prod.key`

Run the setup script:

```bash
./setup.sh
```

The app should be up and running shortly thereafter. Check the status with

```bash
docker-compose ps
```

Open the page in your browser to get to the Sign Up page.

Fill in login and password for the first user.
This user will become the owner and administrator of your installation.
Click `Upload keys` and select `.lic` and `reginfo.json` file.

## Usage

Start the application

```bash
docker-compose up -d
```

Stop the application

```bash
docker-compose down
```

Interactive shell into a container

```bash
docker-compose exec web sh
```

## Mail Configuration

Postfix is used to send emails.

You can edit the configuration files that are stored at `conf/postfix`
   
Don’t forget to reload Postfix to apply changes:

```bash
docker-compose exec web service postfix reload
```

## Backup

Read how backup's generally work [in the Backups manual](https://github.com/passwork-me/manuals-en/blob/master/Backups.md)

You can execute the `mongodump` and `mongorestore` commands within the web container

```bash
docker-compose exec web mongodump
```
