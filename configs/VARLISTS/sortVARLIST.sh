#!/bin/bash
SRC_LIST="./VARLIST"
SORTED_LIST="./VARLIST.SORTED"

# SEGMENT HEADER FROM SORT
cat ${SRC_LIST} | grep -si "#!\|#shellcheck" >${SORTED_LIST}
# SORT THE REST AND APPEND
cat ${SRC_LIST} | grep -siv "#!\|#shellcheck" | LC_ALL=C sort -u >>${SORTED_LIST}
