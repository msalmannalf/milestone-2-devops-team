# UK5 Milestone 2 - Arsitektur Multi-Tier & Otomasi Bash

Mata Kuliah Praktikum Sistem Operasi - Sekolah Vokasi UNS

## Anggota Tim
| Nama     | NIM            | Peran                |
|----------|----------------|----------------------|
| Maharani | 21116152610041 | Master Installer     |
| Haidar   | 21116152610036 | Systemd & Backend    |
| Sabrina  | 21116152610052 | Nginx & Database     |
| Salman   | 21116152610046 | Repo, Docs & Testing |

## Arsitektur
Proyek ini menggunakan arsitektur multi-tier:

1. Presentation Layer: Nginx sebagai reverse proxy.
2. Application Layer: Flask dan Gunicorn.
3. Service Management: Systemd untuk mengelola aplikasi.
4. Automation Layer: Bash script untuk instalasi dan deployment.

```text
[ Internet / Client ]
        | TCP 80
        v
[ Tier 1: Nginx Reverse Proxy ]   (listen 0.0.0.0:80)
        | HTTP 127.0.0.1:8000  (loopback)
        v
[ Tier 2: Backend App - webapp.service ]   (user: webapp, sandboxed)
        | TCP 127.0.0.1:3306  (loopback)
        v
[ Tier 3: MariaDB ]   (bind-address 127.0.0.1)
```
Prinsip: isolasi layanan, least privilege (user `webapp` tanpa shell), idempotensi.


## Teknologi yang Digunakan

- Ubuntu Linux
- Bash
- Python
- Flask
- Gunicorn
- Nginx
- Systemd
- Git dan GitHub

## Cara Menjalankan

```bash
sudo bash deploy.sh

```text


## Quick Start
```bash
git clone <URL-REPO> project-root && cd project-root
cp env.example .env
nano .env                 # isi DB_PASS
sudo ./deploy.sh          # aman dijalankan berulang
./tests/health_check.sh

## Struktur Repository
project-root/
├── README.md
├── deploy.sh                 # Master idempotent installer
├── env.example
├── app/app.py                # Backend minimal
├── systemd/webapp.service    # Custom unit + sandboxing
├── configs/
│   ├── nginx.conf.template
│   └── database.cnf
├── scripts/
│   ├── lib.sh                # strict mode + trapping
│   ├── 01_setup_users.sh
│   ├── 02_install_deps.sh
│   ├── 03_configure_sec.sh
│   ├── 04_configure_db.sh
│   ├── 05_deploy_app.sh
│   └── 06_configure_nginx.sh
└── tests/health_check.sh

