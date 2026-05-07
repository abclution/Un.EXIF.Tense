#!/bin/bash
# DEBUG: !/bin/bash -x
# shellcheck disable=SC2016,SC2162

# Version: 1.0 Public Release, v7.2 Internal
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Locate the script directory for relative sourcing
#SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$(dirname "$0")"

readonly SCRIPT_DIR

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "$0 is running from $SCRIPT_DIR"
sleep .5
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#* EARLY SET OF DEBUG TIMER FOR DEBUGGING OF THINGS BEFORE CONFIG IS LOADED.
sTIMER="wait"

# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* SOURCES GIVEN FILE INTO SCRIPT
# #! USAGE: resourceLOADER "PATH/FILENAME" (relative to ${SCRIPT_DIR})
# #! OR 	  resourceLOADER "FULL_PATH/FILENAME" "True" (to load from any location)
# resourceLOADER() {

# 	# shellcheck disable=SC2317
# 	if [[ -z "$2" ]]; then

# 		#* If second parameter unset prepend the base scripting path.
# 		local targetFILE="${SCRIPT_DIR}/${1}"

# 	else

# 		#* If exists any second parameter, don't prepend the base scripting path
# 		local targetFILE="${1}"

# 	fi

# 	if [[ -f "${targetFILE}" ]]; then
# 		# shellcheck source=/dev/null
# 		echo "Loading ${targetFILE}..."
# 		source "${targetFILE}"
# 	else
# 		printf "Error: Target File '%s' not found.\n" "$1" >&2
# 		exit 1
# 	fi

# }
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* LOADS DEFAULT CONFIG OR USER SPECIFIED CONFIG
# #! USAGE: loadCONFIG
# loadCONFIG() {

# 	if [[ -z "${thisCONFIG}" ]]; then
# 		#* SET DEFAULT CONFIG FOR CASE IF USER DOESN'T SPECIFIY
# 		thisCONFIG="un.exiftense.config"
# 	fi

# 	# shellcheck source=configs/un.exiftense.config
# 	source "${SCRIPT_DIR}"/"${thisCONFIG}"

#
#
#

# 	DEEBUG "${FUNCNAME[0]}"  \
# 	'echo -e "${SCRIPT_DIR}"/"${thisCONFIG} \n"' \
# 	'echo -e "2 \n"' \
# 	'echo -e "3 \n"'

# }
# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

load_DEFAULTS() {

	if [[ -z "${thisCONFIG}" ]]; then
		#* SET DEFAULT CONFIG FOR CASE IF USER DOESN'T SPECIFIY
		thisCONFIG="un.exiftense.config"
	fi

	# ###############################################################################
	# #* USER FACING VARIABLES ######################################################
	# #* YOU CAN SET DEFAULT OPTIONS FOR COMMAND LINE SWITCHES BELOW
	# ###############################################################################
	# SRCDIR="./in"
	# DSTDIR="./out"
	# hashALGO="SHA512"
	# XMPFunction="True"
	# RECURSE="True"
	# QT_UTC=0
	# KEEPName="True"
	# TESTMODE="False"
	# TESTMODERESET="False"
	# VIDEOS="True"
	# PHOTOS="True"
	# ###############################################################################
	# #* USER CONFIG: VERBOSITY AND DEBUG MISC OPTIONS
	# ###############################################################################
	# DEBUG="False"

	# VERBOSE="False"
	# vLVL=2 # Verbosity level for exiftool when set to true.
	# # Verbose overrides quiet mode, Verbose 0 exiftool prints current filename only.

	# #! DEBUG SLEEP TIMER, TIME BETWEEN COMMANDS TO DEBUG ONSCREEN INFO
	# #! Can also be "wait" to wait for keypress
	# sTIMER="wait"
	# #sTIMER=".5"

	# #* TEMP FOLDER,  ONLY CHANGE THE  TMPDIR IF YOU DON'T WANT TO USE THE DEFAULT OF "/run/user/$YOURUSERID/"
	# TMPDIR=""
	# Cleanup_TempFiles="False"
	# timer_TempFileCleanup="5"
	# saveFilesDest_REFTEMPLATE="${SCRIPT_DIR}/configs/ARGFILES/REFERENCE-Templates"

	# ###############################################################################

	# ###############################################################################
	# #* USER CONFIG: EXTENSION LISTS FOR TYPES OF FILES YOU WANT THIS SCRIPT TO DEAL WITH
	# ###############################################################################
	# #! PHOTO EXTENSION LIST
	# declare -g -a EXTList_Photos=("webp" "dng" "jpg" "heic" "png" "gif" "bmp" "tiff" "tif")

	# #! VIDEO EXTENSION LIST
	# declare -g -a EXTList_Videos=("mov" "mp4" "mpg" "3gp" "wmv" "webm" "avi" "m4v")
	# ###############################################################################

	# ###############################################################################
	# #* USER CONFIG: EXIFTOOL SETTINGS
	# ###############################################################################
	# # IF PRESENT IN YOUR PATH, SIMPLY LIST AS "exiftool"
	# exiftoolPATH="/usr/bin/exiftool"

	# #/fixd-toolkit/scripts/scripts.FILE-ORGANIZATION/Un.EXIFTense/un.exiftense.exiftoolconfig
	# exiftoolCONFIG="${SCRIPT_DIR}/configs/exiftool.configs/un.exiftense.exiftoolconfig"

	# # WHEN USING KEEPING NAME OPTION, CAN USE THIS AS A SEPERATOR, TEMPLATE DEPENDENT
	# exifToolBaseNameSeperator="___"
	# ###############################################################################

	# ###############################################################################
	# #* USER CONFIG: VARLIST & ARGFILES CONFIGURATION SETTINGS
	# ###############################################################################

	# #! BASE PATH TO VARIABLE CONFIG LIST
	# f_externalVarlist="${SCRIPT_DIR}/configs/VARLISTS/VARLIST"

	# #! BASE PATH TO ARGFILE TEMPLATES
	# ARGFiles_PATH="${SCRIPT_DIR}/configs/ARGFILES/SERIES04"

	# ###############################################################################
	# # ARGFILE TEMPLATE NAMES (FILENAMES)
	# # List of argfile filenames in ARGFiles_PATH to run in the order you wish to run them.

	# # Can be formatted like this, all in one declaration, or one by one, or a mix.
	# # declare -a TESTMODEARGFileTemplatesList=("TEMPLATE-01" "TEMPLATE-02")

	# declare -g -a ARGFileTemplatesList=()
	# ARGFileTemplatesList+=("S04_P01_RENAMES-FILE_AND_SIDECAR_TO_HASHVALUE.argfile.sh")

	# #echo -e "Templates active:${ARGFileTemplatesList[@]}\n"
	# # TODO ADD FILE EXISTENCE CHECK FOR TEMPLATES
	# ###############################################################################

	# ###############################################################################
	# #* USER CONFIG: TESTMODE CONFIGURATION
	# ###############################################################################
	# # Alternate list of argfile templates to be used in TESTMODE.
	# declare -g -a TESTMODEARGFileTemplatesList=()

	# TESTMODEARGFileTemplatesList+=("S04_P01_RENAMES-FILE_AND_SIDECAR_TO_HASHVALUE.argfile.sh")

	# #echo -e "Templates active for TESTMODE (if active): ${TESTMODEARGFileTemplatesList[@]} \n"

	# ###############################################################################
	# # TESTMODE FOLDERS AND PATHS
	# # THESE ARE RELEVENT WHEN -t (testmode) or -T switch (testmode reset) is enabled.

	# # Define folders for test mode usage.
	# # DATA The folder containing the original media that is copied to the IN dir.
	# TESTMODE_data="${SCRIPT_DIR}/test-src"

	# # IN is where photos and vids will be copied and processed.
	# TESTMODE_in="${SCRIPT_DIR}/test-in"

	# # OUT is destination after processing.
	# TESTMODE_out="${SCRIPT_DIR}/test-out"
	# ###############################################################################
	# ###############################################################################

	DEEBUG "${FUNCNAME[0]}"

}

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* Initialization of some default stuff used later.
#! USAGE: prepInternalSettings

