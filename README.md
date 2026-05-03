# Terraform Docker Nginx Demo

![Pipeline Status](https://gitlab.com/Ikayou/infrastructure/badges/main/pipeline.svg)

## Overview
This project provisions a container-based application using Terraform and the Docker provider.

## Architecture
Terraform → Docker Provider → Nginx → Backend → PostgreSQL

## Features
- Infrastructure as Code with Terraform
- Docker container provisioning
- Modular structure (reusable modules)
- Reverse proxy setup with Nginx
- Multi-container architecture (Nginx, Backend, PostgreSQL)
- Docker network and volume management

## Beschreibung 

In diesem Projekt habe ich eine kleine containerbasierte Anwendung mit Terraform aufgebaut.  
Dabei werden mehrere Docker-Container automatisch erstellt und miteinander verbunden.

Die Architektur besteht aus:
- einem Nginx-Container als Reverse Proxy  
- einem Backend-Service  
- einer PostgreSQL-Datenbank  

Alle Container sind über ein gemeinsames Docker-Netzwerk verbunden, sodass eine interne Kommunikation möglich ist.  
Zusätzlich wird ein Docker-Volume verwendet, um die Daten der Datenbank persistent zu speichern.

Der Nginx-Container leitet eingehende Anfragen an den Backend-Service weiter. Dadurch entsteht eine einfache, aber realistische Struktur, wie sie auch in produktiven Umgebungen verwendet wird.

Das gesamte Setup wird mit Terraform definiert und kann mit einem einzigen Befehl erstellt oder wieder entfernt werden.  
So wird eine reproduzierbare und automatisierte Infrastruktur bereitgestellt.

## How to run
```bash
terraform init
terraform apply