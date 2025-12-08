#!/usr/bin/env bash

MAX_DESKTOPS=20

WORKSPACES=$(seq -s '\n' 1 1 ${MAX_DESKTOPS})

EMPTY_WORKSPACE=$( ($I3_MSG -t get_workspaces | tr ',' '\n' | grep num | awk -F:  '{print int($2)}' ; \
            echo -e ${WORKSPACES} ) | sort -n | uniq -u | head -n 1)

$I3_MSG workspace ${EMPTY_WORKSPACE}
