#!/bin/bash
script_Path="$(dirname "$0")"

#un.exiftense.sh -c "un.exiftense.config.S04" $@
un.exiftense.sh -c "configs/un.exiftense.config.S04" -s ./in -d ./out $@