prepInternalSettings() {

	#fNAME='if [[ "$DEBUG" == "True" ]]; then echo -e "${FUNCNAME}\n\n" ; fi'
	# Destination for generated example template.
	mkdir -p "${saveFilesDest_REFTEMPLATE}"

	#* GET USERID FOR TEMP FILE LOCATION
	myUID=$(id -u)

	#* Epoch Timestamp
	ts="$(date +%s)"
	ts_ISO="$(date --iso-8601)"

	#! This destination is used if TMPDIR is not set.
	def_TMPDIR="/run/user/${myUID}/un.exiftense/${ts}.un.exiftense-tempfiles"
	target_TMPDIR="${TMPDIR:-${def_TMPDIR}}"
	tmpPATHandPREFIX="${target_TMPDIR}/un.exiftense.${ts}"

	#* Array holding temp file names for cleanup.
	declare -g -a FilesToCleanup=()

	#* Anticlobber for temp files & exporting shell variables
	RndStr="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 4)"

	#* Assemble exiftool command to include config
	exifToolCMD="${exiftoolPATH} -config $exiftoolCONFIG"

	#* Prep $EXTList for supported files.
	if [[ "$VIDEOS" == "True" ]]; then
		for VIDfmt in "${EXTList_Videos[@]}"; do
			EXTList+="-ext"$'\n'"$VIDfmt"$'\n'
		done
	fi

	if [[ "$PHOTOS" == "True" ]]; then
		for IMGfmt in "${EXTList_Photos[@]}"; do
			EXTList+="-ext"$'\n'"$IMGfmt"$'\n'
		done
	fi
	# fmtLine='echo -e "\n# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"'

	DEEBUG "${FUNCNAME[0]}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* EZ DEBUG FUNCTION, TAKES UP TO 8 ARGS THAT ARE EVALUATED AND SLEEPS AT THE END OF EACH CALL
#! USAGE: DEEBUG 'echo -e "\nEXAMPLE DEBUG NOTIFICATION \n"''
DEEBUG() {

	if [[ "$DEBUG" == "True" ]]; then

		# local dbugCMD01="$1"
		local dbugCMD02="$2"
		local dbugCMD03="$3"
		local dbugCMD04="$4"
		local dbugCMD05="$5"
		local dbugCMD06="$6"
		local dbugCMD07="$7"
		local dbugCMD08="$8"
		echo -e "\n# ━━ DEBUG ━━━ [ $1 ] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
		# echo -e "\n $1 $2 $3 $4 \n"
		#eval "$dbugCMD01"
		eval "$dbugCMD02"
		eval "$dbugCMD03"
		eval "$dbugCMD04"
		eval "$dbugCMD05"
		eval "$dbugCMD06"
		eval "$dbugCMD07"
		eval "$dbugCMD08"

		#echo -e "\n# ━━ DEBUG END ━━━━━ [ $1 ] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

		if [[ "$sTIMER" == "wait" ]]; then
			echo -e "\n"
			read -r -p "Enter to continue..."
		else
			echo -e "\nContinuing in ${sTIMER} seconds.."
			sleep ${sTIMER}
		fi

	fi
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* PRINTS PROGRAM HELP WHEN CALLED OR WHEN ERROR OCCURS WITH INITIAL SWITCHES
#! USAGE: showHELP
showHELP() {

	DEEBUG "${FUNCNAME[0]}"
	load_DEFAULTS
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	# --- Usage Function ---
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	echo "Usage: $(basename "$0") [OPTIONS]"
	echo "Script to rename PHOTOS & VIDEOS & XMP sidecar files based on EXIF/XMP metadata."
	echo "XMP Sidecar stores both the original filename and hash checksum for posterity."
	echo ""
	echo "Options:              *Required"
	echo "  -c <string>         Choose alternate config for $0. (default: $thisCONFIG)"
	echo "  -s <directory>      *Source of media folder (default: $SRCDIR)"
	echo "  -d <directory>      *Sorted/Output folder, created automatically if needed. (default: $DSTDIR)"
	echo "  -k <boolean>        Keep original filename suffixed to new file name (default: $KEEPName)"
	echo "  -r <boolean>        Enable/disable recursive processing of source media dir. (default: $RECURSE)"
	echo "  -w <boolean>        Enable/disable processing of videos. (default: $VIDEOS)"
	echo "  -x <boolean>        Enable XMP update/creation with has + original filename (default: $XMPFunction)"
	echo "  -m <string>         Choose hashing function: 'MD5', 'SHA256' or 'SHA512' (default: ${hashALGO})"
	echo "  -q <number 0 or 1>  Set QuickTime UTC (default: $QT_UTC)"
	echo "  -v <boolean>        Enable verbose mode for exiftool (default: ${VERBOSE})"
	echo "  -t <boolean>        Enables test functions (default: $TESTMODE)"
	echo "  -T <boolean>        Enables test functions & RESETS TESTING data. (Set dirs in script.) (default: $TESTMODERESET)"
	echo "  -D <boolean>        Enable debug. Very verbose output from script actions: $DEBUG)"
	echo "  -h                  Display this help message"
	echo -e "\n\n\n"

	exit 1

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* HANDLES  USER SWITCHES VALIDATES SWITCHES AND THEIR NEEDED DATA TYPES BEFORE PROGRAM MAIN LOOP
#! USAGE: optionsMenuSetup "$@"
optionsMenuSetup() {

	DEEBUG "${FUNCNAME[0]}"

	#* --- Command Line switches handler ---
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#* --- Process Switches ---
	#* Use getopts to parse command-line options.
	#* The colon after mq'o' and 'r' indicates that these options require an argument.
	#* The leading colon enables silent error reporting by getopts, allowing custom error handling.
	while getopts ":c:s:d:k:r:w:x:m:q:v:t:T:h:D:" opt; do
		case $opt in
		c)
			# Validate if the argument matches from list options.
			if [[ ! -e "$OPTARG" && ! -r "$OPTARG" && ! -n "$OPTARG" ]]; then
				echo "Please put a valid path to a config file." >&2
				showHELP
			fi
			thisCONFIG="$OPTARG"
			;;
		s)
			# Validate if the argument is a directory that exists
			if [ ! -d "$OPTARG" ]; then
				echo "Error: Source directory '$OPTARG' not found or is not a directory." >&2
				showHELP
			fi
			SRCDIR="$OPTARG"
			;;
		d)
			DSTDIR="$OPTARG"
			;;
		k)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -k requires a boolean argument (True or False)." >&2
				showHELP
			fi
			KEEPName="$OPTARG"
			;;
		r)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -r requires a boolean argument (True or False)." >&2
				showHELP
			fi
			RECURSE="$OPTARG"
			;;
		x)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -x requires a boolean argument (True or False)." >&2
				showHELP
			fi
			XMPFunction="$OPTARG"
			;;
		m)
			# Validate if the argument matches from list options.
			if [[ "$OPTARG" != "MD5" && "$OPTARG" != "SHA256" && "$OPTARG" != "SHA512" ]]; then
				echo "Error: -m requires one of the following (MD5, SHA256, SHA512)." >&2
				showHELP
			fi
			hashALGO="$OPTARG"
			;;

		q)
			# Validate if the argument is a number
			if ! [[ "$OPTARG" =~ ^[0-1]+$ ]]; then
				echo "Error: -q requires a numeric argument of 1 or 0." >&2
				showHELP
			fi
			QT_UTC="$OPTARG"
			;;
		w)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -w requires a boolean argument (True or False)." >&2
				showHELP
			fi
			VIDEOS="$OPTARG"
			;;
		v)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -v requires a boolean argument (True or False)." >&2
				showHELP
			fi
			VERBOSE="$OPTARG"
			;;
		D)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -D requires a boolean argument (True or False)." >&2
				showHELP
			fi
			DEBUG="$OPTARG"
			;;
		t)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -t requires a boolean argument (True or False)." >&2
				showHELP
			fi
			TESTMODE="$OPTARG"
			;;
		T)
			# Validate if the argument is a boolean.
			if [[ "$OPTARG" != "True" && "$OPTARG" != "False" ]]; then
				echo "Error: -T requires a boolean argument (True or False)." >&2
				showHELP
			fi
			TESTMODERESET="$OPTARG"
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
		SRCDIR="$1"
		DSTDIR="$2"
	fi

	if [[ -z "$SRCDIR" || -z "$DSTDIR" ]]; then
		showHELP
	fi

	if [[ "$1" == "-h" || "$1" == "--help" || "$2" == "-h" || "$2" == "--help" || "$3" == "-h" || "$3" == "--help" ]]; then
		showHELP
	fi

	DEEBUG "${FUNCNAME[0]}" \
		'echo -e "\nCHECKPOINT: optionsMenuSetup \n"' \
		'echo -e "NOTICE: User passed enough correct switches to continue.\n"'

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* INIT DEFAULT SETTINGS
#! 
scriptINIT() {
	load_DEFAULTS
	optionsMenuSetup "$@"
	#loadCONFIG
	prepInternalSettings
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* PRINTS SCRIPT SETTINGS SETTINGS DURING A RUN
# TODO UPDATE REPORT WITH FORMATTING SETTINGS
settingsReport() {
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#! PRINTS PROGRAM SETTINGS DURING A RUN
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	echo -e "
	CONFIG FILE IN USE:	${thisCONFIG}
	TESTMODE:			${TESTMODE}			RESET ENABLED:		${TESTMODERESET}
	VERBOSE:			${VERBOSE}			VERBOSITY LEVEL:	${vLVL}
	DEBUG:				${DEBUG}			DEBUG SLEEP TIMER:	${sTIMER}
	
	SOURCE DIR:			${SRCDIR}
	DESTINATION. DIR:	${DSTDIR}
	RECURSE: 			${RECURSE}
	
	PROCESS MEDIA FILES
	PHOTOS:				${PHOTOS}
	VIDEOS:				${VIDEOS}
	
	MEDIA FILE EXTENSIONS AVAILIABLE TO PROCESS
	PHOTOS: 			${EXTList_Photos[*]}
	VIDEOS: 			${EXTList_Videos[*]}
	

	XMP SIDECAR:		${XMPFunction}	
	XMP HASH ALGO:		${hashALGO}
	
	
	ORIGINAL FILENAME AS SUFFIX:	${KEEPName}	 	
	BASENAME SEPERATOR: ${exifToolBaseNameSeperator} 
	
	QUICKTIME UTC:		${QT_UTC}

	EXIFTOOL INFO
	BINARY PATH: 		${exiftoolPATH}
	CONFIG LOCATION: 	${exiftoolCONFIG}
	BASE COMMAND: 		${exifToolCMD} 

	ARGFILE TEMPLATES
	LOCATION / PATH:	${ARGFiles_PATH}
	TEMPLATE NAMES:		${ARGFileTemplatesList[*]} \n

	TESTMODE SETTINGS
	DATA SOURCE: 		${TESTMODE_data}	(IF TESTMODE RESET ENABLED, IN & OUT
	IN FOLDER:			${TESTMODE_in} 	 FOLDER CONTENTS ARE DELETED EACH RUN!!!)
	OUT FOLDER:			${TESTMODE_out}
	TESTMODE TEMPLATES: ${TESTMODEARGFileTemplatesList[*]}\n

	RANDOM STRING FOR THIS RUN: ${RndStr}"

	DEEBUG "${FUNCNAME[0]}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#settingsReport
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* TESTMODE VALIDATION: CHECK SETTINGS TO ENSURE CORRECT FILE OPERATION
#! USAGE: TESTMODE_Validate
TESTMODE_Validate() {

	DEEBUG "${FUNCNAME[0]}"

	#* ENSURE TEST MODE ENABLED IF TEST IS A REQUIREMENT OF RUNNING THE RESET SWITCH.
	if [[ "$TESTMODERESET" == "True" ]]; then
		TESTMODE="True"
	fi

	#* BOTH A SAFETY AND TO AVOID REWRITING SOURCE AND DEST ON FUNCTIONS DEALING
	#* WITH THE DATA DURING TESTMODE
	if [[ "$TESTMODE" == "True" ]]; then

		SRCDIR="$TESTMODE_in"
		DSTDIR="$TESTMODE_out"

		DEEBUG \
			'echo -e "\nTESTMODE ENABLED, VALIDATING DIRS.\n"' \
			'echo -e "SRCDIR 		 		$SRCDIR  \nTESTMODE_in				$TESTMODE_in \n should have equal value\n\n"' \
			'echo -e "DSTDIR 		 		$DSTDIR  \nTESTMODE_out				$TESTMODE_out \n should have equal value\n\n"'

	fi

}

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* DESRIPTION: RESETS DATASOURCES FOR THE TESTING OF YOUR ARGFILES
#! USAGE: TESTMODE_Reset
TESTMODE_Reset() {

	DEEBUG "${FUNCNAME[0]}" \
		'echo -e "\nCHECKPOINT: resetTESTData - PRE-delete  \n"' \
		'echo -e "\nMaking a copy of test set data from ${TESTMODE_data}to ${TESTMODE_in}\n"' \
		'echo -e "Please note the default copy will NOT copy hidden files or .dirs. "'

	if [[ "${DEBUG}" == "True" ]]; then

		echo -e "\nRemoving data from ${TESTMODE_in} and ${TESTMODE_out}."
		rm -Rfv "${TESTMODE_in:?}/"*
		rm -Rfv "${TESTMODE_out:?}/"*
		cp -vinar --reflink=always "$TESTMODE_data"/* "$TESTMODE_in"/

		DEEBUG "${FUNCNAME[0]}" \
			'echo -e "\nCHECKPOINT: resetTESTData - POST-delete  \n"'

	else

		rm -Rf "${TESTMODE_in:?}/"*
		rm -Rf "${TESTMODE_out:?}/"*
		cp -inar --reflink=always "$TESTMODE_data"/* "$TESTMODE_in"/

	fi

	echo -e "\nTESTDATA reset!"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* SANITIZES INCOMING FILE, REMOVES BLANK LINES, LINES BEGINNING WITH # & EXTRA WHITESPACE
#! USAGE: sanitizeVARLIST "INPUTFILE" "OUTPUTFILEHANDLENAME"
SANITIZE_InputFiles() {

	DEEBUG "${FUNCNAME[0]}"

	local inFILE="${1}"
	local outFILE="${2}"

	if [[ ! -f "$inFILE" ]]; then
		printf "Error: Configuration file '%s' not found.\n" "$inFILE" >&2
		return 1
	fi

	#* Temp file to avoid overwriting incoming file.
	#outFILE="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.${outFILEname}.SANITIZED.${RndStr}.XXX")"

	#* Strip blank lines and lines starting with # (comments)
	#* Strip tabs and whitespace
	#* Sort and remove  duplicates.
	LC_ALL=C grep -Ev "^#|^$" "${inFILE}" |
		sed 's/[[:blank:]]*$//' |
		sort -u -o "${outFILE}"

	#! HACK TO RETURN VARIABLE NAME AS REQUESTED IN THE PARAMETER
	#declare -g "$outFILEname=$outFILE"

	#FilesToCleanup+=("${outFILE}")

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* SPLITS A SANITIZED VARLIST INTO LIST OF ITEMS AND ITEM DESCRIPTIONS
# #! USAGE: splitVARLIST "SANITIZED_VARLIST_FILE"
# VARLIST_SPLIT_ITEMS_and_DESCRIPTIONS() {

# 	DEEBUG "${FUNCNAME[0]}"

# 	local VARLIST_tosplit="$1"

# 	# CREATE TEMP FILES ONE FOR TEMPLATE VARIABLES AND ONE FOR TEMPLATE VARIABLE DESCRIPTION
# 	#VARLIST_items="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.VARLIST.ITEMS.${RndStr}.XXX")"
# 	#VARLIST_desc="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.VARLIST.DESC.${RndStr}.XXX")"

# 	cat "${VARLIST_tosplit}" | grep -siv 'desc_=' | sort >"${VARLIST_items}"
# 	cat "${VARLIST_tosplit}" | grep -si 'desc_=' | sort >"${VARLIST_desc}"

# 	cp -vn "${VARLIST_items}" "${SCRIPT_DIR}/configs/VARLISTS/"
# 	cp -vn "${VARLIST_desc}" "${SCRIPT_DIR}/configs/VARLISTS/"

# 	FilesToCleanup+=("${VARLIST_items}")
# 	FilesToCleanup+=("${VARLIST_desc}")

# }
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* EXPORTS KEYNAMES FROM VARS TO ENV AND/OR FILE
#! USAGE:  VARLIST_CREATE_LIST_of_KEYNAMES_as_VARNAMES "$INPUT_FILE" "$OUTPUT_FILE"
#~ EXAMPLE:VARLIST_CREATE_LIST_of_KEYNAMES_as_VARNAMES "${VARLIST_items}" "${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}" "Blank for newlines per line, 1 for no newline"
VARLIST_EXPORT_KeysAsVariables() {

	DEEBUG "${FUNCNAME[0]} - INFILE: ${1} - OUTFILE: ${2} "

	local VARLIST_in="${1}"
	local VARLIST_out="${2}"
	local LIST_KeyNames_as_VARS=""

	while IFS='=' read -r KEY VALUE || [[ -n "$KEY" ]]; do

		if [[ -z ${3} ]]; then

			#* BUILD LIST OF EXPORT KEYS PREFIXED WITH'$' TO USE AS VARIABLE NAMES (EG FOR WHITELIST for envsubst &  TESTING TEMPLATE)
			LIST_KeyNames_as_VARS+="\$${KEY}"$'\n'

		else

			#* BUILD LIST OF EXPORT KEYS PREFIXED WITH'$' TO USE AS VARIABLE NAMES (EG FOR WHITELIST for envsubst &  TESTING TEMPLATE)
			LIST_KeyNames_as_VARS+="\$${KEY}"

		fi

	done <"${VARLIST_in}"

	echo "${LIST_KeyNames_as_VARS}" >>"${VARLIST_out}"
	#echo "List of VAR names: ${2}"
	# # HACK TO RETURN VARIABLE NAME AS REQUESTED IN THE PARAMETER
	# declare -g "${listNAME}=${listDATA}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* READS VARLIST FILE AND CAN EXPORT DIRECTLY TO ENVIRONMENT AND/OR CREATE A SCRIPT TO SOURCE/RUN MANUALLY
#! USAGE: VARLIST_EXPORT_KeyValuePairs "INPUT_VARLIST_FILE" "EXPORT-TO-ENVIRONMENT,REQUIRED, BOOLEAN" "EXPORT-SCRIPT-FILENAME"
#~ EXAMPLE: VARLIST_EXPORT_KeyValuePairs "${VARLIST_Sanitized}" "False" "${VARLIST_EXPORT_TO_ENV_SCRIPT}"
VARLIST_EXPORT_KeyValuePairs() {

	DEEBUG "${FUNCNAME[0]}"

	local in_FILE="${1}"
	local bool_IMMEDIATE_EXPORT="${2}"
	local out_FILE="${3}"

	if [[ -z "${out_FILE}" ]]; then

		out_FILE="/dev/null"

	fi

	while read -r LINE; do

		#* WRITE EXPORT COMMANDS TO FILE  or /dev/null if unset
		echo "export ${LINE}" >>"${out_FILE}"

		#* DO DIRECT EXPORT TO ENVIRONMENT
		if [[ "${bool_IMMEDIATE_EXPORT}" = "True" ]]; then
			export "${LINE?}"
		fi

	done <"${in_FILE}"

	# if [[ "${out_FILE}" != "/dev/null" ]]; then

	# 	echo -e "Export script: ${out_FILE}"

	# fi

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* CHECKS EXPORTED VARIABLES AND VALUES
#! USAGE:
# TODO FINISH THIS VARLIST_EXPORT_VALIDATOR FUNCTION
# VARLIST_EXPORT_Validate() {

# 	DEEBUG "${FUNCNAME[0]}"

# 	in_FILE="${1}"

# 	echo -e "\n ━━━ [ ${FUNCNAME[0]} ] for ${in_FILE}       ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 	while read -r LINE; do

# 		echo "${LINE} evaluates to : $(eval "echo ${LINE}")"

# 	done <"${in_FILE}"
#echo "${VARLIST_KEYNAMES_as_VARIABLES_ALL}"
#read -p "echo"
#cat "${VARLIST_KEYNAMES_as_VARIABLES_ALL}"
#read -p "cat"
#export -p | grep -si "VARLIST\|_*_"
#read -p "export"

# 	echo -e "\n ━━━ [ ${FUNCNAME[0]} ] for ${in_FILE} - END ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
# 		# #* WORKED FINE # Load with contents of file, newline delimited
# 		# WList=$(<"${VARLIST_KEYNAMES_as_VARIABLES_ALL}")
# 		# envsubst "${WList}" < "${ARGFILE_Sanitized}"
# 		# read -p "wlist 1"

# 		# #* WORKED FINE # Load with contents of file, strangly no delimiters
# 		# WList2=$(<"${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}")
# 		# envsubst "${WList2}" < "${ARGFILE_Sanitized}"
# 		# read -p "wlist 2"

# 		#* WORKED FINE # Direct conversion of file
# 		envsubst "$(<"${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}")" < "${ARGFILE_Sanitized}" >> "${ARGFILE_Final}"
# 		nano "${ARGFILE_Final}"

# }
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* RE EXPORTS CERTAIN VARS THAT ARE DYNAMIC BASED ON USER CHOICES
#! USAGE:  VARLIST_HandleSPECIALVARS "BOOL(export to env)""${VARLIST_EXPORT_TO_ENV_SCRIPT}"
VARLIST_EXPORT_SpecialVariablesHandler() {

	DEEBUG "${FUNCNAME[0]}"

	####################* SPECIALLY HANDLED VARS THAT HAVE ADDITIONAL PROCS ##############

	#* MOST VARIABLES IN THIS AREA NEED AN ALL OR NOTHING STATE IN THE
	#* TEMPLATE. HOWEVER, SETTING THEM TO "" CAUSES THE VARIABLE TO REMAIN
	#* IN THE TEMPLATE EX $_VAR_ DOESNT GET REMOVED / SET TO NOTHING.
	#! Special case for certain special variables so it deletes the variable in the template.
	#! If I recall, a blank export, unsets the export, so it needs a value that will resolve
	#! to blank by envsubst.

	local KEYandVALUEpair_to_reEXPORT=""
	local bool_IMMEDIATE_EXPORT="${1}"
	local out_FILE="${2}"

	if [[ -z "${out_FILE}" ]]; then

		out_FILE="/dev/null"

	else

		out_FILE="${2}"

	fi

	#* $_VERBOSE_ ###################################################################
	if [[ "$VERBOSE" == "True" ]]; then

		KEYandVALUEpair_to_reEXPORT="_VERBOSE_="-v${vLVL}""
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"

		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	else

		KEYandVALUEpair_to_reEXPORT="_VERBOSE_=\"#* VERBOSE SET TO False\""
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"
		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	fi
	#* ###################################################################

	#* $_RECURSE_ ###################################################################
	if [[ "$RECURSE" == "True" ]]; then

		KEYandVALUEpair_to_reEXPORT="_RECURSE_=\"-r\""
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"
		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	else

		KEYandVALUEpair_to_reEXPORT='_RECURSE_="#* RECURSE SET TO False"'
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"
		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	fi
	#* ###################################################################

	#* $_KEEPNAME_ ###################################################################
	if [[ "$KEEPName" == "True" ]]; then

		KEYandVALUEpair_to_reEXPORT="_KEEPNAME_="${exifToolBaseNameSeperator}\$basename""
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"
		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	else

		KEYandVALUEpair_to_reEXPORT="_KEEPNAME_="""
		echo "export ${KEYandVALUEpair_to_reEXPORT}" >>"${out_FILE}"
		if [[ ${bool_IMMEDIATE_EXPORT} == "True" ]]; then export "${KEYandVALUEpair_to_reEXPORT?}"; fi

	fi
	#* ###################################################################

	#* TEMPLATE
	#reEXPORT=""
	#echo "export ${reEXPORT}" >>"${VARLIST_EXPORT_TO_ENV_SCRIPT}"
	#export "${reEXPORT}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* CREATES TABLE OF CONTENTS REFERENCE DOC FOR ALL VARLIST ENTRIES. APPEND TO  ${ARGFILE_Final} & "${ARGFILE_BASE_Template}"
#! USAGE: VARLIST_CREATE_TOCdoc "LISTOFVARIABLE_FILE" "OUTPUT_FILE"
#~ EXAMPLE:  VARLIST_CREATE_TOCdoc "${VARLIST_AllVARKeys}" "${VARLIST_TOCdoc}"
VARLIST_CREATE_TOCdoc() {

	DEEBUG "${FUNCNAME[0]}"

	local VARLIST_in="${1}"
	local TOCdoc_out="${2}"

	local TOCdoc_HEADER=""
	TOCdoc_HEADER+="\n\n"

	TOCdoc_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ \n"
	TOCdoc_HEADER+="#* ############################ TOC / REFERENCE FOR ALL VARLIST ENTRIES & DESCRIPTIONS #######################################################\n"
	TOCdoc_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ \n"
	TOCdoc_HEADER+="#! PLEASE NOTE: NEWLINES IN VARIABLES ARE SHOWN HERE AS <!NL!> TO MAINTAIN FORMATTING AS WELL AS VALUES HERE ARE TEMPLATE, NOT SUBSTITUTED VALUES."
	TOCdoc_HEADER+="\n\n"

	local TOCdoc_BODY=""
	TOCdoc_BODY+="\n\n"
	TOCdoc_BODY+=$(FORMAT_TextOutput "# TEMPLATE_VARIABLE NAME" "VALUE" "\n" "44" "150")
	TOCdoc_BODY+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	TOCdoc_BODY+="\n\n"

	while IFS='=' read -r KEY VALUE || [[ -n "$KEY" ]]; do
		# printf "%q\n" "$VALUE"
		TOCdoc_BODY+="$(FORMAT_TextOutput "# \$${KEY}" "$VALUE" "\n" "44" "150")"

	done <"${VARLIST_in}"

	echo -e "${TOCdoc_HEADER}" >>"${TOCdoc_out}"
	echo -e "${TOCdoc_BODY}" >>"${TOCdoc_out}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEMPFILES_Initialize() {

	mkdir -p "${target_TMPDIR}"

	#* ${VARLIST_Sanitized}
	#! USED IN : SANITIZE_InputFiles
	VARLIST_Sanitized="${tmpPATHandPREFIX}__VARLIST__SANITIZED.txt"
	FilesToCleanup+=("${VARLIST_Sanitized}")

	# #* CREATE TEMP FILES ONE FOR TEMPLATE VARIABLES AND ONE FOR TEMPLATE VARIABLE DESCRIPTION
	# VARLIST_items="${tmpPATHandPREFIX}.VARLIST.SPLIT.ITEMS"
	# VARLIST_desc="${tmpPATHandPREFIX}.VARLIST.SPLIT.DESC"
	# FilesToCleanup+=("${VARLIST_items}")
	# FilesToCleanup+=("${VARLIST_desc}")

	#* ${VARLIST_EXPORT_TO_ENV_SCRIPT}
	#! USED IN : VARLIST_EXPORT_KeyValuePairs & VARLIST_HandleSPECIALVARS
	VARLIST_EXPORT_TO_ENV_SCRIPT="${tmpPATHandPREFIX}__VARLIST__EXPORT-KEY-VALUE-PAIRS.IMPORT-TO-ENV-SCRIPT.sh"
	FilesToCleanup+=("${VARLIST_EXPORT_TO_ENV_SCRIPT}")
	echo -e "#!/bin/bash \n\n" >"${VARLIST_EXPORT_TO_ENV_SCRIPT}"

	#* ${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}
	#! USED IN : ARGFILE_ProcessUserTemplate & VARLIST_CREATE_LIST_of_KEYNAMES_as_VARNAMES
	VARLIST_KEYNAMES_as_VARIABLES_WHITELIST="${tmpPATHandPREFIX}__VARLIST__EXPORT-KEYS-AS-VARIABLES__WHITELIST.txt"
	FilesToCleanup+=("${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}")

	#* ${VARLIST_KEYNAMES_as_VARIABLES_ALL}   (Almost always this will be same content as WHITELIST but potentially not.)
	#! USED IN : ARGFILE_ProcessUserTemplate & VARLIST_CREATE_LIST_of_KEYNAMES_as_VARNAMES
	VARLIST_KEYNAMES_as_VARIABLES_ALL="${tmpPATHandPREFIX}__VARLIST__EXPORT-KEYS-AS-VARIABLES__ALL-KEYS.txt"
	FilesToCleanup+=("${VARLIST_KEYNAMES_as_VARIABLES_ALL}")

	#* ${VARLIST_KEYNAMES_as_VARIABLES_ALL}   (Almost always this will be same content as WHITELIST but potentially not.)
	#! USED IN : ARGFILE_ProcessUserTemplate & VARLIST_CREATE_LIST_of_KEYNAMES_as_VARNAMES
	VARLIST_KEYNAMES_as_VARIABLES_TEST="${tmpPATHandPREFIX}__VARLIST__EXPORT-KEYS-AS-VARIABLES__TEST.txt"
	FilesToCleanup+=("${VARLIST_KEYNAMES_as_VARIABLES_TEST}")

	#* ${VARLIST_TOCdoc}
	#! USED IN : VARLIST_CREATE_TOCdoc
	VARLIST_TOCdoc="${tmpPATHandPREFIX}__VARLIST__CREATE-TABLEOFCONTENTS-REFERENCE-DOC.txt"
	FilesToCleanup+=("${VARLIST_TOCdoc}")

	#* ${ARGFILE_BASE_Template}
	#! USED IN :
	ARGFILE_BASE_Template="${tmpPATHandPREFIX}__ARGFILE__EXAMPLE-FULL_REFERENCE-TEMPLATE.argfile"
	FilesToCleanup+=("${ARGFILE_BASE_Template}")

	DEEBUG "${FUNCNAME[0]}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEMPFILES_Cleanup() {
	#* -------------------------------------------------------------------------------------
	echo -e "The following temporary directories and files were created.\n"
	echo -e "DIRECTORY: ${target_TMPDIR}\n\nFILELIST:\n"
	for FILE in "${FilesToCleanup[@]}"; do
		echo -e "$FILE\n"
	done
	#* -------------------------------------------------------------------------------------

	if [[ -z "${Cleanup_TempFiles}" ]] || [[ "${Cleanup_TempFiles}" == "False" ]]; then

		echo -e "Cleanup of temporary files disabled or unset."

	else
		if [[ "${Cleanup_TempFiles}" == "True" ]]; then

			echo -e "Removing temporary files in ${timer_TempFileCleanup} seconds, Ctrl-C to preserve"
			sleep "${timer_TempFileCleanup}"

			for FILE in "${FilesToCleanup[@]}"; do
				rm -vf "$FILE"
			done
			rmdir "${target_TMPDIR}"

		fi
	fi

}

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#! USAGE: FORMAT_TextOutput "LEFT COLUMN VALUE" "MIDDLE COLUMN VALUE" "RIGHT COLUMN VALUE" "L-COLUMN SIZE IN CHARS" "MID-COLUMN SIZE IN  CHARS"
FORMAT_TextOutput() {

	#DEEBUG "${FUNCNAME[0]}"

	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#! BETTER OUTPUT FORMATTING
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	local LCol="${1}"
	local MCol="${2}"
	#local MCol="$(echo -n -E "${2}")"
	local RCol="${3}"

	local LCol_Len="${4:-44}"
	local MCol_Len="${5:-150}"

	# Flatten physical newlines into spaces for the log entry only
	local MCol_sanitized="${MCol//$'\n'/-}"
	local MCol_sanitized="${MCol//\\n/ <!NL!> }"

	# Truncate value if it exceeds column width to prevent pushing Description
	if [[ ${#MCol_sanitized} -gt ${MCol_Len} ]]; then
		MCol_sanitized="${MCol_sanitized:0:${MCol_Len}}..."
	fi

	# Formatting: %-25s (25 chars wide, left-aligned)
	#	printf "%-40s %-55s %s\n" \

	printf "%-${LCol_Len}s %-${MCol_Len}s %s\n" "${LCol}" "${MCol_sanitized}" "${RCol}"
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* CREATES ARGFILE TEMPLATE CONTAINING ALL VARIABLES + TOC FOR TESTING OR AS A STARTING POINT.
#! USAGE:  ARGFILE_CREATE_BASE_Template "LISTOFVARIABLENAMES_FILE" "TABLEOFCONTENTS-REFERENCE_FILE" "OUTPUT_TEMPLATE_FILE"
#~ EXAMPLE: ARGFILE_CREATE_BASE_Template "${VARLIST_KEYNAMES_as_VARIABLES_ALL}" "${VARLIST_TOCdoc}" "${ARGFILE_BASE_Template}"
ARGFILE_CREATE_BASE_Template() {

	DEEBUG "${FUNCNAME[0]}"

	local in_FILE="${1}"
	local in_TOCdocFILE="${2}"
	local out_FILE="${3}"

	local BASETemplate_HEADER=""
	BASETemplate_HEADER+="#!/bin/bash"
	BASETemplate_HEADER+="\n\n"
	BASETemplate_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
	BASETemplate_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
	BASETemplate_HEADER+="\n\n"
	BASETemplate_HEADER+="# THIS ARGFILE TEMPLATE IS AUTOMATICALLY GENERATED AND CAN BE USED AS A TEMPLATE STARTING POINT.\n"
	BASETemplate_HEADER+="# OR TO TEST AND VALIDATE THAT ALL THE VARLIST ENTRIES ARE PROPERLY SUBSTITUTED\n"
	BASETemplate_HEADER+="\n\n"
	BASETemplate_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
	BASETemplate_HEADER+="# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"

	#* COMBINE HEADER & LIST OF ALL $_VARIABLE_ AVAILIABLE FOR SUBSTITUTION & TOC/REFERENCE DOC TO VARIABLES.
	{
		echo -e "${BASETemplate_HEADER}"
		cat "${in_FILE}"
		cat "${in_TOCdocFILE}"
	} >>"${out_FILE}"

	# echo -e "ARGFILE BASE TEMPLATE CREATED: ${out_FILE}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#* GETS BASENAME OF PATH/FILE STRING THAT MAY HAVE MULTIPLE LAYERS OF PERIOD SEPERATORS
#! USAGE: extractComplexBASENAME "STRING-OR-VARIABLE" "NUMBER OF REMOVED  DOTS"
#~ EXAMPLE: extractComplexBASENAME "/A/PATH/AND/COMPLEXFILENAME.WITH.NON.DESCRIPT.EXTENSIONS "4"
extractComplexBASENAME() {

	#DEEBUG "${FUNCNAME[0]}"

	local rawNAME="${1}"
	local dotLAYERS="${2}"
	local filenameBASE

	#echo "Raw name: ${rawNAME}"

	filenameBASE="$(basename "${rawNAME}")"
	#echo "filenameBASE is : ${filenameBASE}"

	while [[ "${dotLAYERS}" -gt 0 ]]; do
		filenameBASE="${filenameBASE%.*}"
		dotLAYERS=${dotLAYERS}-1
		#echo "filenameBASE is : ${filenameBASE}"
	done

	#echo "Final Extracted basename of ${filenameBASE}"
	echo "${filenameBASE}"

}

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#! MAIN WORK LOOP FOR RUNNING EXIFTOOL WITH YOUR ARGFILES
ProcessUserTemplates_PreInit() {

	DEEBUG "${FUNCNAME[0]}"

	TESTMODE_Validate
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	TEMPFILES_Initialize
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	SANITIZE_InputFiles "${f_externalVarlist}" "${VARLIST_Sanitized}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	VARLIST_CREATE_TOCdoc "${VARLIST_Sanitized}" "${VARLIST_TOCdoc}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	VARLIST_EXPORT_KeysAsVariables "${VARLIST_Sanitized}" "${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}" "1"
	VARLIST_EXPORT_KeysAsVariables "${VARLIST_Sanitized}" "${VARLIST_KEYNAMES_as_VARIABLES_ALL}"
	VARLIST_EXPORT_KeysAsVariables "${VARLIST_Sanitized}" "${VARLIST_KEYNAMES_as_VARIABLES_TEST}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	ARGFILE_CREATE_BASE_Template "${VARLIST_KEYNAMES_as_VARIABLES_ALL}" "${VARLIST_TOCdoc}" "${ARGFILE_BASE_Template}"
	cp -nv "${ARGFILE_BASE_Template}" "${saveFilesDest_REFTEMPLATE}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#* Export commands to a script instead of directly due to needing to account for special variables.
	VARLIST_EXPORT_KeyValuePairs "${VARLIST_Sanitized}" "False" "${VARLIST_EXPORT_TO_ENV_SCRIPT}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#* Re-export/overwrite special vars. We append this to the previous export script.
	#! USAGE:  VARLIST_HandleSPECIALVARS "BOOL export to env" "${VARLIST_EXPORT_TO_ENV_SCRIPT}"
	VARLIST_EXPORT_SpecialVariablesHandler "False" "${VARLIST_EXPORT_TO_ENV_SCRIPT}"
	# shellcheck source=/dev/null
	source "${VARLIST_EXPORT_TO_ENV_SCRIPT}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#VARLIST_EXPORT_Validate "${VARLIST_KEYNAMES_as_VARIABLES_TEST}"
	#VARLIST_EXPORT_Validate "${VARLIST_KEYNAMES_as_VARIABLES_ALL}"
	#VARLIST_EXPORT_Validate "${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}"
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━���━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* PROCESSES USER TEMPLATES, THEN RUNS EXIFTOOL WITH THE FINALIZED ARGLIST. ALSO GENERATES A UPDATED TEMPLATE FOR USER CONVIENIENCE.
#! USAGE:  prepARGFILE_Template  "$ARGFiles_PATH/$template"
ProcessUserTemplates() {

	DEEBUG "${FUNCNAME[0]}"

	# GRAB ALL PASSED TEMPLATE ITEM ENTRIES PARAMETERS
	local TemplatesList=("$@")

	for TEMPLATE in "${TemplatesList[@]}"; do

		echo -e "\nPROCESSING ${ARGFiles_PATH}/${TEMPLATE}"

		UserTemplateBASENAME="$(extractComplexBASENAME "${TEMPLATE}" "2")"

		#* CREATE FILE HANDLE FOR USER TEMPLATE
		ARGFILE_Sanitized="${tmpPATHandPREFIX}__ARGFILE__SANITIZED-${UserTemplateBASENAME}.argfile"
		FilesToCleanup+=("${ARGFILE_Sanitized}")

		#* SANITIZE USER ARGFILE TEMPLATES
		SANITIZE_InputFiles "${ARGFiles_PATH}/${TEMPLATE}" "${ARGFILE_Sanitized}"

		ARGFILE_Final="${tmpPATHandPREFIX}__ARGFILE__FINAL-${UserTemplateBASENAME}.argfile"
		#* ADD HEADER TO FINAL ARGFILE
		{
			echo -e '#!/bin/bash'
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "# shellcheck disable=all"
			echo -e "# Exiftool Argfile - Generated from user template -> ${UserTemplateBASENAME} - ${ts_ISO} - ${ts}"
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "\n\n"

		} >>"${ARGFILE_Final}"
		FilesToCleanup+=("${ARGFILE_Final}")

		#* DO THE VARIABLE SUBSTITUTION
		envsubst "$(<"${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}")" <"${ARGFILE_Sanitized}" >>"${ARGFILE_Final}"

		#* ADD  TABLE OF CONTENTS / REFERENCE TO END OF FINAL ARGFILE TO REVIEW IF KEEPING TEMP FILES.
		cat "${VARLIST_TOCdoc}" >>"${ARGFILE_Final}"

		# RENDER THE BASE FULL TEMPLATE JUST AS A CHECK, WE SKIP SANITIZATION TO SEE IF HEADER AND FOOTER CAUSE ISSUES.
		# TODO SEPERATE THIS TO SEPERATE OPTION.
		ARGFILE_BASE_Template_Validation="${tmpPATHandPREFIX}__ARGFILE__EXAMPLE-FULL_REFERENCE-TEMPLATE_CHECK-VALIDATION.argfile"
		FilesToCleanup+=("${ARGFILE_BASE_Template_Validation}")
		envsubst "$(<"${VARLIST_KEYNAMES_as_VARIABLES_ALL}")" <"${ARGFILE_BASE_Template}" >>"${ARGFILE_BASE_Template_Validation}"
		cp -nv "${ARGFILE_BASE_Template_Validation}" "${saveFilesDest_REFTEMPLATE}"

		#* EXIFTOOL
		echo -e "STARTING EXIFTOOL PROCESSING.\n\n"
		#$exifToolCMD -@ "${ARGFILE_Final}"

	done

	echo -e "\n\nMEDIA PROCESSING DONE."

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SORT_MEDIA() {

	DEEBUG "${FUNCNAME[0]}"

	ProcessUserTemplates_PreInit

	if [[ "${TESTMODE}" != "True" ]]; then

		ProcessUserTemplates "${ARGFileTemplatesList[@]}"

	else

		echo -e "TESTMODE ENABLED! \n \n"

		if [[ "${TESTMODERESET}" == "True" ]]; then

			echo -e "TESTMODE DATA RESET ENABLED!  \n \n"
			echo -e "\n # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "\n#! TEST DIR DATASOURCE:	${TESTMODE_data}\n"
			echo -e "#* The folder containing the original media to make a copy during a reset.\n"
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "\n#! TEST DIR IN:			${TESTMODE_in}\n"
			echo -e "#* TARGET Folder media from datasource is copied to and processed.\n"
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "\n#! TEST DIR OUT:			${TESTMODE_out}\n"
			echo -e "#* TEST DIR OUT is destination after processing.\n"
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
			echo -e "\nTESTMODEARGFileTemplatesList is :\n" "${TESTMODEARGFileTemplatesList[*]}\n"
			echo -e "# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

			#* RESET TEST DATA
			TESTMODE_Reset

		fi

		ProcessUserTemplates "${TESTMODEARGFileTemplatesList[@]}"

	fi

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#! #### END OF FUNCTION DEFINITIONS  ##########################################
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* MAIN PROGRAM LOOP BELOW
# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
scriptINIT "$@"


SORT_MEDIA
settingsReport
TEMPFILES_Cleanup

exit

# #settingsReport

# # DEEBUG "${FUNCNAME[0]}" \
# # 	settingsReport \
# # 	'echo -e "\nCHECKPOINT: settingsReport \n"'

# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* TESTMODE DISABLED AREA
# #! IF TESTMODE IS FALSE RUNS STUFF BELOW
# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# if [[ $TESTMODE == "False" ]]; then

# 	SORT_MEDIA
# 	TEMPFILES_Cleanup 5

# 	#nano -w $ARGFILE_Final
# 	#echo "${VARLIST_KEYNAMES_as_VARIABLES_WHITELIST}"

# 	exit

# fi

# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# #* TESTMODE ENABLED AREA
# #! IF TESTMODE IS TRUE RUNS STUFF BELOW
# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# if [[ $TESTMODERESET == "True" ]]; then

# 	SORT_MEDIA
# 	TEMPFILES_Cleanup 5

# 	settingsReport

# fi
