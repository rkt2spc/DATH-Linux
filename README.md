# DATH Linux

Nguyễn Minh Tuấn - 1312663 - nmtuan.dev@gmail.com

# Config

Service configuration files are stored in the directories of their respective hosts

# Requirements

```txt
docker version 18.09.0
docker-compose version 1.23.2
```

# Getting started

```sh
cd <project-directory>
docker-compose build
docker-compose up -d
```

You can access services through their ports mapping (Check docker-compose ports section)
Or you can exec to the user machine and try the operations

```
docker-compose exec user sh
```

There's a handy script that test DHCP, DNS, Web and SSH inside the user host at `/workdir/entrypoint.sh`
Please check out the content of this file if you decide to exec to the user container
