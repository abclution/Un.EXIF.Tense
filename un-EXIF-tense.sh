#!/bin/bash
# shellcheck disable=SC2016
# Version: 1.0 Public Release, v7.2 Internal
###############################################################################

setDefaults() {

	###############################################################################
	#* USER FACING VARIABLES ######################################################
	#* YOU CAN SET DEFAULT OPTIONS FOR COMMAND LINE SWITCHES BELOW
	###############################################################################
	_SRCDIR_=""
	_DSTDIR_=""
	_hashALGO_="SHA512"
	_XMPFunction_="True"
	_RECURSE_="True"
	_QT_UTC_=0
	_KEEPName_="True"
	_TESTMODE_="False"
	_TESTMODERESET_="False"
	_VIDEOS_="True"
	_PHOTOS_="True"
	###############################################################################
	
	
	###############################################################################
	#* USER CONFIG: EXTENSION LISTS FOR TYPES OF FILES YOU WANT THIS SCRIPT TO DEAL WITH
	###############################################################################
	#! PHOTO EXTENSION LIST
	declare -g -a EXTList_Photos=("webp" "dng" "jpg" "heic" "png" "gif" "bmp" "tiff" "tif")

	#! VIDEO EXTENSION LIST
	declare -g -a EXTList_Videos=("mov" "mp4" "mpg" "3gp" "wmv" "webm" "avi" "m4v")
	###############################################################################
	
	
	###############################################################################
	#* USER CONFIG: VERBOSITY AND DEBUG MISC OPTIONS
	###############################################################################
	_DEBUG_="False"
	_VERBOSE_="False"
	vLVL=0 # Verbosity level for exiftool when set to true.
	# Verbose overrides quiet mode, Verbose 0 exiftool prints current filename only.

	#! DEBUG SLEEP TIMER, TIME BETWEEN COMMANDS TO DEBUG ONSCREEN INFO
	# Can also be "wait" to wait for keypress
	#sTIMER="wait"
	sTIMER="2"
	###############################################################################
	
		
	###############################################################################
	#* USER CONFIG: EXIFTOOL SETTINGS
	###############################################################################
	# IF PRESENT IN YOUR PATH, SIMPLY LIST AS "exiftool"
	exiftoolPATH="/usr/bin/exiftool"
	exiftoolCONFIG="./exiftool_config_Un.EXIF.Tense"
	# WHEN USING KEEPING NAME OPTION, CAN USE THIS AS A SEPERATOR, TEMPLATE DEPENDENT
	exifToolBaseNameSeperator="___"
	#/home/andreas/.ExifTool_config.REFACTORED.V5"
	#/fixd-toolkit/scripts/scripts.FILE-ORGANIZATION/_ORGANIZE-MyPHOTOS/In-DevelopmentProgress/EXIFToolConfigs/.ExifTool_config.REFACTORED.V8"
	###############################################################################
	
	
	###############################################################################
	#* USER CONFIG: ARGFILES CONFIGURATION SETTINGS
	###############################################################################
	#! BASE PATH TO ARGFILE TEMPLATES
	ARGFiles_PATH="./ARGfiles/SERIES01"
	###############################################################################
	# ARGFILE TEMPLATE NAMES (FILENAMES)
	# List of argfile filenames in ARGFiles_PATH to run in the order you wish to run them.
	# Can be formatted like this, all in one declaration, or one by one, or a mix.
	#! declare -a TESTMODEARGFileTemplatesList=("TEMPLATE-01" "TEMPLATE-02")
	# INIT BLANK ARRAY
	declare -g -a ARGFileTemplatesList=()
	ARGFileTemplatesList+=("TEMPLATE_S01-P01_MIGRATE-XMP-TO-EXT.XMP.argfile.sh")
	ARGFileTemplatesList+=("TEMPLATE_S01-P02_CREATE.XMP.argfile.sh")
	ARGFileTemplatesList+=("TEMPLATE_S01-P03_MOVE-RENAME-XMPSIDECARS.argfile.sh")
	ARGFileTemplatesList+=("TEMPLATE_S01-P04_MOVE-RENAME-MEDIAFILES.argfile.sh")
	#ARGFileTemplatesList+=("")
	#echo -e "Templates active:${ARGFileTemplatesList[@]}\n"
	# TODO ADD FILE EXISTENCE CHECK FOR TEMPLATES
	###############################################################################
	
	
	
	###############################################################################
	#* USER CONFIG: TESTMODE CONFIGURATION
	###############################################################################
	# Alternate list of argfile templates to be used in TESTMODE.
	declare -g -a TESTMODEARGFileTemplatesList=()
	TESTMODEARGFileTemplatesList+=("TEMPLATE_S01-P01_MIGRATE-XMP-TO-EXT.XMP.argfile.sh")
	TESTMODEARGFileTemplatesList+=("TEMPLATE_S01-P02_CREATE.XMP.argfile.sh")
	TESTMODEARGFileTemplatesList+=("TEMPLATE_S01-P03_MOVE-RENAME-XMPSIDECARS.argfile.sh")
	TESTMODEARGFileTemplatesList+=("TEMPLATE_S01-P04_MOVE-RENAME-MEDIAFILES.argfile.sh")
	
	#echo -e "Templates active for TESTMODE (if active): ${TESTMODEARGFileTemplatesList[@]} \n"

	###############################################################################
	# TESTMODE FOLDERS AND PATHS
	# THESE ARE RELEVENT WHEN -t (testmode) or -T switch (testmode reset) is enabled.
		
	# Define folders for test mode usage.
	# DATA The folder containing the original media that is copied to the IN dir.
	TESTMODE_data="/my/mediafiles"
	# IN is where photos and vids will be copied and processed.
	TESTMODE_in="/tmp/IN"
	# OUT is destination after processing.
	TESTMODE_out="/tmp/OUT"
	###############################################################################
	###############################################################################

	prepInternalSettings() {
		# Initialization of some default stuff used later.

		# Anticlobber for exporting shell variables
		RndStr=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 4)
		exifToolCMD="$exiftoolPATH -config $exiftoolCONFIG "

		if [[ "$_VIDEOS_" == "True" ]]; then
			for VIDfmt in "${EXTList_Videos[@]}"; do
				_EXTList_+="-ext"$'\n'"$VIDfmt"$'\n'
			done
		fi

		if [[ "$_PHOTOS_" == "True" ]]; then
			for IMGfmt in "${EXTList_Photos[@]}"; do
				_EXTList_+="-ext"$'\n'"$IMGfmt"$'\n'
			done
		fi
	}
	prepInternalSettings

}

