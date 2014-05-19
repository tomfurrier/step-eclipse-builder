#!/bin/sh
# @Author: Tamas Szucs
# @Date:   2014-05-19 10:39:46
# @Last Modified by:   Tamas Szucs
# @Last Modified time: 2014-05-19 17:22:13

echo "$ cd $CONCRETE_SOURCE_DIR"

cd "$CONCRETE_SOURCE_DIR"


# TODO branch ant and gradle builds - maybe in a separate step
# default should be ant with 'android update ....' command

ant clean
# TODO get target sdk version from .manifest file
# --target 1 is the id from 'android list targets'
android update project --path . --target 1

# TODO reference other libraries http://blog.standalonecode.com/?p=269




# default action == BUILD
echo $CONCRETE_ACTION
if [[ ! $CONCRETE_ACTION ]]; then
	CONCRETE_ACTION="BUILD"
fi

# upgraded - passed as parameter, check against its value instead 
# of setting multiple env vars
# values: 
#	BUILD,
#	DEBUG,
#	RELEASE (todo, not yet added),
#	ANALYZE(also todo, no built-in support)
echo "CONCRETE_ACTION: $CONCRETE_ACTION" 



if [[ $CONCRETE_ACTION == "BUILD" ]]; then
	# if only build
	ant
elif [[ $CONCRETE_ACTION == "DEBUG" ]]; then
	# creating aligned and debug signed apk
	ant debug
elif [[ $CONCRETE_ACTION == "RELEASE" ]]; then
	# TODO
	# create unsigned and unaligned APK, need to be aligned and signed manually
	echo "Action currently not supported! Terminating..."
	exit 1
elif [[ $CONCRETE_ACTION == "ANALYZE" ]]; then
	# TODO
	# supported only by using external tool. maybe another step
	echo "Action currently not supported! Terminating..."
	exit 1
fi

