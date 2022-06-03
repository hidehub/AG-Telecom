#!/bin/bash

nosend=true           

while true

do

status=$(curl -s -o /dev/null -w "%{http_code}" 'domain.name')

if echo "$status" | grep  "^2" || echo "$status" | grep  "^3"; then

  nosend=true

elif $nosend; then

  echo "service is unavailable" | mail -s "domain.name" you@mail.com

  nosend=false

fi

done