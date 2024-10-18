
#!/bin/bash

# Fonction pour récupérer l'architecture et la version du kernel
architecture=$(uname -a)

# Fonction pour récupérer le nombre de processeurs physiques
physical_cpu=$(lscpu | grep "^Socket(s):" | awk '{print $2}')

# Fonction pour récupérer le nombre de processeurs virtuels (threads)
virtual_cpu=$(lscpu | grep "^CPU(s):" | awk '{print $2}')

# Fonction pour obtenir la mémoire vive disponible et son taux d'utilisation
memory_usage=$(free -m | awk 'NR==2{printf "%.2f%% (%s/%sMB)", $3*100/$2, $3, $2}')

# Fonction pour obtenir la mémoire disponible et son taux d'utilisation
disk_usage=$(df -h --total | grep "total" | awk '{printf "%.2f%% (%s/%s)", $5, $3, $2}')

# Fonction pour obtenir le taux d'utilisation des processeurs
cpu_load=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

# Fonction pour obtenir la date et l'heure du dernier redémarrage
last_boot=$(who -b | awk '{print $3, $4}')

# Fonction pour vérifier si LVM est actif
lvm_active=$(lsblk | grep "lvm" > /dev/null && echo "active" || echo "inactive")

# Fonction pour obtenir le nombre de connexions actives
active_connections=$(ss -tun | grep ESTAB | wc -l)

# Fonction pour obtenir le nombre d'utilisateurs connectés
users=$(who | wc -l)

# Fonction pour obtenir l'adresse IP et l'adresse MAC
ip_address=$(hostname -I | awk '{print $1}')
mac_address=$(ip link show | grep link/ether | awk '{print $2}')

# Fonction pour obtenir le nombre de commandes sudo exécutées
sudo_commands=$(grep "COMMAND" /var/log/auth.log | wc -l)

# Écrire toutes les informations dans une variable
message="System Monitoring Report:
-------------------------------
Architecture: $architecture
Physical CPUs: $physical_cpu
Virtual CPUs: $virtual_cpu
Memory Usage: $memory_usage
Disk Usage: $disk_usage
CPU Load: $cpu_load
Last Boot: $last_boot
LVM Status: $lvm_active
Active Connections: $active_connections
Logged Users: $users
IP Address: $ip_address
MAC Address: $mac_address
Sudo Commands Executed: $sudo_commands"

# Afficher les informations sur tous les terminaux
wall "$message"
