# 📦 auto-database-backuper

> A simple, production-ready tool that automatically creates compressed backups of MySQL/MariaDB, PostgreSQL, and MongoDB databases. It supports multiple databases, custom hosts and ports, .env configuration, Docker usage, and automatic backup rotation making it ideal for servers, VPS setups, cron jobs, and CI pipelines.

A lightweight, production-ready, multi-database backup system with support for:

* **MySQL / MariaDB**
* **PostgreSQL**
* **MongoDB**
* Automatic backup rotation
* `.env` configuration
* Docker support
* Cron compatibility
* Compressed backups (`.gz` / `.tar.gz`)

Designed for servers, VPS, Docker containers, and automated CI backup workflows.

---

## 🚀 Features

- ✔ Backup multiple MySQL/MariaDB databases
- ✔ Backup multiple PostgreSQL databases
- ✔ Backup multiple MongoDB databases
- ✔ Configurable through `.env`
- ✔ Supports custom host, port, username/password
- ✔ Fully automatic rotation (keep N recent backups)
- ✔ Clean logs & error handling
- ✔ Works standalone or inside Docker
- ✔ Simple structure & easy customization

---

## 📁 Project Structure

```
auto-database-backuper/
├── backup.sh
├── .env.example
├── docker-compose.yml
├── scripts/
│   ├── backup_mysql.sh
│   ├── backup_postgres.sh
│   ├── backup_mongo.sh
│   └── rotate.sh
└── README.md
```

---

## ⚙️ Installation

Clone the repo:

```bash
git clone https://github.com/BaseMax/auto-database-backuper.git
cd auto-database-backuper
```

Copy environment template:

```bash
cp .env.example .env
```

Edit `.env` and configure your DB settings.

---

## 🔧 Configuration (`.env`)

### MySQL / MariaDB

```env
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=max
MYSQL_PASS=maxpassword
MYSQL_DBS="db1 db2 db3"
```

### PostgreSQL

```env
POSTGRES_HOST=127.0.0.1
POSTGRES_PORT=5432
POSTGRES_USER=max
POSTGRES_PASS=maxpassword
POSTGRES_DBS="db1 db2 db3"
```

### MongoDB

```env
MONGO_HOST=127.0.0.1
MONGO_PORT=27017
MONGO_USER=
MONGO_PASS=
MONGO_AUTH_DB=admin
MONGO_DBS="db1 db2 db3"
```

### Backup settings

```env
BACKUP_DIR=/var/backups/db
KEEP_BACKUPS=200
```

---

## 🧪 Run Backup Manually

```bash
./backup.sh
```

Backups are stored in:

```
/var/backups/db/
```

---

## 🐳 Docker Usage

Run once:

```bash
docker compose run --rm backup
```

Or schedule it via cron inside host.

---

## ⏰ Cron Usage (Recommended)

Run every day at 3 AM:

```
0 3 * * * cd /root/auto-database-backuper && ./backup.sh >> backup.log 2>&1
```

---

## 🗃 Backup Output Examples

MySQL:

```
project_mysql_20250101_030000.sql.gz
```

PostgreSQL:

```
mydb_pgsql_20250101_030000.sql.gz
```

MongoDB:

```
mongo_orders_20250101_030000.tar.gz
```

---

## 🔄 Backup Rotation

Automatically keeps only the latest **N** backups:

```
KEEP_BACKUPS=200
```

Older backups are removed automatically.

---

## 📜 License

MIT License

Copyright © **2025**

**Seyyed Ali Mohammadiyeh (Max Base)**
[https://github.com/BaseMax](https://github.com/BaseMax)

---

## ⭐ Contributing

PRs are welcome!

Feel free to add:

* New database drivers
* Cloud upload (S3, Backblaze, FTP)
* Notifications (Telegram/Discord)
* Encryption support (AES-256)
