# №17. Docker-compose


##  Завдання 1: Встановлення Docker
За$#%Vся з глюкавим Proxmox, підняв WSL на хлстовому ноуті, VS Code, в ноьму плагіни: Docker, WSL.


## Завдання 2: Створення файлу docker-compose.yml

1. Створив новий каталог для проєкту: `multi-container-app`

2. Створив файл `docker-compose.yml`, у якому визначив:
   - Конфігурацію для вебсервера (nginx), бази даних (postgres) та кешу (redis)
   - Том `db-data` для PostgreSQL
   - Спільну мережу `appnet`

3. Створив файл `index.html` у папці `web/` з вказаним в завданні змістом.

4. Скопіював все у WSL і розархівував
```bash
tree -L 2
.
├── README.md
├── docker-compose.yml
└── web
    └── index.html
```

5. Запустив VS Code
```bash

code .

```

## Завдання 3: Запуск багатоконтейнерного застосунку

1. Запустив застосунок за допомогою команди:
```bash
docker compose up -d
[+] Running 4/4
  Network projects_appnet     Created                                                                                                                 0.0s
  Container projects-cache-1  Started                                                                                                                 0.7s
  Container projects-db-1     Started                                                                                                                 0.6s
  Container projects-web-1    Started 
```

2. Перевірив стан запущених сервісів:
```bash
docker compose ps
NAME               IMAGE             COMMAND                  SERVICE   CREATED         STATUS         PORTS
projects-cache-1   redis:latest      "docker-entrypoint.s…"   cache     7 seconds ago   Up 5 seconds   6379/tcp
projects-db-1      postgres:latest   "docker-entrypoint.s…"   db        7 seconds ago   Up 5 seconds   5432/tcp
projects-web-1     nginx:latest      "/docker-entrypoint.…"   web       7 seconds ago   Up 5 seconds   0.0.0.0:8080->80/tcp

```

3. Перевірив роботу вебсервера, відкривши у браузері:
```
http://localhost:8080
```
Відобразилась сторінка з повідомленням "Hello from Docker!"

## Завдання 4: Налаштування мережі й томів

1. Перевірив створені мережі та томи:
```bash

docker network ls
NETWORK ID     NAME              DRIVER    SCOPE
48f387cd2b36   bridge            bridge    local
edb8505a4a29   host              host      local
babf3621e5f6   none              null      local
823bd7a5e949   projects_appnet   bridge    local

docker volume ls
DRIVER    VOLUME NAME
local     602c98e1b15c9478f2469667e9584f00cfc5e2775d9a3e7c8e095ef6e58adb6f
local     c77a59734f1464e0068e331c3be3f40a86668068d60cf5e2fc9d8aa1b4bd22dd
local     projects_db-data
local     projects_web-data
```

2. Підключився до PostgreSQL у контейнері:
```bash
docker exec -it projects-db-1 psql -U example -d exampledb
exampledb=# \l
                                                   List of databases
   Name    |  Owner  | Encoding | Locale Provider |  Collate   |   Ctype    | Locale | ICU Rules |  Access privileges
-----------+---------+----------+-----------------+------------+------------+--------+-----------+---------------------
 exampledb | example | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           |
 postgres  | example | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           |
 template0 | example | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/example         +
           |         |          |                 |            |            |        |           | example=CTc/example
 template1 | example | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/example         +
           |         |          |                 |            |            |        |           | example=CTc/example
(4 rows)
```

## Завдання 5: Масштабування сервісів

1. Масштабував вебсервер до трьох екземплярів:
```bash
docker compose up -d --scale web=3
[+] Running 6/6
 ✔ Network projects_appnet     Created                                                                                                                 0.0s
 ✔ Container projects-db-1     Started                                                                                                                 0.7s
 ✔ Container projects-cache-1  Started                                                                                                                 0.9s
 ✔ Container projects-web-3    Started                                                                                                                 1.0s
 ✔ Container projects-web-1    Started                                                                                                                 1.3s
 ✔ Container projects-web-2    Started 
```

2. Щоб уникнути конфлікту портів, видалив розділ `ports` у сервісі `web` в `docker-compose.yml`.

3. Перевірив стан масштабованих сервісів:
```bash
docker compose ps
NAME               IMAGE             COMMAND                  SERVICE   CREATED         STATUS         PORTS
projects-cache-1   redis:latest      "docker-entrypoint.s…"   cache     7 seconds ago   Up 6 seconds   6379/tcp
projects-db-1      postgres:latest   "docker-entrypoint.s…"   db        7 seconds ago   Up 6 seconds   5432/tcp
projects-web-1     nginx:latest      "/docker-entrypoint.…"   web       7 seconds ago   Up 5 seconds   80/tcp
projects-web-2     nginx:latest      "/docker-entrypoint.…"   web       7 seconds ago   Up 6 seconds   80/tcp
projects-web-3     nginx:latest      "/docker-entrypoint.…"   web       7 seconds ago   Up 5 seconds   80/tcp
```

## Prepared on: 5/8/2025 By: Andrii Fil (IT Administrator, DevOps trainee)

