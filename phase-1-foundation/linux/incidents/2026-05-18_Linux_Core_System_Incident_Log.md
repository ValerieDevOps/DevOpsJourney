#### **Incident Log — Week 01: Linux Core System**

#### **Phase:** Foundation

#### **Engineer:** Valerie

#### **Week:** 01 (Day 01–07)

#### **Topic:** Linux Terminal, Filesystem, Permissions, Processes

#### **Date Range:** 2025-05-18

---

#### **INCIDENT-001**

#### **Date:** 2025-05-18

#### **Day:** 05

#### **Severity:** Low

#### **Category:** Permission

#### **What I Was Doing**

Creating `my-service.sh` using nano and trying to run it as a background service.

#### **What Went Wrong**

Got Permission denied when trying to execute the script.

#### **Error Message**

```text
bash: ./my-service.sh: Permission denied
```

#### **What I Did to Fix It**

Ran:

```bash
chmod +x my-service.sh
```

Then ran:

```bash
./my-service.sh
```

again successfully.

#### **Root Cause**

Files created with nano or touch get `644` permissions by default. No execute bit is assigned. Linux requires the execute (`x`) permission before running a file as a program.

#### **What I Learned**

* Every `.sh` script needs `chmod +x` before it can run
* Always use `ls -l` before executing to check permissions
* Default permission for new files is `644` (no execute permission)
* This is one of the most common DevOps errors on real servers

---

#### **INCIDENT-002**

#### **Date:** 2025-05-18

#### **Day:** 05

#### **Severity:** Low

#### **Category:** Syntax

#### **What I Was Doing**

Writing a while loop in `my-service.sh` to print a message every 3 seconds indefinitely.

#### **What Went Wrong**

The script printed the while loop as plain text and exited immediately, showing `[1]+ Done` instead of looping.

#### **Error Message**

```text
[1]+ Done    ./my-service.sh
while true do echo Service is running.... sleep 3 done
```

#### **What I Did to Fix It**

Deleted the broken script:

```bash
rm my-service.sh
```

Rewrote it in nano with each keyword on its own line:

```bash
while true
do
  echo "[$(date '+%H:%M:%S')] Service is running..."
  sleep 3
done
```

Verified the script:

```bash
cat my-service.sh
```

before executing.

#### **Root Cause**

`while`, `do`, and `done` were saved on a single line. Bash requires each keyword to be correctly structured. Bash interpreted the line as plain text rather than a loop.

#### **What I Learned**

* Bash while loops require proper structure
* `[1]+ Done` on a forever-running service usually means it exited immediately
* Always inspect scripts with `cat` before running them
* If a script prints its own code, Bash is not interpreting it correctly

---

#### **INCIDENT-003**

#### **Date:** 2025-05-18

#### **Day:** 05

#### **Severity:** Low

#### **Category:** Navigation

#### **What I Was Doing**

Restarting the service with output redirected to `service.log`.

#### **What Went Wrong**

Received Exit 127 immediately. The service started and then terminated.

#### **Error Message**

```text
[1]+ Exit 127    ./my-service.sh >> service.log 2>&1
```

#### **What I Did to Fix It**

Checked my location:

```bash
pwd
```

Discovered I was in:

```text
~/devops-lab
```

instead of:

```text
~/devops-lab/process
```

Corrected it:

```bash
cd ~/devops-lab/process
```

Then reran the command successfully.

#### **Root Cause**

I navigated away from the `process` directory during debugging. The script was not located in the current working directory.

#### **What I Learned**

* Exit `127` usually means command or file not found
* Always run `pwd` before executing scripts
* `./filename` only works when you are in the correct directory
* The shell prompt indicates your current location

---

#### **INCIDENT-004**

#### **Date:** 2025-05-18

#### **Day:** 05

#### **Severity:** Low

#### **Category:** Process

#### **What I Was Doing**

Running:

```bash
ps aux | grep my-service
```

to verify the service was running after restarting it.

#### **What Went Wrong**

Two instances of `my-service.sh` were running simultaneously.

#### **Error Message**

```text
valerie 20437 0.2 0.0 /bin/bash ./my-service.sh
valerie 20743 0.2 0.0 /bin/bash ./my-service.sh
```

#### **What I Did to Fix It**

Killed all matching processes:

```bash
pkill -f my-service.sh
```

Verified termination:

```bash
ps aux | grep my-service
```

Restarted cleanly:

```bash
cd ~/devops-lab/process
./my-service.sh >> service.log 2>&1 &
ps aux | grep my-service
```

#### **Root Cause**

Each execution of:

```bash
./my-service.sh &
```

created another background process. Previous instances continued running.

#### **What I Learned**

* Always stop old instances before starting new ones
* `pkill -f` can terminate all matching processes
* Background processes continue running independently
* `ps aux | grep` helps identify orphaned processes
* Multiple service instances can waste resources and create confusion

---

#### **INCIDENT-005**

#### **Date:** 2025-05-18

#### **Day:** 05

#### **Severity:** Low

#### **Category:** Process

#### **What I Was Doing**

Running a service in the background using `&` while continuing other terminal work.

#### **What Went Wrong**

Service output flooded the terminal every 3 seconds. Pressing `Ctrl+C` repeatedly did not stop it.

#### **Error Message**

```text
[02:02:56] Service is running...
^C
[02:03:02] Service is running...
^C
[02:03:05] Service is running...
```

#### **What I Did to Fix It**

Opened another terminal and terminated the process:

```bash
pkill -f my-service.sh
```

Restarted with output redirected:

```bash
./my-service.sh >> service.log 2>&1 &
```

Monitored logs using:

```bash
tail -f service.log
```

#### **Root Cause**

The `&` operator detaches process execution from terminal control, but not from terminal output. Output continues to display unless redirected.

#### **What I Learned**

* `&` runs a process in the background
* Background output still appears unless redirected
* `>> service.log 2>&1` redirects both standard output and errors
* `Ctrl+C` does not stop background processes
* `tail -f` is useful for monitoring logs in real time
* Always redirect output for background services

---
