#/bin/bash

if [ ! -f /var/log/auth.log ];
then
  echo "auth.log file missing, either logs not configured properly or incompatible system"
  exit 1
fi

if [ ! -r /var/log/auth.log ];
then
  echo "User $USER doesn't have read permission on /var/log/auth.log";
  exit 1;
fi

## Bad ssh attempts
echo "Failed ssh attempts blocked by ssh key:"
grep "PAM:bad_ident" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq -c

## Failed password attempts
echo "Failed ssh or login attempts with incorrect password:"
grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq -c

