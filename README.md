# Un.EXIF.Tense - (OrganizeMyMedia)

**Un.EXIF.Tense** is a high-performance wrapper for `exiftool` designed to automate the organization of massive photo and video libraries. It eliminates "quoting hell" by utilizing Bash-injected `argfiles`, allowing for complex metadata operations with minimal syntax overhead.



# An exiftool helper system letting more people, accomplish more with less tension and stress.

Stressed out with the complexity of exiftool and its wonders, this  is a simple framework to use the full potential of exiftool, in a mortal time-frame and stress free. . ;)

\###############################################################################
\##\* ARGFILE STRING REPLACEMENT VARS, DA GOOD STUFF
\###############################################################################

Exiftool, is a very particular application of genius, madness, and immense concentration, focus, effort and masochism. *At the very least when I try to utilize it…* *I spend as much time getting the formatting of the command and the right quoteing that it exhausts me before I get to play with all its features, or get my media files sorted the way I want..*


The built-in argfile capability simplifies commands and forgoes having to learn complex escaping of commands. Wish I knew about that a bit sooner.. however, it does not support variable substitution in a script, it does however using environment variables. 


UnEXIFTense helps turn argfiles into a full blown template system.

 

The exiftool switches function as expected without stress or worry... however there is one or two caveats.
However, argfiles cannot do substituion like a bash script, and variables must be exported to the environment to use them as well. This is less convienient than a script.

This is solved in a nice and easy way using envsubst and this script.

```
Rules for creating your own variable replacements for argfiles
*#  Use double quotes if we are replacing values from in here.
# * Single quotes if encapsulating exiftool options.
# * Don't mix the two types.
# ! TODO We add prefix to exported variable to not clobber existing environtment variables.
```

So why the contorsion with renaming variables etc. envsubst which assists us to replace variables, is hamfisted and replaces anything that it thinks may be correct.


So we use a whitelist building out the whitelist programmatically with sequenced variable names gives the opportunity to add / adjust the program and template with minimal addtional lines of code.





---

## Core Workflow

The system operates through a four-stage pipeline:


1. **Initialization:** Loads user defaults and maps internal variables to the `TVARS` associative array.
2. **Expansion:** Uses `envsubst` to inject Bash variables into `argfile` templates located in the `SERIES` directory.
3. **Execution:** Feeds the assembled, temporary argfile to `exiftool` via the `-@` switch.
4. **Cleanup:** Flushes temporary expanded files to maintain a clean workspace.


---

## Key Features

* **XMP Sidecar Management:** Automates the creation and synchronization of XMP files to preserve metadata integrity.
* **Robust Hashing:** Supports `MD5`, `SHA256`, and `SHA512` for generating unique `OriginalImageHash` tags.
* **Test Mode Sandbox:** Features a destructive reset (`-T`) and non-destructive test (`-t`) environment to verify template logic before applying changes to live data.
* **SmartDate Integration:** Leverages custom `exiftool` configurations for unified date handling across diverse device manufacturers (Xiaomi, Android, etc.).


---

## Command Line Interface

| Switch | Argument | Description |
|:---|:---|:---|
| `-s` | `<path>` | Source directory containing media. |
| `-d` | `<path>` | Destination directory for organized output. |
| `-k` | `Boolean` | Keep original filename as a suffix. |
| `-r` | `Boolean` | Enable recursive directory processing. |
| `-x` | `Boolean` | Enable XMP sidecar creation/updates. |
| `-m` | `String` | Hashing algorithm (`MD5`, `SHA256`, `SHA512`). |
| `-t` | `Boolean` | Run in Test Mode (uses test paths). |
| `-T` | `Boolean` | Reset Test Mode data (clobbers TESTMODE IN/OUT folders). |
| `-v` | `Boolean` | Enable verbose `exiftool` output. |


---

## Variable Mapping (Argfiles)

Variables in your `.argfile.sh` templates must be prefixed and suffixed with underscores (e.g., `$_SRCDIR_`). These are whitelisted and injected during the `GenerateArgfileNew` function.

> **Note:** Use double quotes in the script's `TVARS` declaration for value replacement, and single quotes within argfiles to encapsulate `exiftool` specific options.


---

## Configuration

Update these variables within `un-EXIF-tense.sh` before first use:

* `exiftoolPATH`: Path to the `exiftool` binary.
* `exiftoolCONFIG`: Path to your `.ExifTool_config`.
* `ARGFiles_PATH`: Directory containing your series templates.
* `TESTMODE_*`: Paths for the testing sandbox.