# EZ DEBUG FUNCTION, TAKES 4 ARGS THAT ARE EVALUATED AND SLEEPS AT THE END OF EACH CALL
DEEBUG() {
	
	if [[ "$_DEBUG_" == "True" ]]; then

		local dbugCMD01="$1"
		local dbugCMD02="$2"
		local dbugCMD03="$3"
		local dbugCMD04="$4"
		local dbugCMD05="$5"
		local dbugCMD06="$6"
		local dbugCMD07="$7"
		local dbugCMD08="$8"

		echo -e "\n ########################## DEBUG INFO ########################################### \n"
		# echo -e "\n $1 $2 $3 $4 \n"
		eval "$dbugCMD01"
		eval "$dbugCMD02"
		eval "$dbugCMD03"
		eval "$dbugCMD04"
		eval "$dbugCMD05"
		eval "$dbugCMD06"
		eval "$dbugCMD07"
		eval "$dbugCMD08"

		echo -e "\n ########################## DEBUG INFO ########################################### \n"

		if [[ "$sTIMER" == "wait" ]]; then
			echo -e "\n\n"
			read -r -p "DEBUG: Press return to continue."
		else
			sleep $sTIMER
		fi	
		

	fi
}


#* INIT DEFAULT SETTINGS
setDefaults


###############################################################################
#* #### START OF FUNCTION DEFINITIONS  ##########################################
#! BEYOND THIS POINT, THERE BE DRAGONS and DAMSELS....... AND MORE CODE
###############################################################################



