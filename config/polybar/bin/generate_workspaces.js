#!/bin/node

const fs = require('fs');
const path = require('path');
const workspacesFile = path.join(process.env.HOME, ".config/workspaces.json");

fs.readFile(workspacesFile, 'utf8', function(err, data) {
  if(err) {
    console.log(err);
    return;
  }

  JSON.parse(data) 
      .map((w, index) => (`ws-icon-${index} = "${w.name};${w.icon}"`))
      .forEach(r => {
        console.log(r);
      });
});

