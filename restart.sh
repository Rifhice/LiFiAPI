#!/bin/bash

sudo kill -9 $(pgrep -f "node index.js")
node index.js &