###############################################################################
#! PRINTS PROGRAM SETTINGS DURING A RUN
###############################################################################
settingsReport() {

	echo -e "
	TESTMODE: 		$_TESTMODE_		RESET ENABLED?		$_TESTMODERESET_
	VERBOSE: 		$_VERBOSE_ 		VERBOSITY LEVEL:	$vLVL
	DEBUG:  		$_DEBUG_		DEBUG SLEEP TIMER:	$sTIMER
	
	SOURCE DIR:		$_SRCDIR_		DESTINATION. DIR:	$_DSTDIR_
	_RECURSE_ = 	$_RECURSE_
	
	XMP SIDECAR:	$_XMPFunction_	XMP HASH ALGO:		$_hashALGO_
	
	PROCESS MEDIA FILES
	PHOTOS:			$_PHOTOS_		VIDEOS:				$_VIDEOS_
	
	KEEP ORIGINAL							BASENAME
	FILENAME AS SUFFIX:		$_KEEPName_	 	SEPERATOR: $exifToolBaseNameSeperator 
	
	QUICKTIME UTC:	$_QT_UTC_
	
    MEDIA FILE EXTENSIONS AVAILIABLE TO PROCESS
	PHOTOS: ${EXTList_Photos[*]}
	VIDEOS: ${EXTList_Videos[*]}
	
	EXIFTOOL INFO
	BINARY PATH: 		$exiftoolPATH
	CONFIG LOCATION: 	$exiftoolCONFIG
	BASE COMMAND: 		$exifToolCMD 

	ARGFILE TEMPLATES
	LOCATION / PATH:	$ARGFiles_PATH
	TEMPLATE NAMES:		${ARGFileTemplatesList[*]} \n

	TESTMODE FOLDERS
	DATA SOURCE: 		$TESTMODE_data	(IF TESTMODE RESET ENABLED, IN & OUT
	IN FOLDER:			$TESTMODE_in  	 FOLDER CONTENTS ARE DELETED EACH RUN!!!)
	OUT FOLDER:			$TESTMODE_out
	TESTMODE TEMPLATES: ${TESTMODEARGFileTemplatesList[*]}\n

	RANDOM STRING FOR THIS RUN: $RndStr

"
}
###############################################################################



###############################################################################
#! PRINTS PROGRAM HELP WHEN CALLED OR WHEN ERROR OCCURS WITH INITIAL SWITCHES
###############################################################################
showHELP() {
	###############################################################################
	# --- Usage Function ---
	###############################################################################
	echo "Usage: $(basename "$0") [OPTIONS]"
	echo "Script to rename PHOTOS & VIDEOS & XMP sidecar files based on EXIF/XMP metadata."
	echo "XMP Sidecar stores both the original filename and hash checksum for posterity."
	echo ""
	echo "Options:              *Required"
	echo "  -s <directory>      *Source of media folder (default: $_SRCDIR_)"
	echo "  -d <directory>      *Sorted/Output folder, created automatically if needed. (default: $_DSTDIR_)"
	echo "  -k <boolean>        Keep original filename suffixed to new file name (default: $_KEEPName_)"
	echo "  -r <boolean>        Enable/disable recursive processing of source media dir. (default: $_RECURSE_)"
	echo "  -w <boolean>        Enable/disable processing of videos. (default: $_VIDEOS_)"
	echo "  -x <boolean>        Enable XMP update/creation with has + original filename (default: $_XMPFunction_)"
	echo "  -m <string>         Choose hashing function: 'MD5', 'SHA256' or 'SHA512' (default: $_hashALGO_)"
	echo "  -q <number 0 or 1>  Set QuickTime UTC (default: $_QT_UTC_)"
	echo "  -v <boolean>        Enable verbose mode for exiftool (default: $_VERBOSE_)"
	echo "  -t <boolean>        Enables test functions (default: $_TESTMODE_)"
	echo "  -T <boolean>        Enables test functions & RESETS TESTING data. (Set dirs in script.) (default: $_TESTMODERESET_)"
	echo "  -D <boolean>        Enable debug. Very verbose output from script actions: $_DEBUG_)"
	echo "  -h                  Display this help message"
	echo -e "\n\n\n"
	exit 1

}
###############################################################################

