# Homework #6 – DevOps Task Automation and Hardening

This document describes the tasks I completed for Homework #6. The goal was to install and configure the Nginx web server, manage package sources, harden SSH access, implement automated logging using systemd, and optionally configure a persistent disk mount.

Please see the relevant screenshots attached.

---

##  1. Installing and Configuring Nginx from the Official Repository

I added the official Nginx signing key and repository for Ubuntu, then installed the Nginx package. The server was enabled and started using `systemctl`.

**Why?**
- Using the official repository ensures I get the latest secure and stable version of Nginx.
- It helps avoid compatibility issues that might arise from using outdated or unverified sources.

---

##  2. Adding and Removing a PPA Repository for Nginx

To explore alternative package sources, I added a third-party PPA: `ppa:ondrej/nginx`. After installing the PPA version, I used `ppa-purge` to remove it and roll back to the official Nginx package.

**Key Benefits:**
- This exercise taught me how to manage conflicting sources and safely revert to trusted versions.
- `ppa-purge` is a powerful tool to clean up after experimenting with PPAs.

---

##  3. Creating a Custom systemd Service and Timer

I wrote a script that appends the current date and time to `/var/log/time.log`. Then, I created a systemd service and a timer to execute this script every minute.

**Files Created:**
- `/usr/local/bin/log_time.sh` – the script
- `/etc/systemd/system/logtime.service` – service unit
- `/etc/systemd/system/logtime.timer` – timer unit

**Result:** I now have a working automation system using native Linux service management tools.

---

##  4. Configuring the Firewall (UFW)

I configured UFW to:
- Allow SSH access from a trusted IP (e.g., `192.168.1.10`)
- Deny SSH access from an untrusted IP (e.g., `192.168.1.20`)
- Allow HTTP (port 80) traffic for web access

**Why it matters:**
- Restricting SSH by IP enhances security against brute-force or unauthorized access.
- Allowing only essential ports helps reduce the attack surface.

---

##  5. Securing SSH Access with Fail2Ban

I installed and configured Fail2Ban to monitor SSH login attempts. After enabling the `sshd` jail, the system can now automatically ban IPs after multiple failed login attempts.

**Key Benefits:**
- Real-time protection against brute-force SSH attacks.
- Configurable thresholds and ban durations make it flexible.

---

##  Bonus Task: Mounting a New Disk Partition

I did not perform it, but the logic is as follows:
 - Create and format a new partition (e.g., `/dev/sdb1`).
 - Mount it at `/mnt/mydata`, and add its UUID to `/etc/fstab` for persistent mounting at boot.

fdisk /dev/sdb 
mkfs.ext4 /dev/sdb1
mkdir -p /mnt/mydata
mount /dev/sdb1 /mnt/mydata
UUID=$(blkid -s UUID -o value /dev/sdb1)
echo "UUID=$UUID /mnt/mydata ext4 defaults 0 2" >> /etc/fstab

**Outcome:**
- I now know how to add storage to a Linux system and ensure it's available after reboot.

---

## Final Thoughts

This exercise helped me practice real-world sysadmin tasks:
- Managing services
- Automating scripts
- Controlling access
- Protecting the system

Each of these steps builds a foundation for working in DevOps, infrastructure automation, or cloud environments.
