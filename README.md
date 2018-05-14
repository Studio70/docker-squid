# docker-squid

An easy to use forward proxy.

## What is Squid?

Squid is an easy to use, customizable forward proxy.

It supports:

* HTTP
* SSL/TLS
* FTP
* WSS

## What makes this docker image different?

Our image runs the latest version of Squid on Alpine - a super lightweight Linux distro.
Additionally, this image supports basic auth (username/password) out of the box!

## Usage

You can get a basic container going by running the command below.
Replace the username and password with your desired information.


```bash
docker run -d -p 3128:3128 --env AUTH_USER="myusername" --env AUTH_PASS="mypassword" 54/squid

```

## Authentication

This container support username/password authentication. You can generate additional
logins with the ```htpasswd``` command. See: [setup.sh](/setup.sh) for an example.

By default, passwords are hashed with bcrypt. However, you can use anything that htpasswd supports.
