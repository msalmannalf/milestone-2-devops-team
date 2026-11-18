# UK5 Milestone 2 - Arsitektur Multi-Tier & Otomasi Bash

Mata Kuliah Praktikum Sistem Operasi - Sekolah Vokasi UNS

## Anggota Tim
| Nama | NIM | Peran |
|---|---|---|

| Maharani | ... | Master Installer |
| Haidar   | ... | Systemd & Backend |
| Sabrina  | ... | Nginx & Database |
| Salman   | ... | Repo, Docs & Testing |

## Arsitektur

Proyek ini menggunakan arsitektur multi-tier:

1. Presentation Layer: Nginx sebagai reverse proxy.
2. Application Layer: Flask dan Gunicorn.
3. Service Management: Systemd untuk mengelola aplikasi.
4. Automation Layer: Bash script untuk instalasi dan deployment.

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
