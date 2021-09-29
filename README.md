## Using docker compose for database server

Docker compose is a good tool to make running a mssql server on osx/linux even easier.

The official mssql-server docker image is cumbersome to set up manually each time it is needed. Working with dotnet in a unix environment (linux, OS X etc) often requires you to have a local database server for development.

Many steps done with docker commands to run a container can be configured in 

docker-compose.yml file instead.  Docker is the engine behind everything. Docker-compose is more like a conductor for the orchestra - making sure each player plays it part in harmony with the rest.



| Configuration parameter | Value          |
| ----------------------- | -------------- |
| server                  | localhost      |
| port                    | 1433 (default) |
| User                    | sa             |
| Password                | S3cr3tPassword |
| Database name           | DATABASE       |



## Start the database server

| What to do                           | How to do it                    |
| ------------------------------------ | ------------------------------- |
| Start the database server            | `docker compose up`             |
| Stop the database server             | `docker compose down`           |
| Remove all data from database server | `docker compose down --volumes` |



## Import data to database

- Step 1:  Find the container id with [`docker ps`](https://docs.docker.com/engine/reference/commandline/ps/) 
- Step 2: Copy the sql-file to the container ([`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/))
- Step 3: Execute the file with `sqlcmd`,  from inside the container ([`docker exec`](https://docs.docker.com/engine/reference/commandline/exec/))



### Step 1 Find the container id with [`docker ps`](https://docs.docker.com/engine/reference/commandline/ps/) 

After your database container is running, type `docker ps` in your terminal, it will display a list of all running containers and their ids:

> `> docker ps`
>
> ```bash
> CONTAINER ID  IMAGE                 COMMAND         CREATED    STATUS     PORTS                    NAMES
> 
> 78d5fffabbb9  microsoft/mssql-server-linux:latest  "/opt/mssql/bin/sqls…"  17 hours ago  Up 7 minutes  0.0.0.0:1433->1433/tcp, :::1433->1433/tcp  student_db_1
> ```

The containerid is in the first column, and in this case is: `78d5fffabbb9`



### Step 2: Copy the sql-file to the container ([`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/))



`docker cp database.sql 78d5fffabbb9:/`



### Step 3: Run the sql statements 

Now you will do two things:

1. Open a shell inside the container with `docker exec`
2. Run a command from inside the container that imports the data to the database.



#### 1. Open a shell  inside the container.

```bash
docker exec -ti 78d5fffabbb9 bash
```

#### 2. Import data to database

Run this command, expected result is displayed further down.

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P S3cr3tPassword -i database.sql 	
```

Expected result:

```bash
root@78d5fffabbb9:/# /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P S3cr3tPassword -i database.sql 
Changed database context to 'master'.
Changed database context to 'DATABASE'.

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

```





## Connect to database from application

**Connectionstring**

```sql
"Server=localhost;Database=DATABASE;User Id=sa;Password=S3cr3tPassword"
```

