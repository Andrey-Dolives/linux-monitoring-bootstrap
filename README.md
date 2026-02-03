# Linux Monitoring Bootstrap (Nagios / NSCA)

## 📌 Overview
Automation script used for installing and validating Nagios/NSCA monitoring on Ubuntu Linux servers.
The script standardizes monitoring setup by handling Nagios prerequisites, swap configuration, and cron-based execution.

This script was written for **real customer environments** and is actively used during Nagios deployments.

---

## 🎯 Scope & Assumptions
- This project is **Nagios/NSCA-specific**
- The directory layout follows internal company standards (e.g. `/etc/nagios`)
- The script is intended for controlled customer servers following internal procedures
- It is **not** designed to be a generic monitoring installer

---

## 🛠️ Tech Stack
- Bash
- Ubuntu Linux
- Nagios / NSCA
- Cron

---

## ✨ Features
- Detects existing Nagios installation
- Installs required monitoring components if missing
- Ensures swap is configured
- Adds required cron jobs safely (idempotent)
- Designed to be re-run without duplicating configuration

---

## 🚀 How to Run
This script **must be executed with root privileges**:


⚠️ Important Notes
- System paths such as /etc/nagios reflect real internal deployment standards
- External artifacts (e.g. NSCA archive) are not included in this repository
- Any external download sources should be replaced with organization-approved packages when used in different environments

🧠 What I Learned
- Automating repeatable monitoring installation tasks
- Standardizing system configuration across multiple servers
- Reducing manual errors during monitoring deployments

🔮 Future Improvements
- Replace external archives with official package repositories
- Improve error handling and status reporting
- Support additional OS versions where required
