#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#* 	TITLE: RESET ORIGINAL FILENAME AND HASH  AND RENAME XMP TO .EXT.XMP
#! 	VERSION:  20260311.001
#* 	DESCRIPTION: OVERWRITES in XMP sidecar the tags  XMP-xmpMM:PreservedFileName,
#*  XMP-getty:OriginalFilename with current filename, renames sidecar to .ext.xmp
#*  and adds ONLY if missing  XMP:OriginalImageHash to XMP
#! 	STATUS: OK
# 	COMMENT: 
#######################################################################
# $_ZSTART_
# $_Z_SETTINGS_PROTO_
###############################################################################

## DESCRIPTION -----------------------------------------------------------------------------
-echo
'FORCE OVERWRITES SPECIFIC TAGS & SAVES SIDECAR TO EXT.XMP IF SIDECAR IS NAMED FILENAME.EXT.XMP'


-echo
'CREATES SIDECAR IF DOES NOT EXIST OR UPDATE IF IT DOES.'


-echo
'CANT RENAME FILE.XMP TO FILE.EXT.XMP IN THIS STEP DUE TO BUG IN SPECIFIC EXIFTOOL FLAG BUT I CANT REMEMEBER WHICH'
# TODO ID THIS BUG AGAIN LATER AND REPORT
#  -----------------------------------------------------------------------------

$_VERBOSE_
#  -----------------------------------------------------------------------------

$_EZ_SETTINGS_PROTO_
# * [[EZ_SETTINGS_PROTO]]  $_SUPRESSMINERR_,$_PRESERVE_, $_QUIET_, $_QUIET_, $_EXTLIST_, $_NOXMP_, $_GETTAGSFROMCURRENTFILE_, $_WRITEOVERFILE_
#  -----------------------------------------------------------------------------

$_FIXD_NAME_TEMPLATE_A_
#* $_FNAMESTART_$_SDATEFULL_$_IMAGESIZE_$_KEEPNAME_$_COUNTER_.$_EXT_
#  -----------------------------------------------------------------------------


$_SRCFILE_EXT_XMP_
$_SRCFILE_XMP_
#* LIST POSSIBLE SRCFILES, MULTIPLE OK, WORKS ON FIRST FOUND IIRC
#  -----------------------------------------------------------------------------


$_ADDTAG_PRESERVEDFILENAME_
$_ADDTAG_ORIGINALFILENAME_
#* 	OVERWRITE/ADDS XMP sidecar tags XMP-xmpMM:PreservedFileName, XMP-getty:OriginalFilename
#  -----------------------------------------------------------------------------


$_RECURSE_
$_EZ_SETTINGS_META_
#* [EZ_SETTINGS_META =  $_SRCDIR_, $_EXECUTE_]
#  -----------------------------------------------------------------------------







# ####################################################################
#~  ONLY RENAMES SIDECAR.XMP TO SIDECAR.EXT.XMP
# Tests: 
# No XMP, create OK!
# Name wrong, saves OK!
# ####################################################################

 

-echo
'RENAMES SIDECAR.XMP TO SIDECAR.EXT.XMP'
#  -----------------------------------------------------------------------------
$_VERBOSE_
#  -----------------------------------------------------------------------------
$_EZ_SETTINGS_PROTO_
# * [[EZ_SETTINGS_PROTO]]  $_SUPRESSMINERR_,$_PRESERVE_, $_QUIET_, $_QUIET_, $_EXTLIST_, $_NOXMP_, $_GETTAGSFROMCURRENTFILE_, $_WRITEOVERFILE_
#  -----------------------------------------------------------------------------
$_SRCFILE_XMP_
#* LIST POSSIBLE SRCFILES, MULTIPLE OK, WORKS ON FIRST FOUND IIRC
#  -----------------------------------------------------------------------------
$_FNAMESTART_$basename$_COUNTER_.$_EXT_.xmp
#  -----------------------------------------------------------------------------
$_RECURSE_
$_EZ_SETTINGS_META_
#* [EZ_SETTINGS_META =  $_SRCDIR_, $_EXECUTE_]
#  -----------------------------------------------------------------------------












# ####################################################################
#~ 
# Tests: 
#!  - No XMP, create OK!
#!  - Name wrong, saves OK!
#!  - # HRM...DOESNT SEEM TO CREATE A XMP IF MISSING.
 
#!  - 
# 
# 
# ####################################################################



#  -----------------------------------------------------------------------------
$_VERBOSE_
#  -----------------------------------------------------------------------------
$_EZ_SETTINGS_PROTO_
# * [[EZ_SETTINGS_PROTO]]  $_SUPRESSMINERR_,$_PRESERVE_, $_QUIET_, $_QUIET_, $_EXTLIST_, $_NOXMP_, $_GETTAGSFROMCURRENTFILE_, $_WRITEOVERFILE_
#  -----------------------------------------------------------------------------


$_SRCFILE_EXT_XMP_
$_SRCFILE_XMP_
#  -----------------------------------------------------------------------------
$_WRITEMODE_CREATE_INSERTMISSING_
#$_WRITEMODE_CREATE_INSERTMISSING_
# -wm cg to only create new tags (and avoid editing existing ones)


# The default write mode is wcg.

# w - Write existing tags
# c - Create new tags
# g - create new Groups as necessary
# For example, use -wm cg to only create new tags (and avoid editing existing ones).
#  -----------------------------------------------------------------------------
$_ADDTAG_IMAGEHASH_
#* ADD CHECKSUM IF MISSING
#  -----------------------------------------------------------------------------
-all
-all:all
-xmp:all
-exif:all
-composite:all
-quicktime:all
-iptc:all
-gps:all
#* ADD MISSING TAGS FROM EACH 
#  -----------------------------------------------------------------------------

#$_FNAMESTART_$basename$_COUNTER_.$_EXT_.xmp
#-o
#%d%f$_COUNTER_.%e.xmp



$_RECURSE_
$_EZ_SETTINGS_META_
#* [EZ_SETTINGS_META =  $_SRCDIR_, $_EXECUTE_]
#  -----------------------------------------------------------------------------