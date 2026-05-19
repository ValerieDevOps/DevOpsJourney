# Date: 2026-05-19
# Day: 06
# Severity: Low
# Category: Process

## What I was doing
I was running the command `sudo apt remove nginx` to uninstall the Nginx application. After that, I also ran `sudo apt purge nginx` to completely remove it from the system.

## What went wrong
My intention was to fully remove Nginx, but after the removal process, configuration files and related package remnants still existed in the system, especially under `/etc/nginx`, and the package state still showed leftover components.

## Error / Investigation

### Package history check
Command:
cat /var/log/apt/history.log

Output:
Start-Date: 2026-05-19  16:36:46
Commandline: apt remove nginx
Requested-By: valerie (1000)
Remove: nginx:amd64 (1.24.0-2ubuntu7.8)
End-Date: 2026-05-19  16:36:47

Result:
Nginx application package was successfully removed from the system.

---

### Service log check
Command:
journalctl -u nginx

Output:
May 19 16:27:08 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
May 19 16:27:08 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
May 19 16:36:46 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
May 19 16:36:46 systemd[1]: nginx.service: Deactivated successfully.
May 19 16:36:46 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.

Result:
Nginx service was successfully stopped and deactivated.

---

### Configuration files check
Command:
ls /etc/nginx/

Output:
conf.d  fastcgi.conf  fastcgi_params  koi-utf  koi-win  mime.types  modules-available  modules-enabled  
nginx.conf  proxy_params  scgi_params  sites-available  sites-enabled  snippets  uwsgi_params  win-utf

Result:
Nginx configuration files were still present even after package removal.

---

### Package state check
Command:
dpkg -l | grep nginx

Output:
ii  nginx-common  1.24.0-2ubuntu7.8  all  small, powerful, scalable web/proxy server - common files

Result:
The `nginx-common` package was still installed, meaning shared components of Nginx were still present on the system.

---

## Fix applied

Command:
sudo apt purge nginx nginx-common nginx-core -y
sudo apt autoremove -y

Output:
Package 'nginx' is not installed, so not removed
Package 'nginx-core' is not installed, so not removed
The following packages will be REMOVED:
  nginx-common
Purging configuration files for nginx-common (1.24.0-2ubuntu7.8) ...

Result:
All remaining Nginx-related packages and configuration files were fully removed from the system.

---

## Verification

### Package verification
Command:
dpkg -l | grep nginx

Output:
(empty)

Result:
No Nginx packages remain installed on the system.

---

### Configuration verification
Command:
ls /etc/nginx/

Output:
ls: cannot access '/etc/nginx': No such file or directory

Result:
All configuration files and directories were fully removed.

---

## Root cause
The issue occurred because `apt remove nginx` only removes the main application package but does not remove configuration files or dependent packages like `nginx-common`. Since Nginx is split into multiple packages, partial removal left behind configuration files and shared components until a full `apt purge` was executed.

## What I learned
- `apt remove` removes the application but keeps configuration files
- `apt purge` is required for complete removal including config files
- `apt autoremove` cleans unused dependencies after removal
- Linux applications are often split into multiple packages (core, common, config)
- Proper system cleanup requires checking both `dpkg` state and filesystem paths like `/etc`
- Effective troubleshooting requires verifying package state, service state, and filesystem state together
