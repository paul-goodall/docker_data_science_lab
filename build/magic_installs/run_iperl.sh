#!/usr/bin/env bash

/usr/local/bin/iperl notebook --no-browser --ip=0.0.0.0 --port=8890 --allow-root &
sleep 1
kill $(ps -ax | grep iperl | cut -d " " -f 2)