#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: TEMPLATE_S01-P03_MOVE-RENAME-XMPSIDECARS.argfile.sh
#! 	VERSION: 20260219.001
# 	DESCRIPTION: Renames/moves sidecars
#! 	STATUS: OK
# 	COMMENT:
###############################################################################

###############################################################################
###############################################################################
###############################################################################
#  WORKFLOW 1 - STEP 3 - RENAME / MOVE XMP SIDECARS TO DESTINATION.
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

$_SRCFILE_EXT_XMP_
#srcfile
#%d%f.%e.xmp
# WORK ON THESE XMP FILES NAMED AS THE IMAGES YOU FIND VIA FOLLOWING THE EXT LIST.



$_GETTAGSFROMCURRENTFILE_
# GET THE TAGS FROM THE CURRENT MEDIA FILE

$_FNAMESTART_$_SDATEFULL_$_IMAGESIZE_$_KEEPNAME_$_COUNTER_.$_EXT_.xmp


#$_vDIR01_$_vDIR03_/$_vTAG02_$_vTAG04_$_vTAG05_$_vTAG07_$_vTAG08_$_vTAG12_
$_DIRSTART_$_DSTDIR_/$_YEAR_/$_YEARMONTH_$_MAKE_$_ANDROIDMANUFACTURER_$_MODEL_$_ANDROIDMODEL_$_XIAOMIPRODUCTNAME_
# DIRECTORY TEMPLATE

$_RECURSE_
# Recurse. If recurse switch set, this will be -r, otherwise null/empty.

$_SRCDIR_
# SOURCE DIRECTORY: INPUT directory containing unprocessed media."

-execute
# RUN EVERYTHING UP TO THIS POINT AS A SPECIFIC COMMANDSET.


####################################################################################################
####################################################################################################
####################################################################################################
