docker run --net=host --name postgres -v /data/postgres:/var/lib/postgresql/data --restart="unless-stopped" -e POSTGRES_PASSWORD=scfhao -d postgres:latest 

docker run --net=host --restart="unless-stopped" -e 'PGADMIN_DEFAULT_EMAIL=scfhao@126.com' -e 'PGADMIN_DEFAULT_PASSWORD=bsjdzpy' -d dpage/pgadmin4