#!/bin/bash

# ==================================
# DEVOPS LAB SETUP + HUSHLOGIN SCRIPT
# ==================================

echo "===== STARTING SETUP ====="

# 1. Create .hushlogin (silences login messages)
touch /home/valerie/.hushlogin

echo "Created .hushlogin"

# 2. Go to home directory
cd /home/valerie || exit

# 3. Create project structure
mkdir -p devops-lab/{app,logs,config,projects,scripts}

# 4. App structure
mkdir -p devops-lab/app/src
touch devops-lab/app/app.py
touch devops-lab/app/src/main.py

# 5. Logs
touch devops-lab/logs/access.log
touch devops-lab/logs/error.log

# 6. Config files
touch devops-lab/config/.env
touch devops-lab/config/settings.conf

# 7. Cleanup wrong files (safe checks)
rm -f devops-lab/logs, 2>/dev/null
rm -f devops-lab/projects, 2>/dev/null
rm -f devops-lab/scripts, 2>/dev/null

# 8. Fix any accidental directories naming issues
mv devops-lab/projects, devops-lab/projects 2>/dev/null
mv devops-lab/scripts, devops-lab/scripts 2>/dev/null

# 9. Show final structure
echo "===== FINAL STRUCTURE ====="
find devops-lab -not -path './.git*' | sort

echo "===== SETUP COMPLETE ====="