#!/bin/bash
echo -n "Copying configuration file at /etc/systemd/system/docker.service.d/startup_options.conf... "
cp /etc/systemd/system/docker.service.d/startup_options.conf.disableremote /etc/systemd/system/docker.service.d/startup_options.conf
echo "Ok!"
echo -n "Reloading systemctl daemon... "
systemctl daemon-reload
echo "Ok!"
echo -n "Restarting docker process... "
systemctl restart docker
echo "Ok!"
echo "All done"
