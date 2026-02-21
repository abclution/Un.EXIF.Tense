#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: TEMPLATE_S01-P02_CREATE.XMP.argfile.sh
#! 	VERSION: 20260219.001
# 	DESCRIPTION:
#! 	STATUS: OK
# 	COMMENT:
###############################################################################

###############################################################################
#0 Rename sidecars that are of style imagename.xmp to imagename.ext.xmp
#1 Generate XMP
#2 MOVE XMP
#3 MOVE MEDIA

# 1 WORKIN CONFIG FOR XMP CREATION
# Fills in the blanks, does not overwrite existing.
# Hash generation is only for cerrtain filetypes
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

#-srcfile
#%d%f.%e.xmp

$_SRCFILE_EXT_XMP_


-overwrite_original

$_GETTAGSFROMCURRENTFILE_

$_ADDTAG_PRESERVEDFILENAME_

$_ADDTAG_IMAGEHASH_

-all

$_RECURSE_

# Recurse. If recurse switch set, this will be -r, otherwise null/empty.

$_SRCDIR_
# SOURCE DIRECTORY: INPUT directory containing unprocessed media."

-execute


