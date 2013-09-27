###########################################################################
# Install additional or update groups if needed
###########################################################################

cernvm_start () {
  if [ -f /etc/pki/tls/private/localhost.key -o -f /etc/pki/tls/certs/localhost.crt ]; then
    return 0
  fi

  if [ ! -f /etc/pki/tls/private/localhost.key ] ; then
    /usr/bin/openssl genrsa -rand /proc/apm:/proc/cpuinfo:/proc/dma:/proc/filesystems:/proc/interrupts:/proc/ioports:/proc/pci:/proc/rtc:/proc/uptime 1024 > /etc/pki/tls/private/localhost.key 2> /dev/null
    chmod 0640 /etc/pki/tls/private/localhost.key
    chown root:apache /etc/pki/tls/private/localhost.key
  fi

  FQDN=`hostname`
  if [ "x${FQDN}" = "x" ]; then
    FQDN=localhost.localdomain
  fi

  if [ ! -f /etc/pki/tls/certs/localhost.crt ] ; then
    cat << EOF | /usr/bin/openssl req -new -key /etc/pki/tls/private/localhost.key \
                   -x509 -days 365 -set_serial $RANDOM \
                   -out /etc/pki/tls/certs/localhost.crt 2>/dev/null
--
SomeState
SomeCity
SomeOrganization
SomeOrganizationalUnit
${FQDN}
root@${FQDN}
EOF
  chmod 444 /etc/pki/tls/certs/localhost.crt
  fi
}

cernvm_stop () {
  true
}
