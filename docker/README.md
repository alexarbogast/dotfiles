# Docker

Want to test drive dotfiles in a container? Navigate to the `docker` directory
and use compose to start the container.

```bash
cd <repo>/docker
docker compose up -d
```
> [!NOTE]
> If the repo is not located at the path `~/.dotfiles`, the path will need to be
> updated in the [docker compose file](./docker-compose.yaml).

Obtain a shell in the container.

```bash
docker exec -it dotfiles bash
```

In the container, navigate to the mounted volume.

```bash
cd ~/.dotfiles
```

Install the files

```bash
./install/bootstrap.sh
./install/install.sh
source ~/.bashrc
```

Try `neofetch` or `nvim`.
