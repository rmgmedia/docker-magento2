# Docker for Magento 2
This repository contains the docker setup we use in our Magento practice to facilitate local development on the platform. It automates the Magento 2 installation guide found here: <https://devdocs.magento.com/guides/v2.2/install-gde/bk-install-guide.html>

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. **Note: This docker setup is not intended to be run on production systems.**

### Prerequisites
You will need the following software installed on your host machine:
- Docker 17.04 CE+ (<https://www.docker.com/get-started>)
- Git (<https://git-scm.com/downloads>)

*Note: There are some known issues with shared filesystems and performance when developing with docker (<https://docs.docker.com/docker-for-mac/osxfs/#ownership>). We take advantage of some updates to Docker found here <https://docs.docker.com/docker-for-mac/osxfs-caching/> and recommend running on the Edge client for now.*

### Installing
If you plan to develop using the Integrator mode, the docker image will automatically install and configure Magento 2 for you. You can run the following to setup a new project:

```bash
git clone git@github.com:rmgmedia/docker-magento2.git [install-directory-name]
```

We recommend naming the install directory after your project since Docker Compose will use this name for networking purposes.

If you have an existing project you would like to develop using this docker setup, after pulling the docker project locally please clone your Magento source code into the `src/magento` directory. This will ensure Docker does not try to automatically install Magento for you on your initial standup.

### Configuring

After you have Docker setup, you have the ability to configure the software Magento 2 runs. This includes:
- Composer
- MySQL (Percona)
- Nginx
- PHP-FPM
- Redis

You will find their configuration files in the `config` directory.

#### Composer
You should modify `config/composer/auth.json` to include your own Magento repository credentials, especially if you plan to install a new copy of Magento Commerce.

```json
{
  "http-basic": {
    "repo.magento.com": {
      "username": "025529cab5cbb1d5c32b9bb80ab67bec",
      "password": "f094671ce660328603f821b9b964fa83"
    }
  }
}
``` 

#### MySQL (Percona)
You can modify `config/mysql/my.cnf` settings to tune MySQL.

#### Nginx
You can modify `config/nginx/nginx.conf` settings to tune Nginx. You can also add additional configuration files that will automatically populate the conf.d directory. This repository includes a baseline Magento 2 Nginx configuration in `config/nginx/conf.d/magento.conf`.

#### PHP-FPM
You can modify `config/php/php.ini` settings to tune PHP-FPM.

#### Redis
We typically run separate Redis instances rather than one instance with multiple databases for object cache, FPC, and sessions. Running multiple databases on one instance has implications at scale that are beyond the scope of this repository.

You can technically modify `config/redis/fpc.conf` and `config/redis/ses.conf` to configure Redis settings, but we just use them to update the internal ports Redis will be running on in the Docker containers. That's why you don't see an `obj.conf` file to configure, since we use the default Redis port for the Magento object cache to point to.

## Usage
This repository can be used for both new and existing project development.

### New Project
For new project development, just run:
```bash
docker-compose up -d
```

This will install Magento 2 and set it up according to the configuration in your `config` and `.env` files.

After the installation and automated configuration of Magento 2 are complete, you are ready to develop locally!

### Existing Project
If you have an existing Magento 2 codebase already, you should run:
```bash
git clone [existing-magento-repo] ./src/magento
```

This will pull your codebase into the location Docker expects to see Magento, and prevent the automation from downloading and configuring a new Magento build on startup.

You should then edit the nginx configuration in `config/nginx/conf.d/magento.conf` and the environment variables in `.env` to match your expectations for running locally.

Then, you can run docker to stand up the containers:

```bash
docker-compose up -d
```

Now that your containers are stood up, you'll need to hook everything up. Start by getting the ID of the running php-fpm container:
```bash
docker ps -a
```

Then, run a composer install to make sure Magento builds out your dependencies:
```bash
docker exec -it [php-fpm-container-id] composer install
```

Now, connect Magento to your settings from your `.env` file:

```bash
docker exec -it [php-fpm-container-id] /var/www/configure-redis-obj.sh
docker exec -it [php-fpm-container-id] /var/www/configure-redis-fpc.sh
docker exec -it [php-fpm-container-id] /var/www/configure-redis-ses.sh
```

Finally, run your standard Magento commands to build a development environment:
```bash
docker exec -it [php-fpm-container-id] ./bin/magento setup:upgrade
docker exec -it [php-fpm-container-id] ./bin/magento cache:flush
```

You should now be ready to develop locally!

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning
We have not yet implemented versioning on this repository.

## Authors
- **Ryan Gellis** - *Initial work* - [RMG Media](https://rmgmedia.com)

See also the list of [contributors](https://github.com/rmgmedia/docker-magento2/graphs/contributors) who participated in this project.

## License
This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) license.
