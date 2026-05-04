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
```

## Erweiterung: Backend API & Datenbank

Im nächsten Schritt wurde das Projekt um einen eigenen Backend-Service erweitert.  
Hierfür habe ich eine einfache REST-API mit FastAPI entwickelt und in einen eigenen Docker-Container integriert.

Der Backend-Service ist mit einer PostgreSQL-Datenbank verbunden und ermöglicht grundlegende Datenbankoperationen.

### Funktionen

- Erstellung von Benutzern über eine REST-API (POST /users)
- Abruf aller Benutzer aus der Datenbank (GET /users)
- Überprüfung der Datenbankverbindung (GET /db-check)

Die Daten werden persistent in einer PostgreSQL-Datenbank gespeichert, die ebenfalls über Terraform bereitgestellt wird.

### Beispiel API Nutzung

```bash
# Benutzer erstellen
curl -X POST "http://localhost:8080/users?name=yuichiro"

# Benutzer anzeigen
curl http://localhost:8080/users

# Datenbankverbindung prüfen
curl http://localhost:8080/db-check

```

## Security Improvement

Der Backend-Container wurde von einem Debian-basierten Python-Image auf ein Alpine-basiertes Image umgestellt.  
Dadurch konnte die Anzahl der von Trivy gefundenen HIGH/CRITICAL-Schwachstellen auf 0 reduziert werden.

## API Usage

### Create User
curl -X POST http://localhost:8080/users \
  -H "Content-Type: application/json" \
  -d '{"name":"yuichiro"}'

### Get Users
curl http://localhost:8080/users

## Frontend

Zusätzlich wurde eine einfache Benutzeroberfläche erstellt.  
Über das Frontend können Benutzer im Browser angelegt und aus der PostgreSQL-Datenbank geladen werden.

Der Zugriff erfolgt über Nginx. API-Anfragen werden über `/api/` an das FastAPI-Backend weitergeleitet.