###############################################################################
###############################################################################
#! VALIDATES SWITCHES AND THEIR NEEDED DATA TYPES BEFORE PROGRAM MAIN LOOP
###############################################################################
optionsMenuSetup() {

	###############################################################################
	# --- Command Line switches handler ---
	###############################################################################
	# --- Process Switches ---
	# Use getopts to parse command-line options.
	# The colon after mq'o' and 'r' indicates that these options require an argument.
	# The leading colon enables silent error reporting by getopts, allowing custom error handling.
	while getopts ":s:d:k:r:w:x:m:q:v:t:T:h:D:" opt; do
		case $opt in
		s)
			# Validate if the argument is a directory that exists
			if [ ! -d "$OPTARG" ]; then
				echo "Error: Source directory '$OPTARG' not found or is not a directory." >&2
				showHELP
			fi
			_SRCDIR_="$OPTARG"
			;;
		d)
			_DSTDIR_="$OPTARG"
			;;
		k)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -k requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_KEEPName_="$OPTARG"
			;;
		r)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -r requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_RECURSE_="$OPTARG"
			;;
		x)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -x requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_XMPFunction_="$OPTARG"
			;;
		m)
			# Validate if the argument matches from list options.
			if [[ "$OPTARG" != "MD5" && "$OPTARG" != "SHA256" && "$OPTARG" != "SHA512" ]]; then
				echo "Error: -m requires one of the following (MD5, SHA256, SHA512)." >&2
				showHELP
			fi
			_hashALGO_="$OPTARG"
			;;

		q)
			# Validate if the argument is a number
			if ! [[ "$OPTARG" =~ ^[0-1]+$ ]]; then
				echo "Error: -q requires a numeric argument of 1 or 0." >&2
				showHELP
			fi
			_QT_UTC_="$OPTARG"
			;;
		w)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -w requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_VIDEOS_="$OPTARG"
			;;
		v)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -v requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_VERBOSE_="$OPTARG"
			;;
		D)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -D requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_DEBUG_="$OPTARG"
			;;
		t)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -t requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_TESTMODE_="$OPTARG"
			;;
		T)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -T requires a boolean argument (True or False)." >&2
				showHELP
			fi
			_TESTMODERESET_="$OPTARG"
			;;
		h)
			showHELP
			;;
		\?)
			# Handle invalid options
			echo "Error: Invalid option -$OPTARG." >&2
			showHELP
			;;
		:)
			# Handle options requiring an argument but none provided
			echo "Error: Option -$OPTARG requires an argument." >&2
			showHELP
			;;
		esac
	done

	# Shift off the options processed by getopts so that "$@" refers to non-option arguments.
	shift $((OPTIND - 1))

	if [[ -n "$1" || -n "$2" ]]; then
		# If there are any non-option arguments, treat them as source and destination directories.
		_SRCDIR_="$1"
		_DSTDIR_="$2"
	fi

	if [[ -z "$_SRCDIR_" || -z "$_DSTDIR_" ]]; then
		showHELP
	fi

	if [[ "$1" == "-h" || "$1" == "--help" || "$2" == "-h" || "$2" == "--help" || "$3" == "-h" || "$3" == "--help" ]]; then
		showHELP
	fi

	# Replace Boolean with string/blank reuse variable.
	if [[ "$_RECURSE_" == "False" ]]; then
		_RECURSE_=""
	else
		_RECURSE_="-r"
	fi


	DEEBUG \
		'echo -e "\nCHECKPOINT: optionsMenuSetup \n"' \
		'echo -e "NOTICE: User passed enough correct switches to continue.\n"'




}
optionsMenuSetup "$@"

###############################################################################
###############################################################################
#! TESTMODE VALIDATION: CHECK SETTINGS TO ENSURE CORRECT FILE OPERATION 
###############################################################################
	setupTESTMODE () {
		#* ENSURE TEST MODE IS A REQUIREMENT OF RUNNING THE RESET SWITCH.
		if [[ "$_TESTMODERESET_" == "True" ]]; then
			_TESTMODE_="True"
		fi

		#* BOTH A SAFETY AND TO AVOID REWRITING SOURCE AND DEST ON FUNCTIONS DEALING 
		#* WITH THE DATA DURING TESTMODE
		if [[ "$_TESTMODE_" == "True" ]]; then
			_SRCDIR_="$TESTMODE_in"
			_DSTDIR_="$TESTMODE_out"
		fi
	
		DEEBUG \
			'echo -e "\nCHECKPOINT: setupTESTMODE TESTMODE VALIDATION\n"' \
			'echo -e "_SRCDIR_ 		 		$_SRCDIR_  \n_TESTMODE_in				$TESTMODE_in \n should have equal value\n\n"'\
			'echo -e "_DSTDIR_ 		 		$_DSTDIR_  \n_TESTMODE_out				$TESTMODE_out \n should have equal value\n\n"'\
	
	
	}
	setupTESTMODE



