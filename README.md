# Un.EXIF.Tense - An exiftool helper system letting more accomplish more. 

Stressed out with the complexity of exiftool and its wonders, this  is a simple framework to use the full potential of exiftool, in a mortal time-frame and stress free. . ;)

###############################################################################
##* ARGFILE STRING REPLACEMENT VARS, DA GOOD STUFF
###############################################################################
 	
Exiftool, is a very particular application of genius, madness, and immense
concentration, focus, effort and masochism. At the least when I try to utilize it.
I spend as much time getting the formatting of the command and the right quoteing
that it exhausts me before I get to play with all its features.

The argfile simplifies commands and forgoes having to learn complex escaping of commands.
The exiftool switches function as expected without stress or worry... however there is one or two caveats.
However, argfiles cannot do substituion like a bash script, and variables must be exported to the environment to use them as well. This is less convienient than a script.

This is solved in a nice and easy way using envsubst and this script.

	Rules for creating your own variable replacements for argfiles
 	*#  Use double quotes if we are replacing values from in here.
 	# * Single quotes if encapsulating exiftool options.
 	# * Don't mix the two types.
 	# ! TODO We add prefix to exported variable to not clobber existing environtment variables.

So why the contorsion with renaming variables etc.
envsubst which assists us to replace variables, is hamfisted so we use a whitelist
building out the whitelist programmatically with sequenced variable names
gives the opportunity to add / adjust the program and template with minimal
addtional lines of code.
