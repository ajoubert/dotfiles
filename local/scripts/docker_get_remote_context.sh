#!/bin/bash
docker context ls --format '{{if .Current}}{{if ne .Name "default"}}{{.Name}}{{end}}{{end}}' 2>/dev/null
