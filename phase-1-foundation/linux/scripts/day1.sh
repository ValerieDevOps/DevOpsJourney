#!/bin/bash

# =========================
# DEVOPS DAY 01 REPLAY SCRIPT
# =========================

echo "===== DEVOPS DAY 01 START ====="

# System info
pwd
uname -r
whoami
git --version

echo "===== SYSTEM CHECK COMPLETE ====="

# -------------------------
# Workspace setup
# -------------------------
cd ~
mkdir -p devops-lab/{projects,scripts,logs,config}
mkdir -p devops-lab/wrong-folder

ls -la devops-lab

# Remove wrong folder
rmdir devops-lab/wrong-folder 2>/dev/null

# Verify structure
find devops-lab -type d

# -------------------------
# Git configuration
# -------------------------
git --version

git config --global user.name "Valerie Kelechukwu"
git config --global user.email "valeriedevops@gmail.com"
git config --global init.defaultBranch main

git config --list

# -------------------------
# Clone project
# -------------------------
cd ~
git clone https://github.com/ValerieDevOps/DevOpsJourney.git

cd DevOpsJourney || exit

# -------------------------
# Project structure creation
# -------------------------
mkdir -p phase-1-foundation/{linux,git,networking,aws-ec2}/{scripts,logs,incidents,projects}
mkdir -p phase-2-building/{linux-advanced,docker,ci-cd,aws-monitoring}/projects
mkdir -p phase-3-production/{terraform,ci-cd-production,incidents}/projects

# Create gitkeep files
find . -type d -not -path "./.git*" -exec touch {}/.gitkeep \;

# -------------------------
# Linux script creation
# -------------------------
cd phase-1-foundation/linux/scripts || exit

cat << 'EOF' > day01.sh
#!/bin/bash
echo "===== DEVOPS DAY 01 START ====="
pwd
uname -r
whoami
git --version
echo "===== DAY 01 COMPLETE ====="
EOF

chmod +x day01.sh
./day01.sh

# -------------------------
# Logging (script session)
# -------------------------
cd ../../linux/logs || exit
script day01.log

# return to scripts and run again
cd ../scripts || exit
./day01.sh

exit

# -------------------------
# Git operations
# -------------------------
cd ~/DevOpsJourney/phase-1-foundation || exit

git add .
git commit -m "Add full DevOps folder structure and Day01 scripts"
git push origin main

echo "===== DEVOPS DAY 01 COMPLETE ====="