#### **Date: 2026-05-19**

#### **Day: 06**

#### **Severity: Low**

#### **Category: Process**

---

#### **What I Was Doing**

I was running the command `sudo apt remove nginx` to uninstall the Nginx application. After that, I also ran `sudo apt purge nginx` to completely remove it from the system.

---

#### **What Went Wrong**

My intention was to fully remove Nginx, but after the removal process, configuration files and related package remnants still existed in the system, especially under `/etc/nginx`, and the package state still showed leftover components.

---

#### **Error / Investigation**

#### **Package History Check**

#### **Command**

```bash
cat /var/log/apt/history.log
```

#### **Output**

```text
Start-Date: 2026-05-19  16:36:46
Commandline: apt remove nginx
Requested-By: valerie (1000)
Remove: nginx:amd64 (1.24.0-2ubuntu7.8)
End-Date: 2026-05-19  16:36:47
```

#### **Result**

Nginx application package was successfully removed from the system.

---

#### **Service Log Check**

#### **Command**

```bash
journalctl -u nginx
```

#### **Output**

```text
May 19 16:27:08 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
May 19 16:27:08 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
May 19 16:36:46 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
May 19 16:36:46 systemd[1]: nginx.service: Deactivated successfully.
May 19 16:36:46 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
```

#### **Result**

Nginx service was successfully stopped and deactivated.

---

#### **Configuration Files Check**

#### **Command**

```bash
ls /etc/nginx/
```

#### **Output**

```text
conf.d  fastcgi.conf  fastcgi_params  koi-utf  koi-win  mime.types  modules-available  modules-enabled
nginx.conf  proxy_params  scgi_params  sites-available  sites-enabled  snippets  uwsgi_params  win-utf
```

#### **Result**

Nginx configuration files were still present even after package removal.

---

#### **Package State Check**

#### **Command**

```bash
dpkg -l | grep nginx
```

#### **Output**

```text
ii  nginx-common  1.24.0-2ubuntu7.8  all  small, powerful, scalable web/proxy server - common files
```

#### **Result**

The `nginx-common` package was still installed, meaning shared components of Nginx were still present on the system.

---

#### **Fix Applied**

#### **Command**

```bash
sudo apt purge nginx nginx-common nginx-core -y
sudo apt autoremove -y
```

#### **Output**

```text
Package 'nginx' is not installed, so not removed
Package 'nginx-core' is not installed, so not removed
The following packages will be REMOVED:
  nginx-common
Purging configuration files for nginx-common (1.24.0-2ubuntu7.8) ...
```

#### **Result**

All remaining Nginx-related packages and configuration files were fully removed from the system.

---

#### **Verification**

#### **Package Verification**

#### **Command**

```bash
dpkg -l | grep nginx
```

#### **Output**

```text
(empty)
```

#### **Result**

No Nginx packages remained installed on the system.

---

#### **Configuration Verification**

#### **Command**

```bash
ls /etc/nginx/
```

#### **Output**

```text
ls: cannot access '/etc/nginx': No such file or directory
```

#### **Result**

All configuration files and directories were fully removed.

---

#### **Root Cause**

The issue occurred because `apt remove nginx` only removes the main application package but does not remove configuration files or dependent packages such as `nginx-common`.

Since Nginx is split into multiple packages, partial removal left behind configuration files and shared components until a full purge operation was executed.

---

#### **What I Learned**

- `apt remove` removes the application but retains configuration files.
- `apt purge` removes both the application and its configuration files.
- `apt autoremove` cleans up unused dependencies after package removal.
- Linux applications are often divided into multiple packages (core, common, configuration, modules).
- Proper system cleanup requires verifying both package state and filesystem state.
- Effective troubleshooting involves checking package status, service status, and filesystem artifacts together.
- Verification is an essential part of system administration and should always follow package removal operations.

---

#### **Outcome**

Nginx was successfully and completely removed from the system. All related packages, configuration files, and unused dependencies were cleaned up. Package verification and filesystem checks confirmed that no Nginx components remained installed.

---
