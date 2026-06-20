Systemd Service Management

Systemcd is the first process that runs when Linux boots

Systemctl is the command you used to talk to system. 

You don't manage services directly — you tell systemd what you want, and systemd does it.

Nigerian analogy: 
Think of a serviced estate in Lekki. 
The estate manager runs the generator, the water pump, the security gate ;
All on a schedule, all monitored, all restarted automatically if they fail.
You never touch the generator yourself. You call the estate manager's office. systemd is the estate manager. 
systemctl is the phone line you use to reach them. boots and it is the manager of every other process.


Properties/States of Every Service

active / inactive / failed: Is it running right now? This changes the moment you reboot — nothing here survives a restart on its own.
enabled / disabled: Will it start automatically on the next boot? This says nothing about whether it's running right now.

A service can be active but not enabled — running fine now, but gone after the next reboot. Or enabled but not active — will start at boot, but isn't running yet. Production outages happen when engineers assume one means the other.

Core commands you must memorise
systemctl status NAME	Full health report — current state, PID, last few log lines. Your default first command.
systemctl start NAME	Start it right now. Does not affect boot behaviour.
systemctl stop NAME	Stop it right now. Does not affect boot behaviour.
systemctl restart NAME	Stop, then start, in one step.
systemctl enable NAME	Start automatically on every future boot.
systemctl disable NAME	Remove from automatic boot startup.
systemctl is-active NAME	Prints just the word: active or inactive.
systemctl is-enabled NAME	Prints just the word: enabled or disabled.
journalctl -u NAME	Logs for that one service only — your main debugging tool.

Service and Unit Files

A service is a process managed by systemd, and the service is defined by a service unit file stored on disk.

1. Unit files live in /etc/systemd/system/

A systemd service is defined in a text file that ends with .service.

Example:

/etc/systemd/system/webapp.service

systemd reads this file to learn:

What program to run
When to run it
Who should run it
Whether it should restart
Whether it should start during boot

2. [Unit] — Description and Ordering

This section answers:

"What is this service and when should it start relative to other services?"

Example:

[Unit]
Description=Web Application Service
After=network.target

Meaning:

Description= → Human-readable label
After=network.target → Wait until networking starts before starting this service

3. [Service] — What to Actually Run

This section answers:

"What process should systemd manage?"

Example:

[Service]
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always
User=devopsuser

Meaning:

ExecStart= → Command to execute
Restart= → What to do if it crashes
User= → Which Linux user runs the process

4. [Install] — Boot Behaviour

This section answers:

"Should this service automatically start when the system boots?"

Example:

[Install]
WantedBy=multi-user.target

Meaning:

When you run:

sudo systemctl enable webapp.service

systemd remembers:

At normal system startup,
automatically start webapp.service.
The Big Picture

Your notes are really saying:

A systemd unit file tells Linux:

1. What the service is      -> [Unit]
2. What command to run      -> [Service]
3. When to start it at boot -> [Install]

NB: WantedBy=multi-user.target 
This means Start this service automatically when the system reaches normal operating mode if the service has been enabled

[Unit]
After=network.target
"Start this service only after the networking subsystem has started."

Every time you edit a unit file, you must run sudo systemctl daemon-reload before systemd will see the change. 

Systemd Service Management

Systemd manages applications as services.

!. Create application/script file

2. Make the file executeable
chmod +x file

3. Create the service unit file

4. Reload the service for systemd to update the change
sudo systemctl daemon-reload

5. Start the service and check the status of the service

6. Watch it actually log
tail -f ~/file_directory

7. Enable the service so it reboots
sudo systemctl enable file


                            SERVER

┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  ┌──────────────┐                                           │
│  │   systemd    │                                           │
│  └──────┬───────┘                                           │
│         │ manages                                           │
│         ▼                                                   │
│  ┌──────────────────────┐                                   │
│  │ taskflow.service     │                                   │
│  │ (Unit File)          │                                   │
│  └──────┬───────────────┘                                   │
│         │ ExecStart=                                        │
│         ▼                                                   │
│  ┌──────────────────────┐                                   │
│  │ Django/Flask Code    │                                   │
│  │ app.py               │                                   │
│  │ manage.py            │                                   │
│  │ views.py             │                                   │
│  └──────┬───────────────┘                                   │
│         │ executed                                           │
│         ▼                                                   │
│  ┌──────────────────────┐◄──────────┐                       │
│  │ Running App Process  │           │                       │
│  │ PID 1234             │           │                       │
│  │ Listening on :5000   │           │                       │
│  └──────────────────────┘           │                       │
│                                     │ forwards requests     │
│  ┌──────────────────────┐           │                       │
│  │ Nginx                │───────────┘                       │
│  │ Port 80 / 443        │                                   │
│  └──────────────────────┘                                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          ▲
                          │
                   DNS Resolution
                          │
                          ▼
                        User

How do applications run 24/7

            Datacenter 
A datacenter is a facility that houses the physical computers (servers) that run websites, applications, databases, cloud services,     and internet infrastructure.
               │
                ▼

      Ubuntu Server (24/7) - servers run forever
                │
                ▼

            systemd -    keeps services alive and applications stays available
                 │
      ┌─────────┴─────────┐
      │                   │
      ▼                   ▼

    Nginx            Application
  Port 80/443         Port 5000
      │                   │
      └─────────┬─────────┘
                │
                ▼

          Internet Users


Problems:

Power outages
Internet interruptions
Hardware failures
Limited performance

A datacenter solves these problems

What Makes a Datacenter Special?
Power

Problems
Electricity Fails
       ↓
Backup Batteries (UPS)
       ↓
Diesel Generators

DataCenter ensures Servers keep running.

2. Cooling

Problems

Servers generate a lot of heat.

Thousands of Servers
         ↓
Massive Cooling Systems

Datacenter Provides cooling, Without cooling, hardware would overheat.

3. Internet Connectivity

Datacenters have multiple high-speed internet connections.

Internet Provider A
Internet Provider B
Internet Provider C

If one fails, traffic uses another.

Physical Security
Security Guards
Cameras
Biometric Access
Locked Cages

Not just anyone can walk in.

Debugging decision tree
1
Shows "inactive (dead)"?
Not broken — just not running. Someone (maybe you) stopped it, or it was never started. Run start.
2
Shows "failed"?
It tried to run and crashed or couldn't execute. Always check the Process line in status and the last 20 lines of journalctl -u before changing anything.
3
"Interactive authentication required"?
You forgot sudo. Reading status never needs it; changing state always does.
Nigerian analogy: Reporting a generator fault to the estate manager — "status" is the manager telling you the generator is currently off. "journalctl" is the manager's logbook telling you exactly why it tripped last time: out of fuel, wrong switch, faulty wire. You don't guess — you read the logbook first.



