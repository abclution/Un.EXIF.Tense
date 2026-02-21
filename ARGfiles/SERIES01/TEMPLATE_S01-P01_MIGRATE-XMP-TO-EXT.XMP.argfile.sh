#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: TEMPLATE_S01-P01_MIGRATE-XMP-TO-EXT.XMP.argfile.sh
#! 	VERSION:  20260219.001
# 	DESCRIPTION: Renames image.xmp files to image.ext.xmp adds hash + origin filename
#! 	STATUS: OK
# 	COMMENT: This causes errors for files missing xmp
###############################################################################

###############################################################################
###############################################################################
###############################################################################
# WORKFLOW 1 - STEP 0 - RENAME EXISTING SIDECARS FROM IMAGE.XMP TO IMAGE.EXT.XMP
# DOES NOT CREATE MISSING XMP SIDECARS
###############################################################################
###############################################################################
###############################################################################

$_VERBOSE_
# Verbose

$_SUPRESSMINERR_
# IGNORE MINOR ERRORS (CAN CHANGE THE SORTING/DESTINATION FOLDER IF TAGS WERE SKIPPED WITHOUT THIS)

$_PRESERVE_
# (-P / -preserve) Preserve file modification date/time

$_QUIET_
$_QUIET_
# Quieter output, put twice for very quiet. shhbbyisok

$_EXTLIST_
# WORK ON THESE FILES Extensions list

$_NOXMP_
# DO NOT WORK ON XMP FILES

$_WRITEMODE_CREATE_INSERTMISSING_
# write mode CREATE AND ADD ONLY NEW TAGS

$_SRCFILE_XMP_
#-srcfile\n%d%f.xmp
# DIRECT ACTIONS TO THIS FILE INSTEAD OF CURRENT FILE

-overwrite_original


$_GETTAGSFROMCURRENTFILE_

$_ADDTAG_PRESERVEDFILENAME_

$_ADDTAG_IMAGEHASH_

-all

#-filename<$basename%+3c.%e.xmp
$_FNAMESTART_$basename$_COUNTER_$_EXT_.xmp
# OUTPUT FILENAME

$_RECURSE_
# Recurse. If recurse switch set, this will be -r, otherwise null/empty.

$_SRCDIR_
# SOURCE DIRECTORY: INPUT directory containing unprocessed media."

-execute
# RUN EVERYTHING UP TO THIS POINT AS A SPECIFIC COMMANDSET.

#-------------------------------------------------------------------------------
