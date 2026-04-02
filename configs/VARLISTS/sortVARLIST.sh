#!/bin/bash
cat ./VARLIST |grep -siv "#!" | LC_ALL=C sort -u -o ./VARLIST.SORTED