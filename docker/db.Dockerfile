FROM arm64v8/mariadb
ADD ./db.sql /docker-entrypoint-initdb.d/miradio.sql