###############################################################################
###############################################################################
#! ALL VARIABLES, SUBSTITUTIONS AND SWITCHES WE WISH TO PROGRAMMATICALLY USE
#! IN THE ARGUMENT FILE ARE DEFINED HERE. 
# TODO VARNAME + VARNAMEdesc WILL AUTO POPULATE DOCUMENTATION AND ARGFILES. 
# TODO PARTIAL, NOT QUITE COMPLETE
###############################################################################
ARGFile_TemplateVariables_New() {
	
	# DECLARE ASSOCIATIVE GLOBAL ARRAY, ESSENTIALLY DICTIONARY FROM PYTHON LAND
	declare -A -g TVARS
	
	####################* SPECIALLY HANDLED VARS THAT HAVE ADDITIONAL PROCS ##############

	#* MOST VARIABLES IN THIS AREA NEED AN ALL OR NOTHING STATE IN THE
	#* TEMPLATE. HOWEVER, SETTING THEM TO "" CAUSES THE VARIABLE TO REMAIN
	#* IN THE TEMPLATE EX $_VAR_ DOESNT GET REMOVED / SET TO NOTHING.
	
	reuseVERBOSEvar() {
		if [[ "$_VERBOSE_" == "True" ]]; then
			_VERBOSE_="-v$vLVL"
		else
			_VERBOSE_="null"
		fi
	}
	reuseVERBOSEvar

	TVARS["VERBOSE"]="$_VERBOSE_"
	TVARS["VERBOSEdesc"]="#* When verbose switch set, this will be -v[0...5], 5 being most verbose. Set by VLevel"



	if [[ "$_KEEPName_" == "True" ]]; then
		TVARS["KEEPNAME"]="$exifToolBaseNameSeperator\$basename"
		TVARS["KEEPNAMEdesc"]="#* Blank unless -k keepname option enabled, Seperator + original filename if switch set"
	else
		TVARS["KEEPNAME"]="null"
		TVARS["KEEPNAMEdesc"]="null"
	fi

	####################* END SPECIALLY HANDLED VARS THAT HAVE ADDITIONAL PROCS ##############

	TVARS["ADDTAG_IMAGEHASH"]="$(echo -e "-api\nImageHashType=$_hashALGO_\n-XMP:OriginalImageHash<ImageDataHash")"
	TVARS["ADDTAG_IMAGEHASHdesc"]="#* Creates imagehash tag."

	TVARS["ADDTAG_PRESERVEDFILENAMEdesc"]="#* Adds the PreservedFileName tag."
	TVARS["ADDTAG_PRESERVEDFILENAME"]="-XMP-xmpMM:PreservedFileName<filename"

	TVARS["ANDROIDMANUFACTURER"]='${Keys:AndroidManufacturer;$_="[$_]"}'
	TVARS["ANDROIDMANUFACTURERdesc"]="#* Manufacturer"

	TVARS["ANDROIDMODEL"]='${Keys:AndroidModel;$_="[$_]"}'
	TVARS["ANDROIDMODELdesc"]="#* Model of android phone."

	TVARS["COUNTER"]='%+3c'
	TVARS["COUNTERdesc"]="#* Counter (Filename collision avoidance.)"

	TVARS["DDATEFORMAT"]="$(echo -e "-d\n%Y-%m-%d_%H.%M.%S__")"
	TVARS["DDATEFORMATdesc"]="#* (Prefer per dir option) -d/-dateFormat - Format for date/time values"

	TVARS["DIRSTARTdesc"]="#* Directory output destination start command."
	TVARS["DIRSTART"]="-Directory<"

	TVARS["DSTDIR"]="$_DSTDIR_"
	TVARS["DSTDIRdesc"]="#* DESTINATION DIRECTORY: OUTPUT directory for processed and renamed images"

	TVARS["EXTdesc"]="#* File Extension"
	TVARS["EXT"]='%e'

	TVARS["EXTLIST"]="$_EXTList_"
	TVARS["EXTLISTdesc"]="#* Extensions to work on"

	TVARS["FILEORDERFILENAME"]="$(echo -e "-fileOrder\n-FileName")"
	TVARS["FILEORDERFILENAMEdesc"]="#* Process in order of filename. Slow, dont use if possible."

	TVARS["FNAMESTARTdesc"]="#* Rename/move starting with SmartDate function included in the config that came with this script."
	TVARS["FNAMESTART"]='-filename<'

	TVARS["GETTAGSFROMCURRENTFILE"]="$(echo -e "-tagsfromfile\n@")"
	TVARS["GETTAGSFROMCURRENTFILEdesc"]="#* GETS / SETS TAGS FROM CURRENT FILE "

	TVARS["HASHALGORITHM"]="$_hashALGO_"
	TVARS["HASHALGORITHMdesc"]="#* Algorithm for creating the XMP:OriginalImageHash tag."

	TVARS["IMAGESIZE"]='${ImageSize;$_="[$_]"}'
	TVARS["IMAGESIZEdesc"]="#* Image Size composite tag"

	TVARS["MAKE"]='${Make;$_="[$_]"}'
	TVARS["MAKEdesc"]="#* Make of Android phone tag."

	TVARS["MODEL"]='${Model;$_="[$_]"}'
	TVARS["MODELdesc"]="#* Model of camera/phone"

	TVARS["NOEXIFDESTdesc"]="#* FOLDER NAME FOR NOEXIF DESTINATION DIRECTORY: OUTPUT directory for items without EXIF."
	TVARS["NOEXIFDEST"]="NO-EXIF"

	TVARS["NOXMP"]="$(echo -e "--ext\nxmp")"
	TVARS["NOXMPdesc"]="#* DO NOT WORK ON XMP FILES # Don't process xmp files, strangely enough used mostly to process xmp files.. lol.. "

	TVARS["PRESERVEdesc"]="#* (-P / -preserve) Preserve file modification date/time"
	TVARS["PRESERVE"]="-P"

	TVARS["QUIET"]="$(echo -e "-q")"
	TVARS["QUIETdesc"]="#* Quieter output, put twice for very quiet. shhbbyisok"

	TVARS["RECURSE"]="$_RECURSE_"
	TVARS["RECURSEdesc"]="#* Recurse. If recurse switch set, this will be -r, otherwise null/empty. "

	TVARS["SDATEFULL"]='${SmartDate;DateFmt("%Y-%m-%d_%H.%M.%S__")}'
	TVARS["SDATEFULLdesc"]="#* 2020-10-02_14.01.31__ SmartDate full output, used for filename usually."

	TVARS["SHHBBYISOK"]="$(echo -e "-m\n-q\n-q")"
	TVARS["SHHBBYISOKdesc"]="#* -m -q -q Supress minor errors and super quiet shortcut tag."

	TVARS["SRCDIR"]="$_SRCDIR_"
	TVARS["SRCDIRdesc"]="#* SOURCE DIRECTORY: INPUT directory containing unprocessed media."

	TVARS["SRCFILE_EXT_XMP"]="$(echo -e "-srcfile\n%d%f.%e.xmp")"
	TVARS["SRCFILE_EXT_XMPdesc"]="#* DIRECT ACTIONS TO FILENAME.EXT.XMP THIS FILE INSTEAD OF CURRENT FILE"

	TVARS["SRCFILE_XMP"]="$(echo -e "-srcfile\n%d%f.xmp")"
	TVARS["SRCFILE_XMPdesc"]="#* DIRECT ACTIONS TO FILENAME.XMP THIS FILE INSTEAD OF CURRENT FILE"

	TVARS["SUPRESSMINERRdesc"]="#* Suppress minor errors, if used, must be used equally (or none) on XMP + media argfiles. Otherwise problems."
	TVARS["SUPRESSMINERR"]="-m"


	TVARS["WRITEMODE_CREATE_INSERTMISSING"]="$(echo -e "-wm\ncg")"
	TVARS["WRITEMODE_CREATE_INSERTMISSINGdesc"]="#* write mode CREATE AND ADD ONLY NEW TAGS "

	TVARS["XIAOMIPRODUCTNAME"]='${Keys:XiaomiProductMarketname;$_="[$_]"}'
	TVARS["XIAOMIPRODUCTNAMEdesc"]="#* Phone name tag from Xiaomi"

	TVARS["YEAR"]='${SmartDate;DateFmt("%Y")}'
	TVARS["YEARdesc"]="#* YEAR Folder"

	TVARS["YEARMONTH"]='${SmartDate;DateFmt("%Y.%m-[%B]")}'
	TVARS["YEARMONTHdesc"]="#* SmartDate function located in config"

	#! ITERATE THROUGH KEY, VALUE PAIR, ASSIGN TO A STRING AND EVAL IT 
	#! REGISTERING IT AS A REGULAR SCRIPT VARIABLE FOR WITHIN THIS SCRIPT
	#! Create the key=value and register it from the associated array/dict.
	for KEY in "${!TVARS[@]}"; do
		regVAR="${KEY}='${TVARS[${KEY}]}'"
		#eval "$regVAR"
	done

}
ARGFile_TemplateVariables_New
###############################################################################



