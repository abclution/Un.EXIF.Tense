#!/bin/bash
# shellcheck disable=all
# exiftool argfile
###############################################################################
#! 	TITLE: TEMPLATE_S01-P03_MOVE-RENAME-XMPSIDECARS.argfile.sh
#! 	VERSION:  20260222.001
# 	DESCRIPTION: Renames/moves sidecars
#! 	STATUS: OK
# 	COMMENT:
###############################################################################
###############################################################################
# $_ADDTAG_IMAGEHASH_                    [ -api ImageHashType=SHA512 -XMP:OriginalImageHash<ImageDataHash ]
# $_ADDTAG_IMAGEHASHdesc_                [ #* Creates imagehash tag. ]
# $_ADDTAG_PRESERVEDFILENAMEdesc_        [ #* Adds the PreservedFileName tag. ]
# $_ADDTAG_PRESERVEDFILENAME_            [ -XMP-xmpMM:PreservedFileName<filename ]
# $_ANDROIDMANUFACTURER_                 [ ${Keys:AndroidManufacturer;$_="[$_]"} ]
# $_ANDROIDMANUFACTURERdesc_             [ #* Manufacturer ]
# $_ANDROIDMODEL_                        [ ${Keys:AndroidModel;$_="[$_]"} ]
# $_ANDROIDMODELdesc_                    [ #* Model of android phone. ]
# $_COUNTER_                             [ %+3c ]
# $_COUNTERdesc_                         [ #* Counter (Filename collision avoidance.) ]
# $_DDATEFORMATdesc_                     [ #* (Prefer per dir option) -d/-dateFormat - Format for date/time values ]
# $_DDATEFORMAT_                         [ -d %Y-%m-%d_%H.%M.%S__ ]
# $_DIRSTARTdesc_                        [ #* Directory output destination start command. ]
# $_DIRSTART_                            [ -Directory< ]
# $_DSTDIRdesc_                          [ #* DESTINATION DIRECTORY: OUTPUT directory for processed and renamed images ]
# $_DSTDIR_                              [ /zpool_20tb/eVAULT/GALLERY/zTESTFILES/TEST_OUT ]
# $_EXTdesc_                             [ #* File Extension ]
# $_EXT_                                 [ %e ]
# $_EXTLISTdesc_                         [ #* Extensions to work on ]
# $_EXTLIST_                             [ -ext mov -ext mp4 -ext mpg -ext 3gp -ext wmv -ext webm -ext avi -ext m4v -ext webp -ext dng -ext jpg -ext heic -ext png -ext gif -ext bmp -ext tiff ...
# $_FILEORDERFILENAMEdesc_               [ #* Process in order of filename. Slow, dont use if possible. ]
# $_FILEORDERFILENAME_                   [ -fileOrder -FileName ]
# $_FNAMESTARTdesc_                      [ #* Rename/move starting with SmartDate function included in the config that came with this script. ]
# $_FNAMESTART_                          [ -filename< ]
# $_GETTAGSFROMCURRENTFILEdesc_          [ #* GETS / SETS TAGS FROM CURRENT FILE  ]
# $_GETTAGSFROMCURRENTFILE_              [ -tagsfromfile @ ]
# $_HASHALGORITHMdesc_                   [ #* Algorithm for creating the XMP:OriginalImageHash tag. ]
# $_HASHALGORITHM_                       [ SHA512 ]
# $_IMAGESIZE_                           [ ${ImageSize;$_="[$_]"} ]
# $_IMAGESIZEdesc_                       [ #* Image Size composite tag ]
# $_KEEPNAME_                            [  ]
# $_KEEPNAMEdesc_                        [  ]
# $_MAKE_                                [ ${Make;$_="[$_]"} ]
# $_MAKEdesc_                            [ #* Make of Android phone tag. ]
# $_MODEL_                               [ ${Model;$_="[$_]"} ]
# $_MODELdesc_                           [ #* Model of camera/phone ]
# $_NOEXIFDESTdesc_                      [ #* FOLDER NAME FOR NOEXIF DESTINATION DIRECTORY: OUTPUT directory for items without EXIF. ]
# $_NOEXIFDEST_                          [ NO-EXIF ]
# $_NOXMPdesc_                           [ #* DO NOT WORK ON XMP FILES # Don't process xmp files, strangely enough used mostly to process xmp files.. lol..  ]
# $_NOXMP_                               [ --ext xmp ]
# $_PRESERVEdesc_                        [ #* (-P / -preserve) Preserve file modification date/time ]
# $_PRESERVE_                            [ -P ]
# $_QUIETdesc_                           [ #* Quieter output, put twice for very quiet. shhbbyisok ]
# $_QUIET_                               [ -q ]
# $_RECURSEdesc_                         [ #* Recurse. If recurse switch set, this will be -r, otherwise null/empty.  ]
# $_RECURSE_                             [ -r ]
# $_SDATEFULL_                           [ ${SmartDate;DateFmt("%Y-%m-%d_%H.%M.%S__")} ]
# $_SDATEFULLdesc_                       [ #* 2020-10-02_14.01.31__ SmartDate full output, used for filename usually. ]
# $_SHHBBYISOKdesc_                      [ #* -m -q -q Supress minor errors and super quiet shortcut tag. ]
# $_SHHBBYISOK_                          [ -m -q -q ]
# $_SRCDIRdesc_                          [ #* SOURCE DIRECTORY: INPUT directory containing unprocessed media. ]
# $_SRCDIR_                              [ /zpool_20tb/eVAULT/GALLERY/zTESTFILES/TEST_IN ]
# $_SRCFILE_EXT_XMPdesc_                 [ #* DIRECT ACTIONS TO FILENAME.EXT.XMP THIS FILE INSTEAD OF CURRENT FILE ]
# $_SRCFILE_EXT_XMP_                     [ -srcfile %d%f.%e.xmp ]
# $_SRCFILE_XMPdesc_                     [ #* DIRECT ACTIONS TO FILENAME.XMP THIS FILE INSTEAD OF CURRENT FILE ]
# $_SRCFILE_XMP_                         [ -srcfile %d%f.xmp ]
# $_SUPRESSMINERRdesc_                   [ #* Suppress minor errors, if used, must be used equally (or none) on XMP + media argfiles. Otherwise problems. ]
# $_SUPRESSMINERR_                       [ -m ]
# $_VERBOSE_                             [  ]
# $_VERBOSEdesc_                         [ #* When verbose switch set, this will be -v[0...5], 5 being most verbose. Set by VLevel ]
# $_WRITEMODE_CREATE_INSERTMISSINGdesc_  [ #* write mode CREATE AND ADD ONLY NEW TAGS  ]
# $_WRITEMODE_CREATE_INSERTMISSING_      [ -wm cg ]
# $_XIAOMIPRODUCTNAME_                   [ ${Keys:XiaomiProductMarketname;$_="[$_]"} ]
# $_XIAOMIPRODUCTNAMEdesc_               [ #* Phone name tag from Xiaomi ]
# $_YEAR_                                [ ${SmartDate;DateFmt("%Y")} ]
# $_YEARdesc_                            [ #* YEAR Folder ]
# $_YEARMONTH_                           [ ${SmartDate;DateFmt("%Y.%m-[%B]")} ]
# $_YEARMONTHdesc_                       [ #* SmartDate function located in config ]
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
