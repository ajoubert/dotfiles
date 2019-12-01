#!/bin/bash
echo -n "Copying configuration file to /etc/systemd/system/docker.service.d/startup_options.conf... "
cp /etc/systemd/system/docker.service.d/startup_options.conf.enableremote /etc/systemd/system/docker.service.d/startup_options.conf
echo "Ok!"
echo -n "Reloading systemctl daemon... "
systemctl daemon-reload
echo "Ok!"
echo -n "Restarting docker..."
systemctl restart docker
echo "Ok!"
echo "All done"
