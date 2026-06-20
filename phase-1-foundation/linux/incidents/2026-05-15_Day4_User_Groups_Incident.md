#### **DevOps Incident Log (Day 01–07)**

#### **Date: 2026-05-15**

#### **Severity: Low**

#### **Category: Linux User Management / Permissions / Commands**

---

#### **Incident 01: User Creation Failure**

#### **What I Was Doing**

Attempted to create a new user:

```bash
sudo adduser devopsuser
```

#### **Error**

```text
Passwords do not match
passwd: Authentication token manipulation error
```

#### **Fix Applied**

Re-entered matching password and completed user creation.

#### **Root Cause**

Password mismatch during user creation.

#### **What I Learned**

* User creation requires exact password confirmation.

---

#### **Incident 02: File Permission Restriction**

#### **What I Was Doing**

Set file permissions:

```bash
chmod 640 secret.txt
```

#### **Error / Observation**

Access denied for another user:

```text
cat: Permission denied
```

#### **Fix Applied**

Changed group ownership:

```bash
sudo chgrp developer secret.txt
```

#### **Root Cause**

File permissions (640) restricted access to non-owner users.

#### **What I Learned**

* Linux permissions control access via owner, group, and others.

---

#### **Incident 03: Command Typo Error**

#### **What I Was Doing**

Attempted:

```bash
chmd 640 secret.txt
```

#### **Error**

```text
Command not found: chmd
```

#### **Fix Applied**

Corrected to:

```bash
chmod 640 secret.txt
```

#### **Root Cause**

Typographical error in the command name.

#### **What I Learned**

* Linux commands are sensitive to spelling and syntax.

---

#### **Incident 04: Directory Path Error**

#### **What I Was Doing**

Attempted:

```bash
touch ~/secret_project/secret.txt
cd ~/secret_project
```

#### **Error**

```text
No such file or directory
```

#### **Fix Applied**

Corrected path:

```bash
cd ~/devops-lab/secret_project
```

#### **Root Cause**

Incorrect assumption about directory location.

#### **What I Learned**

* Always verify directory structure before navigation.

---

#### **Incident 05: Group Management Conflict**

#### **What I Was Doing**

Created a group and added a user:

```bash
sudo groupadd developer
sudo usermod -aG developer devopsuser
```

#### **Error / Observation**

```text
groupadd: group already exists
```

#### **Fix Applied**

No fix required; reused the existing group.

#### **Root Cause**

The group already existed in the system.

#### **What I Learned**

* Groups persist across sessions and can be reused.

---

#### **Incident 06: Permission Denied on Modification**

#### **What I Was Doing**

Attempted:

```bash
chmod 644 secret.txt
```

(as devopsuser)

#### **Error**

```text
Operation not permitted
```

#### **Fix Applied**

Used the correct privilege escalation method (sudo or owner account).

#### **Root Cause**

Only the file owner or root can modify permissions.

#### **What I Learned**

* Linux enforces strict ownership-based permission control.
* Group ownership affects access, but not modification rights.

---

#### **Incident 07: User Switching / Authentication Failure**

#### **What I Was Doing**

Attempted switching users:

```bash
su -- devopsuser
sudo su -- devopsuser
```

#### **Error**

Authentication failure or incorrect usage of commands.

#### **Fix Applied**

Used the correct command:

```bash
su - devopsuser
```

#### **Root Cause**

Misunderstanding of authentication models:

* su requires the target user's password
* sudo uses the current user's password for elevation

#### **What I Learned**

* su = switch user (requires target user password)
* sudo = run with elevated privileges (uses current user password)
* Correct command choice depends on the permission context

#### **Impact**

* Temporary authentication failures
* No system damage

#### **Prevention**

* Always verify the authentication method before switching users
* Prefer sudo for administrative tasks when appropriate

---
