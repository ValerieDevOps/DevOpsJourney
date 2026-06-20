## DevOps Incident Log (Day 01–07)
## Date: 2026-05-15
## Severity: Low
## Category: Linux User Management / Permissions / Commands

---

## Incident 01: User Creation Failure
## What I was doing
Attempted to create a new user:
sudo adduser devopsuser

## Error
Passwords do not match
passwd: Authentication token manipulation error

## Fix applied
Re-entered matching password and completed user creation.

## Root cause
Password mismatch during user creation.

## What I learned
- User creation requires exact password confirmation.

---

## Incident 02: File Permission Restriction
## What I was doing
Set file permissions:
chmod 640 secret.txt

## Error / Observation
Access denied for another user:
cat: Permission denied

## Fix applied
Changed group ownership:
sudo chgrp developer secret.txt

## Root cause
File permissions (640) restricted access to non-owner users.

## What I learned
- Linux permissions control access via owner, group, and others.

---

## Incident 03: Command Typo Error
## What I was doing
Attempted:
chmd 640 secret.txt

## Error
Command not found: chmd

## Fix applied
Corrected to:
chmod 640 secret.txt

## Root cause
Typographical error in command name.

## What I learned
- Linux commands are sensitive to spelling and syntax.

---

## Incident 04: Directory Path Error
## What I was doing
Attempted:
touch ~/secret_project/secret.txt
cd ~/secret_project

## Error
No such file or directory

## Fix applied
Corrected path:
cd ~/devops-lab/secret_project

## Root cause
Incorrect assumption about directory location.

## What I learned
- Always verify directory structure before navigation.

---

## Incident 05: Group Management Conflict
## What I was doing
Created group and added user:
sudo groupadd developer
sudo usermod -aG developer devopsuser

## Error / Observation
groupadd: group already exists

## Fix applied
No fix required; reused existing group.

## Root cause
Group already existed in system.

## What I learned
- Groups persist across sessions and can be reused.

---

## Incident 06: Permission Denied on Modification
## What I was doing
Attempted:
chmod 644 secret.txt (as devopsuser)

## Error
Operation not permitted

## Fix applied
Used correct privilege escalation (sudo / owner account).

## Root cause
Only file owner or root can modify permissions.

## What I learned
- Linux enforces strict ownership-based permission control.
- Group ownership affects access, but not modification rights.

---

## Incident 07: User Switching / Authentication Failure
## What I was doing
Attempted switching users:
su -- devopsuser
sudo su -- devopsuser

## Error
Authentication failure / incorrect usage of commands

## Fix applied
Used correct command:
su - devopsuser

## Root cause
Misunderstanding of authentication models:
- su requires target user's password
- sudo uses current user's password for elevation

## What I learned
- su = switch user (needs target password)
- sudo = run with elevated privileges (uses current password)
- Correct command choice depends on permission context

## Impact
- Temporary authentication failures
- No system damage

## Prevention
- Always verify authentication method before switching users
- Prefer sudo for administrative tasks when appropriate

---
