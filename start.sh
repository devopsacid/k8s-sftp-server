#!/bin/bash

# Check for users.txt and create users
if [ -f /home/users.txt ]; then
    while IFS=: read -r user password homedir
    do
        useradd -ms /bin/bash "$user"
        echo "$user:$password" | chpasswd
        if [ -n "$homedir" ]; then
            mkdir -p /home/"$user"/"$homedir"
            chown -R "$user":"$user" /home/"$user"/"$homedir"
        else
            mkdir -p /home/"$user"
            chown -R "$user":"$user" /home/"$user"
        fi
    done < /home/users.txt
fi

# Update SSH configuration to enable SFTP for every user
cat /home/users.txt | cut -d: -f1 | while read user; do
    echo "Match User ${user}\n\tChrootDirectory /home/${user}\n\tAllowTCPForwarding no\n\tX11Forwarding no\n\tForceCommand internal-sftp" >> /etc/ssh/sshd_config
done

# Start SSH server
/usr/sbin/sshd -D

# Check for users.txt and create users
if [ -f /home/users.txt ]; then
    while IFS=: read -r user password
    do
        useradd -ms /bin/bash "$user"
        echo "$user:$password" | chpasswd
        mkdir -p /home/"$user"/.ssh
        chown -R "$user":"$user" /home/"$user"/.ssh
    done < /home/users.txt
fi

# Update SSH configuration to enable SFTP for every user
cat /home/users.txt | cut -d: -f1 | while read user; do
    echo "Match User ${user}\n\tChrootDirectory /home/${user}\n\tAllowTCPForwarding no\n\tX11Forwarding no\n\tForceCommand internal-sftp" >> /etc/ssh/sshd_config
done

# Start SSH server
/usr/sbin/sshd -D