###############################################################################
#! DO THE VARIABLE THING
###############################################################################
declare -g -a FilesToCleanup=()
GenerateArgfileNew() {

	local ARGFile_Template="$1"
	# Name of ARGfile template to work on, present in the $ARGFiles_PATH destination.

	myUID=$(id -u)
	ARGFILE_TEMP="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}ARGFile_Assembled_TEMP.${RndStr}.XXXXXX")"
	ARGFILE_STRIPPED="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}ARGFile_STRIPPED_TEMP.${RndStr}.XXXXXX")"

	FilesToCleanup+=("$ARGFILE_TEMP")
	FilesToCleanup+=("$ARGFILE_STRIPPED")
	
	local WHITELIST_envsubst=""

	local DOCUMENT_BODY=""
	###########################################################################

	for KEY in "${!TVARS[@]}"; do

		local LABELName="${KEY}"
		local LABELValue="${TVARS[${KEY}]}"
		local ExportLABELName="_${LABELName}_"


		
		if [ -n "${LABELValue}" ]; then


			#! Special case for certain special variables so it deletes the variable in the template.
			#! If I recall, a blank export, unsets the export, so it needs a value that will resolve 
			#! to blank by envsubst.  
			if [ "${LABELValue}" == "null" ]; then
				LABELValue=""
				ExportLABELDESCValue=""
			fi


			
			#! Export label & value to subshell for envsubst
			export "$ExportLABELName=$LABELValue"
			
			# Build debuglist wether we need or not.
			DEBUGdata+=$(fixd_format_log_entry "EXPORT STRING:" "$ExportLABELName='$LABELValue'" " \n" "15" "150")

			# Build list of exported labels to ensure only those variables are changed.
			WHITELIST_envsubst+="\$$ExportLABELName"

			# Build Documentation Line: # $NAME - Value - Description
			DOCUMENT_BODY+=$(fixd_format_log_entry "# \$$ExportLABELName" "[ $LABELValue ]" " \n" "40" "150")

		fi
		
	done


	# Strip blank lines and lines starting with # (comments)
	grep -o '^[^#]*' "$ARGFile_Template" >"$ARGFILE_STRIPPED"
	#! Strip tabs and whitespace
	sed -i 's/[[:blank:]]*$//' "$ARGFILE_STRIPPED"


	local DOCUMENT_HEADER="# =========================================================\n"
	DOCUMENT_HEADER+="# EXPORTED VARIABLES for $ARGFile_Template \n"
	DOCUMENT_HEADER+="# =========================================================\n"
	DOCUMENT_HEADER+="# =========================================================\n\n"
	# Write header and then append expanded template
	printf '%b' "$DOCUMENT_HEADER" >"$ARGFILE_TEMP"
	printf '%b' "$DOCUMENT_BODY" | sort -u >>"$ARGFILE_TEMP"

	DEEBUG \
		'echo -e "\nCHECKPOINT: GenerateArgfileNew - $ARGFile_Template \n"' \
		'echo -e "EXPORT strings."'\
		'echo -e "$DEBUGdata"'\
		'echo -e "##########EXPORT strings end ########################\n\n"'\
		'echo -e "\nARGFILE EXPORTS\n\n$ARGFILE_TEMP"'\
		'cat $ARGFILE_TEMP'\
		'echo -e "\nCHECKPOINT: GenerateArgfileNew END - $ARGFile_Template \n"'


	# DO THE VARIABLE SWAP 
	envsubst "$WHITELIST_envsubst" <"$ARGFILE_STRIPPED" >>"$ARGFILE_TEMP"


}
###############################################################################




