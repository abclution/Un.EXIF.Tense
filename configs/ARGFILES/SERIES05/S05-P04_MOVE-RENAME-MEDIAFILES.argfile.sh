#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: 04-WORKFLOW-01-TEMPLATE-STEP04_MOVE-RENAME-MEDIAFILES.argfile
#! 	VERSION:  20260222.001
# 	DESCRIPTION: Renames/moves media files.
#! 	STATUS: OK
# 	COMMENT: 
###############################################################################
###############################################################################
###############################################################################
###############################################################################
# WORKFLOW 1 - STEP 4 - RENAME / MOVE MEDIA FILES TO DESTINATION.
###############################################################################
###############################################################################
###############################################################################

# $_VERBOSE_
# # Verbose

# $_SUPRESSMINERR_
# # IGNORE MINOR ERRORS (CAN CHANGE THE SORTING/DESTINATION FOLDER IF TAGS WERE SKIPPED WITHOUT THIS)

# $_PRESERVE_
# # (-P / -preserve) Preserve file modification date/time

# $_QUIET_
# $_QUIET_
# # Quieter output, put twice for very quiet. shhbbyisok

# $_EXTLIST_
# # WORK ON THESE FILES Extensions list


#-------------------------------------------------------------------------------
$_EZ_SETTINGS_PROTO_
# EZ_SETTINGS_PROTO=$_VERBOSE_, $_SUPRESSMINERR_,$_PRESERVE_, $_QUIET_, $_QUIET_, $_EXTLIST_, $_NOXMP_, $_GETTAGSFROMCURRENTFILE_, $_WRITEOVERFILE_
#-------------------------------------------------------------------------------

#$_FNAMESTART_$_SDATEFULL_$_IMAGESIZE_$_KEEPNAME_$_COUNTER_.$_EXT_
$_FNAMESTART_BaseName$_COUNTER_.$_EXT_


#$_vDIR01_$_vDIR03_/$_vTAG02_$_vTAG04_$_vTAG05_$_vTAG07_$_vTAG08_$_vTAG12_
#$_DIRSTART_$_DSTDIR_/$_EXT_/$_YEAR_/$_YEARMONTH_$_MAKE_$_ANDROIDMANUFACTURER_$_MODEL_$_ANDROIDMODEL_$_XIAOMIPRODUCTNAME_
#$_DIRSTART_$_DSTDIR_/$_EXT_/$_YEARMONTH_$_MAKE_$_ANDROIDMANUFACTURER_$_MODEL_$_ANDROIDMODEL_$_XIAOMIPRODUCTNAME_
# $_DIRSTART_$_DSTDIR_/$_MAKE_$_ANDROIDMANUFACTURER_$_MODEL_$_ANDROIDMODEL_$_XIAOMIPRODUCTNAME_/$_EXT_/$_YEARMONTH_
$_FIXD_DIR_TEMPLATE_A_
# # DIRECTORY TEMPLATE

# $_RECURSE_
# # Recurse. If recurse switch set, this will be -r, otherwise null/empty.

# $_SRCDIR_
# # SOURCE DIRECTORY: INPUT directory containing unprocessed media."

# -execute
# # RUN EVERYTHING UP TO THIS POINT AS A SPECIFIC COMMANDSET.

####################################################################################################
####################################################################################################
####################################################################################################



#-------------------------------------------------------------------------------
$_EZ_SETTINGS_META_
# EZ_SETTINGS_META=$_RECURSE_, $_SRCDIR_, $_EXECUTE_
#-------------------------------------------------------------------------------



