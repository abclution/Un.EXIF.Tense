#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: 0-00-WORKFLOW-01-TEMPLATE-STEP0-00-MOVE-NON-EXIF-FILES.argfile.sh
#! 	VERSION: 20260217.001
# 	DESCRIPTION: Moves files without EXIF data to a subdir.
#! 	STATUS: OK
# 	COMMENT:
###############################################################################

###############################################################################
###############################################################################
###############################################################################
# WORKFLOW 1 - STEP -1 LOL - MOVE NON EXIF FILES OUT OF THE WAY 
###############################################################################
###############################################################################
###############################################################################

$_vKEY04_
# Verbose

-m
# IGNORE MINOR ERRORS (CAN CHANGE THE SORTING/DESTINATION FOLDER IF TAGS WERE SKIPPED WITHOUT THIS)

$_vKEY06_
# (-P / -preserve) Preserve file modification date/time

$_vKEY05_
# Quieter output, put twice for very quiet. shhbbyisok

#$_vKEY07_
# WORK ON THESE FILES Extensions list

--ext
xmp
# DO NOT WORK ON XMP FILES

-tagsfromfile
@

#-all
# -if 'not $exif:all' -Filename=$SRCDIR/NOEXIF/%f%+3c.%e  $SRCDIR
-if 
not $all
#not $exif:all

$_vFILE01_/$_vFILE02____$basename$_vFILE09_.$_vFILE10_
# # FILENAME TEMPLATE (NOTICE ADDED.XMP AT THE END)
$_vTAG01_$_vFILE10_/$_vDIR03_$_vDIR02_
# # DIRECTORY TEMPLATE


# -Filename=$_vKEY02_/$SRCDIR/NOEXIF/%f%+3c.%e  $SRCDIR
# -Filename=$SRCDIR/NOEXIF/%f%+3c.%e  $SRCDIR
# -filename<$basename%+3c.%e.xmp
# # OUTPUT FILENAME

# -filename<$basename%+3c.%e
# # OUTPUT FILENAME

$_vKEY03_
# Recurse. If recurse switch set, this will be -r, otherwise null/empty.

$_vKEY01_
# SOURCE DIRECTORY: INPUT directory containing unprocessed media."

-execute
# RUN EVERYTHING UP TO THIS POINT AS A SPECIFIC COMMANDSET.

