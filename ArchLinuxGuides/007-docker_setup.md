# Basic Docker Setup on Arch

Install the `docker` package. Optionally you can also install the `docker-compose` package
to enable the `docker compose [options]` command syntax:

```sh
$ sudo pacman -S docker docker-compose
```

Now we need to start docker's daemon using `systemd`:

```sh
$ sudo systemctl enable docker --now
```

You will realize that everytime you try to use the `docker` command as a regular user
the system will require super user privileges to execute it. You can prefix these
commands with `sudo` but we can set our environment to avoid having to do that.

Create the `docker` group. If it already exists, this will return an error but that's ok.

```sh
$ sudo groupadd docker
```

When we installed docker, a new authentication rule was created in our system. Every member of
`docker` group will have the permission to run docker. Adding our user to this group will allow
us to use the `docker` command without `sudo`.

Add your user to this group:

```sh
$ sudo usermod -G docker -a $USER
```

Log out and log in to aplly the changes. If it still giving you a `Permission denied` error, then
reboot your machine. We are good to go after this process.

You can test if everything is ok by running:

```sh
$ docker run hello-world
```

# Useful Commands

A list of useful commands to keep in mind while using Docker and manage your system.

|        Commands        |                               Description                               |
|:----------------------:|:-----------------------------------------------------------------------:|
|     `docker images`    |             list all docker images installed on your system             |
|       `docker ps`      |        list all your running containers (-a to show all of them)        |
|       `docker rm`      |                      remove containers (name or ID)                     |
|      `docker rmi`      |                        remove images (name or ID)                       |
|   `docker system df`   |               shows docker's usage of your system storage               |
|  `docker image prune`  |                    removes all docker dangling images                   |
|  `docker volume prune` |                   deletes all docker volumes installed                  |
| `docker network prune` |                  deletes all docker networks installed                  |
| `docker builder prune` | deletes all dangling build cache (-a to delete all unused ones as well) |

It's always possible to add more flags and filters to these commands to perform more accurate operations.
See the docker man page (`man docker`) or the official documentation to get a better understanding
about such commands.
