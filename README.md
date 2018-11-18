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
git clone https://github.com/rmgmedia/docker-magento2 [install-directory-name]
```

We recommend naming the install directory after your project since Docker Compose will use this name for networking purposes.

If you have an existing project you would like to develop using this docker setup, after pulling the docker project local please clone the project into the directory `src/magento`. This will ensure Docker does not try to automatically install Magento for you on your initial standup.

### Configuring

After you have the Docker setup locally, you have the ability to configure the software Magento 2 uses to run. We run Magento 2 locally with:
- Composer
- MySQL (Percona)
- Nginx
- PHP-FPM
- Redis

You will find their configuration files in the `config` directory.

#### Composer
You can modify the `auth.json` to include your own Magento repository credentials, especially if you plan to install a new copy of Magento Commerce. 

#### MySQL (Percona)
You can modify the `my.cnf` settings to tune how you would like MySQL to perform locally.

#### Nginx
You can modify the top-level `nginx.conf` settings to tune Nginx. You can also add additional configuration files that will automatically populate the conf.d directory. This repository includes a baseline Magento 2 Nginx configuration in `conf.d/magento.conf`.

#### PHP-FPM
You can modify the `php.ini` settings to tune how you would like PHP-FPM to perform locally.

#### Redis
We typically run separate Redis instances rather than one instance with multiple databases for object cache, FPC, and sessions. Running multiple databases on one instance has implications at scale that are beyond the scope of this repository.

You can technically modify the `fpc.conf` and `ses.conf` files here to configure Redis settings, but we just use them to update the internal ports Redis will be running on in the Docker containers. That's why you don't see an `obj.conf` file to configure, since we use the default port for the Redis instance object cache points to.
