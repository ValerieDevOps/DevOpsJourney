# Incident Report

**Date:** 2026-06-18  
**Day:** 10  
**Severity:** Low  
**Category:** Service Configuration / Logging

## Incident Summary

While configuring SSH on Ubuntu WSL2, the SSH service failed to start because the OpenSSH Server package was not installed. The issue was investigated, resolved through package installation, and verified through service monitoring and SSH connectivity testing.

## What I Was Doing

I was configuring and testing SSH access as part of Linux service management and system logging practice.

I attempted to start the SSH service using:

```bash
sudo systemctl start ssh
```

## Error / Investigation

The system returned the following error:

```text
Failed to start ssh.service: Unit ssh.service not found.
```

### Investigation Steps

1. Verified command syntax.
2. Confirmed that the SSH service unit did not exist.
3. Updated package repositories:

```bash
sudo apt update
```

4. Investigated whether OpenSSH Server was installed.
5. Determined that the SSH service was unavailable because the OpenSSH Server package was missing.

## Fix Applied

Installed OpenSSH Server:

```bash
sudo apt install openssh-server
```

Started the SSH service:

```bash
sudo systemctl start ssh
```

Verified service status:

```bash
sudo systemctl status ssh
```

Monitored service logs:

```bash
sudo journalctl -u ssh -f
```

Tested SSH connectivity:

```bash
ssh localhost
```

## Root Cause

The OpenSSH Server package had not been installed on the system. Since the SSH service unit is created during installation, systemd could not locate or start the service before the package was installed.

## What I Learned

- A "Unit not found" error from systemctl usually indicates that the service package is missing.
- Services managed by systemd require valid service unit files before they can be started.
- OpenSSH Server installation automatically creates the SSH service configuration.
- journalctl provides real-time visibility into service activity and authentication events.
- Service validation should include both status checks and functional testing.

## Impact

- SSH testing activities were temporarily blocked.
- Service monitoring exercises could not proceed until the package was installed.
- No system damage or data loss occurred.
- Learning objectives were delayed but successfully completed.

## Prevention

- Verify required packages are installed before attempting to start services.
- Confirm service availability before troubleshooting configuration issues.
- Follow a standard workflow: Install → Start → Verify → Monitor.
- Maintain documentation of required service dependencies.
- Include package verification as part of environment setup procedures.

## Outcome

OpenSSH Server was successfully installed and configured. The SSH service started correctly, service logs were monitored using journalctl, SSH connectivity was validated through localhost testing, and Linux service management concepts were successfully practiced.
