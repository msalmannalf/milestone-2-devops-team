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
