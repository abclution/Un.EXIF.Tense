#!/bin/bash
# shellcheck disable=SC2016
# Version: 1.0 Public Release, v7.2 Internal
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Locate the script directory for relative sourcing
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly SCRIPT_DIR
echo $SCRIPT_DIR

sTIMER="wait"

#* SET DEFAULT CONFIG FOR CASE IF USER DOESN'T SPECIFIY
thisCONFIG="un.exiftense.config"


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* SOURCES GIVEN FILE INTO SCRIPT
#! USAGE: resourceLOADER "PATH/FILENAME" (relative to ${SCRIPT_DIR}) 
#! OR 	  resourceLOADER "FULL_PATH/FILENAME" "True" (to load from any location)
resourceLOADER() {

	if [[ -z "$2" ]]; then

		#* If second parameter unset prepend the base scripting path.
		local targetFILE="${SCRIPT_DIR}/${1}"

	else

		#* If exists any second parameter, don't prepend the base scripting path
		local targetFILE="${1}"
	
	fi



	if [[ -f "${targetFILE}" ]]; then
		# shellcheck source=/dev/null
		echo "Loading ${targetFILE}..."
		source "${targetFILE}"
	else
		printf "Error: Target File '%s' not found.\n" "$1" >&2
		exit 1
	fi

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* LOADS DEFAULT CONFIG OR USER SPECIFIED CONFIG
#! USAGE: loadCONFIG
loadCONFIG() {
	resourceLOADER "${thisCONFIG}"
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* Initialization of some default stuff used later.
#! USAGE: prepInternalSettings
prepInternalSettings() {
	
	#* GET USERID FOR TEMP FILE LOCATION
	myUID=$(id -u)

	#* Array holding temp file names for cleanup.
	declare -g -a FilesToCleanup=()

	#* Anticlobber for temp files & exporting shell variables
	RndStr=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 4)
	
	#* Assemble exiftool command to include config
	exifToolCMD="$exiftoolPATH -config $exiftoolCONFIG "

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
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* EZ DEBUG FUNCTION, TAKES UP TO 8 ARGS THAT ARE EVALUATED AND SLEEPS AT THE END OF EACH CALL
#! USAGE: DEEBUG 'echo -e "\nEXAMPLE DEBUG NOTIFICATION \n"''
DEEBUG() {

	if [[ "$DEBUG" == "True" ]]; then

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
			echo -e "\n\nDEBUG: Continuing in ${sTIMER} seconds.."
			sleep ${sTIMER}
		fi

	fi
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* PRINTS PROGRAM HELP WHEN CALLED OR WHEN ERROR OCCURS WITH INITIAL SWITCHES
#! USAGE: showHELP
showHELP() {
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
	echo "  -x <boolean>        Enable XMP update/creation with has + original filename (default: $_XMPFunction_)"
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

	DEEBUG \
		'echo -e "\nCHECKPOINT: optionsMenuSetup \n"' \
		'echo -e "NOTICE: User passed enough correct switches to continue.\n"'

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* INIT DEFAULT SETTINGS
#! 
optionsMenuSetup "$@"
loadCONFIG
setDefaults
prepInternalSettings
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* PRINTS SCRIPT SETTINGS SETTINGS DURING A RUN
#!
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
	
	
	ORIGINAL FILENAME AS SUFFIX:	${KEEPName_}	 	
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

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#*
#!
setupTESTMODE() {

	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#! TESTMODE VALIDATION: CHECK SETTINGS TO ENSURE CORRECT FILE OPERATION
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	#* ENSURE TEST MODE IS A REQUIREMENT OF RUNNING THE RESET SWITCH.
	if [[ "$TESTMODERESET" == "True" ]]; then
		TESTMODE="True"
	fi

	#* BOTH A SAFETY AND TO AVOID REWRITING SOURCE AND DEST ON FUNCTIONS DEALING
	#* WITH THE DATA DURING TESTMODE
	if [[ "$TESTMODE" == "True" ]]; then
		SRCDIR="$TESTMODE_in"
		DSTDIR="$TESTMODE_out"
	fi

	DEEBUG \
		'echo -e "\nCHECKPOINT: setupTESTMODE TESTMODE VALIDATION\n"' \
		'echo -e "SRCDIR 		 		$SRCDIR  \nTESTMODE_in				$TESTMODE_in \n should have equal value\n\n"' \
		'echo -e "DSTDIR 		 		$DSTDIR  \nTESTMODE_out				$TESTMODE_out \n should have equal value\n\n"'

}
setupTESTMODE
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* SANITIZES INCOMING FILE, REMOVES BLANK LINES, LINES BEGINNING WITH # & EXTRA WHITESPACE
#! USAGE: sanitizeVARLIST "INPUTFILE" "OUTPUTFILEHANDLENAME"
SANITIZE_InputFiles() {
	
	local inFILE="$1"
	local outFILEname="$2"

	if [[ ! -f "$inFILE" ]]; then
		printf "Error: Configuration file '%s' not found.\n" "$inFILE" >&2
		return 1
	fi

	#* Temp file to avoid overwriting incoming file.
	outFILE="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.${outFILEname}.SANITIZED.${RndStr}.XXX")"

		


	#* Strip blank lines and lines starting with # (comments)
	#* Strip tabs and whitespace
	#* Sort and remove  duplicates.
	grep -Ev "^#|^$" "${inFILE}" |\
	sed 's/[[:blank:]]*$//' |\
	LC_ALL=C sort -u -o "${outFILE}"


	#! HACK TO RETURN VARIABLE NAME AS REQUESTED IN THE PARAMETER
	declare -g "$outFILEname=$outFILE"

	FilesToCleanup+=("${outFILE}")

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━






#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* SPLITS A SANITIZED VARLIST INTO LIST OF ITEMS AND ITEM DESCRIPTIONS
#! USAGE: splitVARLIST "SANITIZED_VARLIST_FILE"
VARLIST_SPLIT_ITEMSandDESCRIPTIONS() {

	local VARLIST_tosplit="$1"

	# CREATE TEMP FILES ONE FOR TEMPLATE VARIABLES AND ONE FOR TEMPLATE VARIABLE DESCRIPTION
	VARLIST_items="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.VARLIST.ITEMS.${RndStr}.XXX")"
	VARLIST_desc="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.VARLIST.DESC.${RndStr}.XXX")"

	cat "${VARLIST_tosplit}" | grep -siv 'desc_=' | sort >"${VARLIST_items}"
	cat "${VARLIST_tosplit}" | grep -si 'desc_=' | sort >"${VARLIST_desc}"

	cp "${VARLIST_items}" "${SCRIPT_DIR}"/configs/VARLISTS/splitfiles/"${RndStr}".VARLIST.ITEMS
	cp "${VARLIST_desc}" "${SCRIPT_DIR}"/configs/VARLISTS/splitfiles/"${RndStr}".VARLIST.DESC

	FilesToCleanup+=("${VARLIST_items}")
	FilesToCleanup+=("${VARLIST_desc}")

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* REGISTERS VARLIST KEY FILE INTO WHITELIST FOR ENVSUBST
#! USAGE:  createWHITELISTfor_envsubst "INPUT_VARLIST_FILE" "WHITELISTNAME"
VARLIST_EXPORT_Keys_as_List_of_VARS() {

	local listNAME="$2"


	while IFS='=' read -r KEY VALUE || [[ -n "$KEY" ]]; do

		#* BUILD LIST OF EXPORT KEYS TO USE AS WHITELIST for envsubst &  TESTING TEMPLATE
		VARLIST_KEYS_asListOfVARS+="\$${KEY}"$'\n'


	done <"$1"

	# HACK TO RETURN VARIABLE NAME AS REQUESTED IN THE PARAMETER
	declare -g "${listNAME}=${listDATA}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* READS VARLIST FILE AND CAN EXPORT DIRECTLY TO ENVIRONMENT AND/OR CREATE A SCRIPT TO SOURCE/RUN MANUALLY
#! USAGE:  readARGLIST_toEnvironment ${VARLISTFILE} REQUIREDBOOL:EXPORT-TO-ENVIRONMENT BOOL:SAVE-EXPORT-FILE
VARLIST_EXPORT_KeyValuePairs() {

	while read -r LINE; do

		#* WRITE EXPORT COMMANDS TO FILE
		if [[ "$3" = "True" ]]; then
			echo "export ${LINE}" >>"${ARGLIST_exportSCRIPT}"
		fi

		#* DO DIRECT EXPORT TO ENVIRONMENT
		if [[ "$2" = "True" ]]; then
			export "${LINE}"
		fi

	done <"$1"

	echo -e "Check export file command script: ${ARGLIST_exportSCRIPT}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* RE EXPORTS CERTAIN VARS THAT ARE DYNAMIC BASED ON USER CHOICES
#! USAGE:  VARLIST_HandleSPECIALVARS
VARLIST_HandleSPECIALVARS() {

	####################* SPECIALLY HANDLED VARS THAT HAVE ADDITIONAL PROCS ##############

	#* MOST VARIABLES IN THIS AREA NEED AN ALL OR NOTHING STATE IN THE
	#* TEMPLATE. HOWEVER, SETTING THEM TO "" CAUSES THE VARIABLE TO REMAIN
	#* IN THE TEMPLATE EX $_VAR_ DOESNT GET REMOVED / SET TO NOTHING.
	#! Special case for certain special variables so it deletes the variable in the template.
	#! If I recall, a blank export, unsets the export, so it needs a value that will resolve
	#! to blank by envsubst.

	local reEXPORT

	#* $_VERBOSE_
	if [[ "$VERBOSE" == "True" ]]; then

		reEXPORT="_VERBOSE_="-v${vLVL}""
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	else
	
		reEXPORT="_VERBOSE_="#* VERBOSE SET TO False"" 
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	fi


	#* $_RECURSE_
	if [[ "$RECURSE" == "True" ]]; then

		reEXPORT="_RECURSE_="-r"" 
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	else

		reEXPORT="_RECURSE_="#* RECURSE SET TO False"" 
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	fi

	#* $_KEEPNAME_
	if [[ "$KEEPName" == "True" ]]; then

		reEXPORT="_KEEPNAME_="$exifToolBaseNameSeperator\$basename"" 
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	else

		reEXPORT="_KEEPNAME_=""" 
		echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
		export "${reEXPORT}"

	fi

	#* TEMPLATE
	#reEXPORT="" 
	#echo "export ${reEXPORT}" >>"${ARGLIST_exportSCRIPT}"
	#export "${reEXPORT}"


}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━





#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* REGISTERS VARLIST KEY FILE INTO WHITELIST FOR ENVSUBST
#! USAGE:  prepARGFILE_Template  "$ARGFiles_PATH/$template"
ARGFILE_ProcessUserTemplate() {

	local ARGFILE_Template="$1"

	SANITIZE_InputFiles "${ARGFILE_Template}" "ARGFILE_Sanitized"


	envsubst "${WHITELIST_envsubst}" <"${ARGFILE_Sanitized}" >>"${ARGFILE_Final}"

	addVARLISTKey_toARGFILE "${ARGFILE_Final}"
	FilesToCleanup+=("${ARGFILE_Final}")

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* ADDS VARLIST KEY VALUES INTO THE FINAL ASSEMBLED ARFGILE
#! USAGE:  addVARLISTKey_toARGFILE  "FileTo AppendKeyTo(Must run after VARLIST is sanitized, and after final ARGFILE created)
addVARLISTKey_toARGFILE() {











	SAVEtemplate="${SCRIPT_DIR}/configs/ARGFILES/ARGLIST-ALLVARS-TEST-TEMPLATE.${RndStr}.argfile.sh"
	SANITIZE_InputFiles "${f_externalVarlist}" "VARLIST_sanitized"

	while IFS='=' read -r KEY VALUE || [[ -n "$KEY" ]]; do

		#* BUILD LIST OF ALL VARIABLE KEYS AND SAVE TO ARGFILE FOR TESTING OF ALL VARLIST ENTRIES.
#		listDATA+="\$${KEY}"$'\n'
#		listTOC+="# \$${KEY}	-		[ ${VALUE} ] "$'\n'

		#* Build Documentation Line: # $NAME - Value - Description
		# Need to strip newlines from values or stuff breaks.
		#DOCUMENT_BODY+=$(fixd_format_log_entry "# \$$KEY" "[ awk '{printf "%s ", $0}' < $VALUE  ]" " \n" "40" "150")

		listTOC+=$(fixd_format_log_entry "# \$${KEY}" "[  $VALUE  ]" " Col3" "40" "150")

	done <"${VARLIST_sanitized}"




	local VARLIST_KeyHeader=""
	VARLIST_KeyHeader+="\n\n"
	VARLIST_KeyHeader+="# =================================================================================================================="
	VARLIST_KeyHeader+="# =================================================================================================================="
	VARLIST_KeyHeader+="# 		EXPORTED VARIABLES  for "${ARGFILE_Template}" "
	VARLIST_KeyHeader+="# =================================================================================================================="
	VARLIST_KeyHeader+="# =================================================================================================================="
	VARLIST_KeyHeader+="\n\n"

	# # Write header and then append expanded template
	# printf '%b' "$DOCUMENT_HEADER" >> "${ARGFILE_Final}"
	# printf '%b' "$DOCUMENT_BODY" >> "${ARGFILE_Final}"



	# echo -e "#!/bin/bash \n\n" >>"${SAVEtemplate}"
	# echo -e "# THIS ARGFILE TEMPLATE IS AUTOMATICALLY GENERATED AND CAN BE USED AS A TEMPLATE STARTING POINT." >>"${SAVEtemplate}"
	# echo -e "# OR TO TEST AND VALIDATE THAT ALL THE VARLIST ENTRIES ARE PROPERLY SUBSTITUTED" >>"${SAVEtemplate}"
	# echo "${listDATA}" >>"${SAVEtemplate}"
	# echo -e "\n\n#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#####\n" >>"${SAVEtemplate}"
	# echo -e "#############################TOC / VAR KEY AND DESCRIPTIONS#########################\n" >>"${SAVEtemplate}"
	# echo -e "#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#####\n\n" >>"${SAVEtemplate}"
	# echo "${listTOC}" >>"${SAVEtemplate}"

	# echo -e "ALLVARS ARGLIST TEMPLATE UPDATED - \n $EDITOR ${SAVEtemplate}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* CREATES ARGFILE TEMPLATE CONTAINING ALL VARIABLES FOR TESTING OR AS A STARTING POINT.
#! USAGE:  create_ALLVARS_ARGLIST_Testing_Template (Must run after VARLIST is sanitized)
ARGLIST_CREATE_TestingTEMPLATE_DOCS() {

	local templateHEADER

	templateHEADER+="#!/bin/bash \n\n"
	templateHEADER+="# THIS ARGFILE TEMPLATE IS AUTOMATICALLY GENERATED AND CAN BE USED AS A TEMPLATE STARTING POINT."
	templateHEADER+="# OR TO TEST AND VALIDATE THAT ALL THE VARLIST ENTRIES ARE PROPERLY SUBSTITUTED"
	templateHEADER+="\n\n"
	templateHEADER+="#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"


	#* INSERT ALL KEYSe same as created with whitelist generator, VARLIST_EXPORTKeys_asVARS
	templateHEADER+="${VARLIST_KEYSasVARS_List}"
	
	
	templateHEADER+="\n\n"
	templateHEADER+="#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	templateHEADER+="#############################TOC / VAR KEY AND DESCRIPTIONS#########################\n"
	templateHEADER+="#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	templateHEADER+="\n\n"
	templateHEADER+="${listTOC}"

	echo -e "ALLVARS ARGLIST TEMPLATE UPDATED - \n $EDITOR ${SAVEtemplate}"

}
ARGLIST_CREATE_TestingTEMPLATE_DOCS


#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* CREATES ARGFILE TEMPLATE CONTAINING ALL VARIABLES FOR TESTING OR AS A STARTING POINT.
#! USAGE:  create_ALLVARS_ARGLIST_Testing_Template (Must run after VARLIST is sanitized)

create_ALLVARS_ARGLIST_Testing_Template() {

	SAVEtemplate="${SCRIPT_DIR}/configs/ARGFILES/ARGLIST-ALLVARS-TEST-TEMPLATE.${RndStr}.argfile.sh"
	SANITIZE_InputFiles "${f_externalVarlist}" "VARLIST_sanitized"

	while IFS='=' read -r KEY VALUE || [[ -n "$KEY" ]]; do

		#* BUILD LIST OF ALL VARIABLE KEYS AS WOULD BE ENTERED IN ARGFILE TEMPLATE.
		VARLIST_KEYSasVARS_List+="\$${KEY}"$'\n'



		listTOC+="# \$${KEY}	-		[ ${VALUE} ] "$'\n'

		#* Build Documentation Line: # $NAME - Value - Description
		# Need to strip newlines from values or stuff breaks.
		#DOCUMENT_BODY+=$(fixd_format_log_entry "# \$$KEY" "[ awk '{printf "%s ", $0}' < $VALUE  ]" " \n" "40" "150")

		listTOC+=$(fixd_format_log_entry "# \$${KEY}" "[  $VALUE  ]" " Col3" "40" "150")

	done <"${VARLIST_sanitized}"













	echo -e "#!/bin/bash \n\n" >>"${SAVEtemplate}"
	echo -e "# THIS ARGFILE TEMPLATE IS AUTOMATICALLY GENERATED AND CAN BE USED AS A TEMPLATE STARTING POINT." >>"${SAVEtemplate}"
	echo -e "# OR TO TEST AND VALIDATE THAT ALL THE VARLIST ENTRIES ARE PROPERLY SUBSTITUTED" >>"${SAVEtemplate}"
	echo "${VARLIST_KEYSasVARS_List}" >>"${SAVEtemplate}"
	echo -e "\n\n#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#####\n" >>"${SAVEtemplate}"
	echo -e "#############################TOC / VAR KEY AND DESCRIPTIONS#########################\n" >>"${SAVEtemplate}"
	echo -e "#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#####\n\n" >>"${SAVEtemplate}"
	echo "${listTOC}" >>"${SAVEtemplate}"

	echo -e "ALLVARS ARGLIST TEMPLATE UPDATED - \n $EDITOR ${SAVEtemplate}"
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
create_ALLVARS_ARGLIST_Testing_Template
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━









#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* DESRIPTION: RESETS DATASOURCES FOR THE TESTING OF YOUR ARGFILES
#! USAGE: TESTDATA_Reset
TESTDATA_Reset() {

	DEEBUG \
		'echo -e "\nCHECKPOINT: resetTESTData - PRE-delete  \n"' \
		'echo -e "\nMaking a copy of test set data from $TESTMODE_data to $TESTMODE_in\n"' \
		'echo -e "Please note the default copy will NOT copy hidden files or .dirs. "'



	if [[ "$DEBUG" == "True" ]]; then

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
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEMPFILES_Initialize() {

	#* ${ARGLIST_exportSCRIPT}
	#! USED IN: VARLIST_EXPORT_KeyValuePairs
	ARGLIST_exportSCRIPT="${SCRIPT_DIR}/configs/VARLISTS/splitfiles/${RndStr}.VARLIST.EXPORT-COMMANDS.sh"
	echo -e "#!/bin/bash \n\n" >>"${ARGLIST_exportSCRIPT}"
	FilesToCleanup+=("${ARGLIST_exportSCRIPT}")


	#* ${ARGFILE_Final}
	#! Used in: ARGFILE_ProcessUserTemplate
	ARGFILE_Final="$(mktemp --suffix=".argfile" "${TMPDIR:-/run/user/$myUID/}unexif.ARGFile-FINAL-$(basename ${ARGFILE_Template}).${RndStr}.XXXXXX")"
	echo -e '#!/bin/bash' >>"${ARGFILE_Final}"
	echo -e "\n#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━####\n" >>"${ARGFILE_Final}"

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TEMPFILES_Cleanup() {

	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#! TODO NOT SURE IF ITS CLEANING UP ALL
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	local cleanTIMER=$1

	echo -e "Removing temporary files in $cleanTIMER seconds, Ctrl-C to preserve"
	for FILE in "${FilesToCleanup[@]}"; do

		echo "$FILE"

	done
	sleep $cleanTIMER

	for FILE in "${FilesToCleanup[@]}"; do

		#echo "Deleting $FILE"
		rm "$FILE"

	done

}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FORMAT_TextOutput() {

	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#! BETTER OUTPUT FORMATTING
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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

	printf "%-${LColSize}s %-${MColSize}s %s\n" \
		"$LCol" \
		"$clean_val" \
		"$RCol"
}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#! MAIN WORK LOOP FOR RUNNING EXIFTOOL WITH YOUR ARGFILES
SORT_MEDIA() {

	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	TEMPFILES_Initialize
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	SANITIZE_InputFiles "${f_externalVarlist}" "VARLIST_sanitized"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	VARLIST_SPLIT_ITEMSandDESCRIPTIONS "${VARLIST_sanitized}"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	VARLIST_EXPORT_Keys_as_List_of_VARS "${VARLIST_items}" "WHITELIST_envsubst"
	VARLIST_EXPORT_Keys_as_List_of_VARS "${VARLIST_desc}" "WHITELIST_envsubst"
	VARLIST_EXPORT_Keys_as_List_of_VARS "${VARLIST_sanitized}" "VARLIST_AllVARKeys"
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#* Export commands to a script instead of directly, then source it.
	VARLIST_EXPORT_KeyValuePairs "${VARLIST_items}" "False" "True"
	VARLIST_EXPORT_KeyValuePairs "${VARLIST_desc}" "False" "True"
		#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	#* Re-export/overwrite special vars.
	VARLIST_HandleSPECIALVARS
	source ${ARGLIST_exportSCRIPT}
	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	local TemplatesList=("$@")

	

	for ARGFILE_UserTemplate in "${TemplatesList[@]}"; do

		echo -e "\nPROCESSING "${ARGFiles_PATH}/${ARGFILE_UserTemplate}"..."

		ARGFILE_ProcessUserTemplate "${ARGFiles_PATH}/${ARGFILE_UserTemplate}"

		$exifToolCMD -@ "$ARGFILE_Final"

		DEEBUG \
			'echo -e "\nCHECKPOINT: beginPhotoVideoSort\n"' \
			'echo -e "\nUSED THIS TEMPLATE:\n$template \n"' \
			'echo -e "\nCREATED COMPLETED ARGFILE:\n$EDITOR $ARGFILE_Final\n"' \
			'echo -e "\nRAN THIS COMMAND:\n$exifToolCMD -@ $ARGFILE_Final \n"'

	done

	echo -e "\nDONE."


}
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#! #### END OF FUNCTION DEFINITIONS  ##########################################

#* MAIN PROGRAM LOOP BELOW
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [[ "$DEBUG" == "True" ]]; then

	settingsReport
	DEEBUG \
		'echo -e "\nCHECKPOINT: settingsReport \n"'

fi

if [[ $TESTMODE == "False" ]]; then

	SORT_MEDIA "${ARGFileTemplatesList[@]}"


	#nano -w $ARGFILE_Final
	#echo "${WHITELIST_envsubst}"

	TEMPFILES_Cleanup 5

	exit
fi

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#* TESTMODE ENABLED BELOW BELOW
#! IF TESTMODE IS TRUE RUNS STUFF BELOW
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if [[ $TESTMODERESET == "True" ]]; then

	#* RESET TEST DATA
	echo -e "In test area, RESETING TESTDATA & Generating argfile from commands. \n \n"
	TESTDATA_Reset

	SORT_MEDIA "${TESTMODEARGFileTemplatesList[@]}"

	# The folder containing the original media to make a copy during a reset.
	echo -e "\nTEST DIR DATASOURCE:\n$TESTMODE_data\n"

	# Folder media is copied from datasource to and processed.
	echo -e "\nTEST DIR IN:\n$TESTMODE_in\n"

	# Out is destination after processing.
	echo -e "\nTEST DIR OUT:\n$TESTMODE_out\n"

	echo -e "\nTESTMODEARGFileTemplatesList is :\n" "${TESTMODEARGFileTemplatesList[*]}\n"

	TEMPFILES_Cleanup 5

fi

exit








# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SetupGenerateArgfile() {
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	SANITIZE_InputFiles "${f_externalVarlist}" "VARLIST_sanitized"
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	VARLIST_SPLIT_ITEMSandDESCRIPTIONS "${VARLIST_sanitized}"
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	VARLIST_EXPORT_Keys_as_List "${VARLIST_items}" "WHITELIST_envsubst"
# 	VARLIST_EXPORT_Keys_as_List "${VARLIST_desc}" "WHITELIST_envsubst"
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	#* Export commands to a script instead of directly, then source it.
# 	VARLIST_EXPORT_KeyValuePairs "${VARLIST_items}" "False" "True"
# 	VARLIST_EXPORT_KeyValuePairs "${VARLIST_desc}" "False" "True"
# 	source ${ARGLIST_exportSCRIPT}
# 	#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 	#* Re-export/overwrite special vars.
# 	handleSpecialVARS

# }
# #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 	DEEBUG \
# 		'echo -e "\nCHECKPOINT: GenerateArgfileNew - $ARGFile_Template \n"' \
# 		'echo -e "EXPORT strings."' \
# 		'echo -e "$DEBUGdata"' \
# 		'echo -e "##########EXPORT strings end ########################\n\n"' \
# 		'echo -e "\nARGFILE EXPORTS\n\n$ARGFILE_TEMP"' \
# 		'cat $ARGFILE_TEMP' \
# 		'echo -e "\nCHECKPOINT: GenerateArgfileNew END - $ARGFile_Template \n"'

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━



