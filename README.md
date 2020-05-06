# Install Passwork using Docker Compose 

Based upon https://github.com/passwork-me/docker and https://www.notion.so/Passwork-Manuals-e5aa17375b3d49d282e4279982c255ac

## Prerequisites

- [Docker Compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

## Setup

Clone this repository onto your production server.

```bash
git clone https://github.com/mll-lab/passwork-docker-compose.git passwork
cd passwork
```

Now initialize and update the actual site as a submodule.

```bash
git submodule init && git submodule update
```

This configuration enforces the use of SSL. Put your certificate and key under:
- `conf/ssl/site.crt`
- `conf/ssl/site.key`

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
Click `Upload keys` and select `*.lic` and `reginfo.json` file.

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

Mount a volume into the mongo container by modifying `docker-compose.yml`.
The following is only an example, the change depends upon the mount point on your system.

```diff
  mongo:
    # mongo > db.version() => 3.0.15
    image: passwork/mongo
    volumes:
    - ./conf/mongo:/server/conf
    - ./log/mongo:/server/log
    - ./data/mongo:/server/data
+   - /mnt/backup:/server/backup
```

Run `docker-compose up -d` to apply the changes.

Create a backup through:

    ./backup.sh

This will create an archive named `passwork-%Y-%m-%d` with the current date, e.g. `passwork-2019-04-20`.

Restore a backup:

    docker-compose exec mongo mongorestore /server/backup/passwork-xxxx-xx-xx

When errors pop up during the restore process, you might want to use the `--drop`
option to completely reset the database.
