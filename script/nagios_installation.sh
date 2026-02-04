#!/bin/bash
#Ubuntu Desktop Monitorng Services Installation

NAGIOS_DIR="/etc/nagios"
swap=$(free -h | grep Swap | awk {'print $2'})
CRON_LINE="*/5 * * * * /etc/nagios/nsca > /dev/null 2>&1"


check_nagios(){
    if [ -d /etc/nagios ]; then
    files="nsca libexec nscaConfig nsca.tgz plugins send_data.pl send_nsca.cfg send_nsca_i386 send_nsca_i686 send_nsca_x86_64"
    missing=""

    for f in $files; do
        if [ ! -e "$NAGIOS_DIR/$f" ]; then
            missing="$missing
            - $NAGIOS_DIR/$f"
        fi
    done

        if [ -n "$missing" ]; then
            echo "Nagios is NOT fully installed. Missing files:"
            echo "$missing"
            exit 2
        else
            echo "Nagios is already installed"
            
        fi

    else
        echo "Nagios wasn't found on the current server"
        apt-get install libmcrypt-dev
        apt-get install monitoring-plugins
        mkdir /etc/nagios
        cd /etc/nagios
        wget --no-check-certificate --content-disposition "https://drive.google.com/uc?export=download&id=1bZ5kF1nTzqpiGX81fTPlk3DaxP95grK2" -O nsca.tgz
        tar -xzf nsca.tgz
        cp /usr/lib/nagios/plugins/* /etc/nagios/plugins
        #hostname_reg
        read -p "Please enter HOSTNAME for Monitoring: " HOSTNAME
        sed -i "1s/^host=.*/host=$HOSTNAME/" nscaConfig
    fi
}
check_swap(){
    if [[ $swap = "0B" ]]; then
                mkdir /swap
                cd /swap
                touch swapfile
                dd if=/dev/zero of=/swap/swapfile bs=1M count=4096
                fallocate --length 4096M /swap/swapfile
                chmod 600 /swap/swapfile
                mkswap /swap/swapfile
                swapon /swap/swapfile
                free -h
        else
                echo "Swap is already configured"
    fi
}
check_cron(){
        (crontab -l 2>/dev/null | grep -F "$CRON_LINE") >/dev/null
    if [ $? -eq 0 ]; then
        echo "Cron job already exists"
    else
        (crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
        echo "Cron job added"
    fi
}

check_nagios
check_swap
check_cron
