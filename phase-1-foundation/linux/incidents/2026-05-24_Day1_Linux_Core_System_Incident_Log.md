# Incident Log — Week 01: Linux Core System

**Phase:** 1 — Foundation
**Engineer:** Valerie
**Week:** 01 (Day 01–07)
**Topic:** Linux Terminal, Filesystem, Permissions, Processes
**Date range:** 2025-05-18

---

## INCIDENT-001

**Date:** 2025-05-18
**Day:** 05
**Severity:** Low
**Category:** Permission

### What I was doing
Creating my-service.sh using nano and trying to run it
as a background service.

### What went wrong
Got Permission denied when trying to execute the script.

### Error message
bash: ./my-service.sh: Permission denied

### What I did to fix it
Ran chmod +x my-service.sh to add execute permission.
Then ran ./my-service.sh again successfully.

### Root cause
Files created with nano or touch get 644 permission by
default. No execute bit. Linux requires x to be explicitly
granted before running a file as a program.

### What I learned
- Every .sh script needs chmod +x before it can run
- Always ls -l before executing to check permissions
- Default permission for new files is 644, no execute
- Most common DevOps error on real servers

---

## INCIDENT-002

**Date:** 2025-05-18
**Day:** 05
**Severity:** Low
**Category:** Syntax

### What I was doing
Writing a while loop in my-service.sh to print a message
every 3 seconds indefinitely.

### What went wrong
Script printed the while loop as plain text and exited
immediately showing [1]+ Done instead of looping.

### Error message
[1]+ Done    ./my-service.sh
while true do echo Service is running.... sleep 3 done

### What I did to fix it
Deleted broken script: rm my-service.sh
Rewrote in nano with each keyword on its own line:
  while true
  do
    echo "[$(date '+%H:%M:%S')] Service is running..."
    sleep 3
  done
Ran cat my-service.sh to verify before executing.

### Root cause
while/do/done were saved on one line in nano. Bash
requires each keyword on its own line. On one line bash
reads it as plain text not as a loop.

### What I learned
- Bash while loop needs each keyword on its own line
- [1]+ Done on a forever service = exited immediately
- Always cat the script after writing to verify structure
- Script printing its own code = syntax not interpreted

---

## INCIDENT-003

**Date:** 2025-05-18
**Day:** 05
**Severity:** Low
**Category:** Navigation

### What I was doing
Restarting the service with output redirected to service.log

### What went wrong
Got Exit 127 immediately. Service started and died.

### Error message
[1]+  Exit 127    ./my-service.sh >> service.log 2>&1

### What I did to fix it
Ran pwd — discovered I was in ~/devops-lab not
~/devops-lab/process where the script lives.
Ran: cd ~/devops-lab/process
Then ran the command again and it worked.

### Root cause
Navigated away from process/ folder during debugging
without noticing. Script was not in current directory.
Exit 127 = command or file not found.

### What I learned
- Exit 127 = file or command not found
- Always pwd before running a script
- ./filename only works if you are IN that folder
- The prompt shows your current folder after the colon

---

## INCIDENT-004

**Date:** 2025-05-18
**Day:** 05
**Severity:** Low
**Category:** Process

### What I was doing
Running ps aux | grep my-service to verify the service
was running after restarting it.

### What went wrong
ps aux showed TWO instances of my-service.sh running.
PIDs 20437 and 20743 from earlier forgotten sessions.

### Error message
valerie 20437 0.2 0.0 /bin/bash ./my-service.sh
valerie 20743 0.2 0.0 /bin/bash ./my-service.sh

### What I did to fix it
pkill -f my-service.sh       # killed all at once
ps aux | grep my-service     # confirmed all dead
cd ~/devops-lab/process
./my-service.sh >> service.log 2>&1 &
ps aux | grep my-service     # one clean instance

### Root cause
Each time I ran ./my-service.sh & without killing the
previous one, a new process started. Old ones kept
running silently. Background processes are not stopped
by Ctrl+C or by starting a new instance.

### What I learned
- Always kill old instance before starting a new one
- pkill -f name kills ALL matching processes at once
- Background processes survive Ctrl+C
- ps aux | grep name detects orphan processes
- Multiple instances waste resources and cause confusion

---

## INCIDENT-005

**Date:** 2025-05-18
**Day:** 05
**Severity:** Low
**Category:** Process

### What I was doing
Running service in background with & while trying to
type other commands at the same time.

### What went wrong
Service output flooded terminal every 3 seconds.
Ctrl+C multiple times did not stop it.

### Error message
[02:02:56] Service is running...
^C
[02:03:02] Service is running...
^C
[02:03:05] Service is running...

### What I did to fix it
Opened new terminal window and ran:
pkill -f my-service.sh

Then restarted with output redirected:
./my-service.sh >> service.log 2>&1 &
tail -f service.log

### Root cause
& detaches process from terminal CONTROL but not from
terminal OUTPUT. Output still prints to screen unless
you explicitly redirect it with >> logfile 2>&1.

### What I learned
- & runs in background but output still hits terminal
- >> service.log 2>&1 redirects output silently to file
- Ctrl+C cannot kill a background process
- tail -f lets you watch log without flooding terminal
- Always redirect output when running background services
---