###############################################################################
#! RESETS DATASOURCES FOR THE TESTING OF YOUR ARGFILES 
###############################################################################
resetTESTData() {
	
	DEEBUG \
		'echo -e "\nCHECKPOINT: resetTESTData - PRE-delete  \n"' \
		'echo -e "\nMaking a copy of test set data from $TESTMODE_data to $TESTMODE_in\n"'\
		'echo -e "Please note the default copy will NOT copy hidden files or .dirs. "'\

	if [[ "$_DEBUG_" == "True" ]]; then

		echo -e "\nRemoving data from $TESTMODE_in and $TESTMODE_out."
		rm -Rfv "${TESTMODE_in:?}/"*
		rm -Rfv "${TESTMODE_out:?}/"*
		
		cp -vinar --reflink=always "$TESTMODE_data"/* "$TESTMODE_in"/

		DEEBUG \
			'echo -e "\nCHECKPOINT: resetTESTData - POST-delete  \n"'

	else
		rm -Rf "${TESTMODE_in:?}/"*
		rm -Rf "${TESTMODE_out:?}/"*

		cp -inar --reflink=always "$TESTMODE_data"/* "$TESTMODE_in"/

	fi
	
	echo -e "\nTESTDATA reset!"

}
###############################################################################



###############################################################################
#! MAIN WORK LOOP FOR RUNNING EXIFTOOL WITH YOUR ARGFILES
###############################################################################
beginPhotoVideoSort() {
	local TemplatesList=("$@")

	for template in "${TemplatesList[@]}"; do
		
		GenerateArgfileNew "$ARGFiles_PATH/$template"
        $exifToolCMD -@ "$ARGFILE_TEMP"
	
		DEEBUG \
			'echo -e "\nCHECKPOINT: beginPhotoVideoSort\n"'\
			'echo -e "\nUSED THIS TEMPLATE:\n$template \n"'\
			'echo -e "\nCREATED COMPLETED ARGFILE:\n$EDITOR $ARGFILE_TEMP\n"'\
			'echo -e "\nRAN THIS COMMAND:\n$exifToolCMD -@ $ARGFILE_TEMP \n"'
	
	
	done

}
###############################################################################


###############################################################################
#! TODO NOT SURE IF ITS CLEANING UP ALL
###############################################################################
tempFileCLEANUP() {
	
	local cleanTIMER=$1

	echo -e "Removing temporary files in $cleanTIMER seconds, Ctrl-C to preserve"
	sleep $cleanTIMER
	
	for FILE in "${FilesToCleanup[@]}"; do

		echo "Deleting $FILE"
		rm -v "$FILE"

	done




}
###############################################################################


###############################################################################
#! BETTER OUTPUT FORMATTING
###############################################################################
fixd_format_log_entry() {
	local LCol="$1"
	local MCol="$2"
	local RCol="$3"

	local LColSize="${4:-40}"
	local MColSize="${5:-55}"
	

	# Flatten physical newlines into spaces for the log entry only
	local clean_val="${MCol//$'\n'/ }"

	# Truncate value if it exceeds column width to prevent pushing Description
	[[ ${#clean_val} -gt ${MColSize} ]] && clean_val="${clean_val:0:${MColSize}}..."

	# Formatting: %-25s (25 chars wide, left-aligned)
#	printf "%-40s %-55s %s\n" \

	printf "%-${LColSize}s %-${MColSize}s %s\n"\
		"$LCol" \
		"$clean_val" \
		"$RCol"
}
###############################################################################
###############################################################################
#!
###############################################################################
###############################################################################
#! #### END OF FUNCTION DEFINITIONS  ##########################################





#* MAIN PROGRAM LOOP BELOW
###############################################################################

if [[ "$_DEBUG_" == "True" ]]; then
	
	settingsReport
	DEEBUG \
		'echo -e "\nCHECKPOINT: settingsReport \n"' 

	
fi

if [[ $_TESTMODE_ == "False" ]]; then


	echo -e "\nSORTING MEDIA..."
	beginPhotoVideoSort "${ARGFileTemplatesList[@]}"
	echo -e "\nDONE."

	tempFileCLEANUP 5

	exit
fi



###############################################################################
#* TESTMODE ENABLED BELOW BELOW
#! IF TESTMODE IS TRUE RUNS STUFF BELOW
###############################################################################
if [[ $_TESTMODERESET_ == "True" ]]; then

	#* RESET TEST DATA
	echo -e "In test area, RESETING TESTDATA & Generating argfile from commands. \n \n"
	resetTESTData

	beginPhotoVideoSort "${TESTMODEARGFileTemplatesList[@]}"

	# The folder containing the original media to make a copy during a reset.
	echo -e "\nTEST DIR DATASOURCE:\n$TESTMODE_data\n"

	# Folder media is copied from datasource to and processed.
	echo -e "\nTEST DIR IN:\n$TESTMODE_in\n"

	# Out is destination after processing.
	echo -e "\nTEST DIR OUT:\n$TESTMODE_out\n"

	
	echo -e "\nTESTMODEARGFileTemplatesList is :\n" "${TESTMODEARGFileTemplatesList[*]}\n"

	tempFileCLEANUP 5

fi

exit
