#!/bin/bash

gcc -Q --help=warning | sed -e 's/^\s*\(\-\S*\)\s*\[\w*\]/\1 /gp;d' | tr -d '\n'
