# 📦 Ansible Role - WordPress Installation

Ce projet Ansible permet d'installer automatiquement un site WordPress fonctionnel sur des machines **Ubuntu** ou **Rocky Linux**, y compris dans des **conteneurs sans systemd**.

---

## ✅ Fonctionnalités

- Installation automatique de :
  - Apache (`apache2` ou `httpd`)
  - PHP + extensions nécessaires
  - MariaDB (MySQL)
- Déploiement et configuration de WordPress
- Création de la base de données, utilisateur et mot de passe
- Compatible avec les environnements sans systemd (Docker, LXC, etc.)
- Configuration FCGI avec PHP-FPM (Rocky)

---

## 🛠️ Structure du rôle
```
ansible-role-wordpress/
├── tasks/
│   ├── main.yml
│   ├── setup_mysql.yml
│   ├── configure_wordpress.yml
│   └── apache_config.yml
├── handlers/
│   └── main.yml
├── vars/
│   └── main.yml
├── defaults/
│   └── main.yml
├── templates/
│   └── php-handler.conf.j2
└── README.md
```

---

## ⚙️ Variables personnalisables

Définies dans `defaults/main.yml` ou surchargées dans un playbook :

| Variable              | Description                        | Valeur par défaut       |
|-----------------------|-------------------------------------|--------------------------|
| `wp_db_name`          | Nom de la base de données           | `wordpress`              |
| `wp_db_user`          | Nom d'utilisateur MySQL             | `example`                |
| `wp_db_password`      | Mot de passe MySQL                  | `examplePW`              |
| `db_root_password`    | Mot de passe root MySQL             | `examplerootPW`          |
| `wp_site_dir`         | Répertoire WordPress                | `/var/www/html`          |
| `wp_download_url`     | URL d'archive WordPress             | `https://wordpress.org/latest.zip` |

---

## 🚀 Exemple d'utilisation

### 1. Playbook

```yaml
- name: Déploiement WordPress
  hosts: all
  become: true
  vars:
    ansible_python_interpreter: /usr/bin/python3
  roles:
    - wordpress
```

### 2. lancement
````
ansible-playbook -i inventory.ini site.yml
````

## 🔧 Comportement par OS

| OS/Distro     | Apache         | Utilisateur Web | PHP handler       | MariaDB service        |
|---------------|----------------|------------------|--------------------|-------------------------|
| Ubuntu        | apache2        | www-data         | mod_php            | mysql (service)         |
| Rocky (VM)    | httpd          | apache           | proxy_fcgi + fpm   | mariadb (service)       |
| Rocky (Docker)| httpd (shell)  | apache           | proxy_fcgi + fpm   | php-fpm (shell)         |

---

## 🛠️ Tâches spécifiques

- Démarrage d'Apache via `httpd -DFOREGROUND` si `systemd` absent
- Démarrage de `php-fpm` en background si conteneur
- Création automatique de `wp-config.php`
- Permissions dynamiques (`www-data` ou `apache` selon OS)

---

## 🧪 Vérifications utiles

### Apache :
- Ubuntu : `/var/log/apache2/error.log`
- Rocky : `/var/log/httpd/error_log`

### PHP-FPM :
- Rocky : `/tmp/php-fpm.log` (si lancé en shell)

---

## 👤 Auteur

Développé dans un contexte d’examen Ansible  
Par : [Ton Nom ici]

---

## 📄 Licence

Projet à usage pédagogique, librement réutilisable.

## 🗂️ Fichier `inventory.ini`

Le fichier `inventory.ini` sert à définir la ou les machines cibles (Ubuntu, Rocky, conteneurs…) sur lesquelles le rôle sera exécuté.

Voici un exemple de contenu :

```ini
[webservers]
client1 ansible_host=192.168.56.11
client2 ansible_host=192.168.56.12
client3 ansible_host=192.168.56.13
client4 ansible_host=192.168.56.14