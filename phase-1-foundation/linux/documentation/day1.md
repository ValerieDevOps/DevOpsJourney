#### **DAY 01 - LINUX & GIT FOUNDATION**

#### **Objective**

Understand Linux system + Git configuration in WSL2 environment.

#### **Environment**

* OS: Windows + WSL2 Ubuntu
* Kernel: 6.6.87.2
* Git: 2.43.0

#### **Activities**

* System inspection (uname, pwd)
* File system navigation
* Git configuration
* Repository cloning
* Directory structure creation

#### **Observations**

* Linux does not mirror Windows folders
* Commands require exact syntax
* Hidden files control system behavior

#### **Issues**

* Typo in git config (--glogal)
* Missing directories in WSL environment

#### **Outcome**

* Git configured successfully
* DevOps folder structure created
* Linux navigation understood

#### **Key Insight**

DevOps is not about commands — it's about system control and precision.

---

#### **DAY 01 - DEVOPS LINUX FOUNDATION**

#### **📌 Objective**

To understand the Linux environment inside WSL2, practice system navigation, explore file structure, initialize Git configuration, and begin building a structured DevOps learning environment.

#### **🧠 Tools Used**

* WSL2 (Ubuntu Linux)
* Bash Shell
* Git

#### **⚙️ 1. System Exploration**

```bash
pwd
uname -r
```

#### **OUTPUT**

```text
6.6.87.2-microsoft-standard-WSL2
```

#### **Insight**

This confirms a real Linux kernel running inside Windows using WSL2. This is a production-relevant DevOps environment setup.

#### **⚙️ 2. Directory Inspection**

```bash
ls
ls -la
```

#### **OBSERVATION**

Hidden system files exist:

* .bashrc
* .profile
* .cache
* Command history stored in .bash_history

#### **Insight**

Linux keeps configuration, history, and environment settings as hidden files for system control.

#### **⚙️ 3. System Navigation**

```bash
cd ~
cd /
cd ..
cd home
```

#### **Insight**

Linux file system structure:

* / = root system
* /home = user directories
* ~ = current user home directory

#### **⚠️ 4. Command Errors (Learning Phase)**

```bash
cd Downloads
cd Desktop
mkdirr devopslab
git config --glogal
```

#### **Insight**

* Linux does not assume Windows folder structure
* Commands must be exact
* Small typos break execution
* DevOps requires precision

#### **⚙️ 5. DevOps Lab Setup**

```bash
mkdir devops-lab

mkdir -p devops-lab/scripts \
devops-lab/logs \
devops-lab/config \
devops-lab/projects
```

#### **STRUCTURE CREATED**

```text
devops-lab/
├── scripts/
├── logs/
├── config/
└── projects/
```

#### **Insight**

DevOps systems are structured into:

* scripts = automation
* logs = system tracking
* config = settings
* projects = deployments

#### **⚙️ 6. Cleanup Practice**

```bash
rmdir devops-lab/wrong-folder
```

#### **Insight**

Infrastructure hygiene is important. Unused components must be removed.

#### **⚙️ 7. System Inspection**

```bash
find devops-lab -type d
```

#### **OUTPUT**

```text
devops-lab
devops-lab/config
devops-lab/projects
devops-lab/scripts
```

#### **Insight**

Used in DevOps to audit infrastructure structure and verify system state.

#### **⚙️ 8. Git Installation Check**

```bash
git --version
```

#### **OUTPUT**

```text
git version 2.43.0
```

#### **Insight**

Git is the backbone of DevOps version control systems.

#### **⚙️ 9. Git Configuration**

```bash
git config --global user.name "Valerie Kelechukwu"
git config --global user.email "valeriedevops@gmail.com"
git config --list
```

#### **OUTPUT**

```text
user.name=Valerie Kelechukwu
user.email=valeriedevops@gmail.com
init.defaultbranch=main
```

#### **Insight**

Every DevOps action must be traceable to an identity for auditing and collaboration.

#### **⚙️ 10. GitHub Repository Cloning**

```bash
git clone https://github.com/ValerieDevOps/DevOpsJourney.git
cd DevOpsJourney
```

#### **Insight**

This represents a real DevOps workflow:

Remote repository → Local environment synchronization

#### **⚙️ 11. DevOps Architecture Design**

```bash
mkdir -p phase-1-foundation/linux/scripts phase-1-foundation/linux/logs phase-1-foundation/linux/incidents
mkdir -p phase-1-foundation/networking/scripts phase-1-foundation/networking/logs phase-1-foundation/networking/incidents
mkdir -p phase-1-foundation/git/scripts phase-1-foundation/git/projects phase-1-foundation/git/incidents
mkdir -p phase-1-foundation/aws-ec2/scripts phase-1-foundation/aws-ec2/logs phase-1-foundation/aws-ec2/projects phase-1-foundation/aws-ec2/incidents

mkdir -p phase-2-building/linux-advanced/scripts phase-2-building/linux-advanced/logs phase-2-building/linux-advanced/incidents
mkdir -p phase-2-building/docker/projects
mkdir -p phase-2-building/ci-cd/projects
mkdir -p phase-2-building/aws-monitoring/projects

mkdir -p phase-3-production/terraform/projects
mkdir -p phase-3-production/ci-cd-production/projects
mkdir -p phase-3-production/incidents
```

#### **Insight**

This represents a full DevOps lifecycle:

* Phase 1 = Foundations (Linux, Networking, Git, AWS basics)
* Phase 2 = System Building (Docker, CI/CD, Monitoring)
* Phase 3 = Production Systems (Infrastructure, Scaling, Incidents)

#### **⚙️ 12. Git Tracking Preparation**

```bash
find . -type d -not -path './.git*' -exec touch {}/.gitkeep \;
```

#### **OUTPUT**

```text
36 .gitkeep files created
```

#### **Insight**

Git does not track empty folders. `.gitkeep` ensures structure integrity.

#### ** FINAL SUMMARY**

#### **What Was Accomplished**

* Linux system exploration (WSL2 environment)
* Command-line navigation and structure understanding
* Error handling and correction mindset
* Git setup and identity configuration
* Remote repository cloning
* DevOps folder architecture design
* Infrastructure structuring principles
* Git tracking system initialization

#### ** DEVOPS CORE INSIGHT**

Day 01 is not about commands.

It is about:

* Structure over randomness
* Precision over assumptions
* Traceability over execution
* System thinking over isolated commands
