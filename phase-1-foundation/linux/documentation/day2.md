DAY 02 - DEVOPS LINUX FOUNDATION (WSL2)

Objective
To practice Linux filesystem operations inside a structured DevOps lab environment, focusing on directory management, file handling, navigation precision, and system organization using Bash commands.

Tools Used
WSL2 (Ubuntu Linux)
Bash Shell
Core Linux utilities: mkdir, touch, mv, rm, rmdir, find, ls, cd, sudo, chown

1. DevOps Lab Structure Initialization
mkdir app logs config
mkdir app/src
touch app/app.py
touch app/src/main.py

OBSERVATION:
Initial structure created for application, configuration, and logging layers.

Insight:
DevOps systems are modular — each folder represents a system responsibility:

app → application logic
config → system configuration
logs → system tracking

⚙️ 2. File Verification & Discovery
ls -la app.py
find .

OBSERVATION:

app.py was not found in root directory (only inside app/)
Directory structure expanded into multiple nested components

Insight:
Linux requires exact path awareness. Files do not “exist globally” — only in defined locations.

3. Log & Config File Creation
touch logs/access.log
touch logs/error.log
touch config/settings.config
touch config/.env

Insight:
Standard DevOps pattern:

access.log → system activity tracking
error.log → failure monitoring
.env → environment variables
settings.config → system configuration

4. Directory Exploration
find . -not -path './.git*' | sort

OBSERVATION:
Full system structure confirmed:

app/
config/
logs/
projects/
scripts/

Insight:
find is a core DevOps tool for auditing infrastructure state.
5. Directory Cleanup & Correction Phase

rm settings.config
mkdir settings.conf (incorrect usage)
rmdir logs
rmdir logs,
mv projects, projects
mv scripts, scripts

OBSERVATION:

Mistaken creation of folders with trailing commas
Misuse of rmdir and rm on wrong file types
Gradual correction of directory naming structure

Insight:
DevOps environments are sensitive to naming precision. Small syntax or naming errors create structural inconsistencies.

6. Command Errors & Misunderstanding Phase
rmdir settings.config → Not a directory
rm logs → Is a directory
rmdir logs → Directory not empty
Command typo: find. instead of find .
Command typo: rmdir: not recognized due to syntax error

Insight:
Linux does not interpret intent — only exact commands.
Errors are part of system feedback, not failure.

7. File Movement & Structure Reorganization
mv config/settings.conf logs/settings.conf
mv logs/access.log app/access.log
mv logs/app.py app/app.py
mv logs/settings.conf config/settings.conf

OBSERVATION:
Files were redistributed across system layers:

config → configuration ownership
logs → logging ownership
app → application logic ownership

Insight:
DevOps systems require correct ownership alignment — files must live where their function belongs.

8. File Type Filtering & System Inspection
find . -name ".py"
find . -name ".conf"
find . -name "*.log"

OUTPUT INSIGHT:

Python files located in app layer
Configuration files in config layer
Log files in logs layer

Insight:
File type filtering is essential for system visibility and debugging.

9. Permission Management Introduction
sudo chown root:root settings.conf

Insight:
Ownership control defines system security boundaries.
Root ownership represents elevated system authority and restricted modification access.

10. Final Structure Validation
ls -la
find . | sort

FINAL STRUCTURE CONFIRMED:
app/
config/
logs/
projects/
scripts/

Insight:
System cleanup completed successfully. Redundant naming issues resolved.

FINAL SUMMARY
What was accomplished:

Created full DevOps lab environment
Practiced file creation and directory structuring
Learned Linux strict path and syntax enforcement
Practiced file movement across system layers
Performed system cleanup and correction
Used find for full infrastructure inspection
Introduced permission control (chown)

DEVOPS CORE INSIGHT
Day 02 is not about file operations.
It is about understanding that:

A DevOps system is not built by commands —
it is built by precision, structure, and correction under constraint.

Small errors compound into system misalignment.
Precision is the real engineering skill.
