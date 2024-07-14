#!/bin/bash
cd /home/container

# Output Current Version 
yarn astro --info ## only really needed to show what version is being used. Should be changed for different applications

# Replace Startup Variables
MODIFIED_STARTUP=/bin/bash

# Run the Server
${MODIFIED_STARTUP}
