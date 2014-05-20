#!/bin/sh
# @Author: Tamas Szucs
# @Date:   2014-05-19 10:39:46
# @Last Modified by:   Tamas Szucs
# @Last Modified time: 2014-05-20 17:07:58

echo "$ cd $CONCRETE_SOURCE_DIR"

cd "$CONCRETE_SOURCE_DIR"


# default action = BUILD
if [[ ! $CONCRETE_ACTION ]]; then
	CONCRETE_ACTION="BUILD"
fi

if [[ $CONCRETE_ACTION -ne "BUILD" &&  $CONCRETE_ACTION -ne "DEBUG" && $CONCRETE_ACTION -ne "RELEASE" && $CONCRETE_ACTION -ne "ANALYZE" ]]; then
	echo "Error: not a valid CONCRETE_ACTION value: $CONCRETE_ACTION. Terminating..."
	echo "export CONCRETE_BUILD_STATUS=\"failed\"" >> ~/.bash_profile
	echo "CONCRETE_BUILD_STATUS=\"failed\""
	exit 1
fi

# upgraded - passed as parameter, check against its value instead 
# of setting multiple env vars
# values: 
#	BUILD,
#	DEBUG,
#	RELEASE (todo, not yet added),
#	ANALYZE(also todo, no built-in support)
echo "CONCRETE_ACTION: $CONCRETE_ACTION" 

# default build tool = ant
if [[ ! $CONCRETE_BUILD_TOOL ]]; then
	CONCRETE_BUILD_TOOL="ant"
fi

if [[ $CONCRETE_BUILD_TOOL -ne "ant" &&  $CONCRETE_BUILD_TOOL -ne "gradle" && $CONCRETE_BUILD_TOOL -ne "maven" ]]; then
	echo "Error: not a valid CONCRETE_BUILD_TOOL value: $CONCRETE_BUILD_TOOL. Terminating..."
	echo "export CONCRETE_BUILD_STATUS=\"failed\"" >> ~/.bash_profile
	echo "CONCRETE_BUILD_STATUS=\"failed\""
	exit 1
fi

echo "CONCRETE_BUILD_TOOL: $CONCRETE_BUILD_TOOL"



# ant initializations
if [[ $CONCRETE_BUILD_TOOL == "ant" ]]; then
	echo "Cleaning first...."
	ant clean

	# TODO check if AndroidManifest.xml file name is constant?
	sdk_ver="android-$(grep -o 'android:targetSdkVersion="[^"]*"' AndroidManifest.xml | cut -f2 -d'"' )"

	echo "SDK version=$sdk_ver"

	# creates build.xml and local.properties required by ant
	android update project --path . --target $sdk_ver
	update_result=$?

	# if sdk is not installed install it
	if [ $update_result -ne 0 ]; then
		echo "The target sdk is not installed, downloading and installing now...."
		echo yes | android update sdk -u -a --filter $sdk_ver
		android update project --path . --target $sdk_ver
	fi

	# TODO reference other libraries http://blog.standalonecode.com/?p=269
fi

#################
##  Building...
#################

if [[ $CONCRETE_ACTION == "BUILD" ]]; then
	# if only build
	if [[ $CONCRETE_BUILD_TOOL == "ant" ]]; then
		ant
	elif [[ $CONCRETE_BUILD_TOOL == "gradle" ]]; then
		gradle clean build
		# TODO not working, editing gradle-wrapper.properties doesnt work
	elif [[ $CONCRETE_BUILD_TOOL == "gradle" ]]; then
		mvn clean compile
	fi
	
	action_result=$?

	if [ $action_result -ne 0 ]; then
		echo "export CONCRETE_BUILD_STATUS=\"failed\"" >> ~/.bash_profile
		echo "CONCRETE_BUILD_STATUS=\"failed\""
	else
		echo "export CONCRETE_BUILD_STATUS=\"success\"" >> ~/.bash_profile
		echo "CONCRETE_BUILD_STATUS=\"success\""
	fi


elif [[ $CONCRETE_ACTION == "DEBUG" ]]; then
	# creating aligned and debug signed apk
	if [[ $CONCRETE_BUILD_TOOL == "ant" ]]; then
		ant debug
	elif [[ $CONCRETE_BUILD_TOOL == "gradle" ]]; then
		gradle clean build
		# TODO not working, editing gradle-wrapper.properties doesnt work
	elif [[ $CONCRETE_BUILD_TOOL == "maven" ]]; then
		mvn clean package
	fi

	action_result=$?

	if [ $action_result -ne 0 ]; then
		echo "export CONCRETE_DEBUG_STATUS=\"failed\"" >> ~/.bash_profile
		echo "CONCRETE_BUILD_STATUS=\"failed\""
	else
		echo "export CONCRETE_DEBUG_STATUS=\"success\"" >> ~/.bash_profile
		echo "CONCRETE_BUILD_STATUS=\"success\""
	fi

elif [[ $CONCRETE_ACTION == "RELEASE" ]]; then
	# TODO
	# create unsigned and unaligned APK, need to be aligned and signed manually
	if [[ $CONCRETE_BUILD_TOOL == "ant" ]]; then
		ant release
	elif [[ $CONCRETE_BUILD_TOOL == "gradle" ]]; then
		#gradle clean build
		echo 'TODO not working, editing gradle-wrapper.properties doesnt work'
	elif [[ $CONCRETE_BUILD_TOOL == "maven" ]]; then
		mvn clean package
	fi

elif [[ $CONCRETE_ACTION == "ANALYZE" ]]; then
	# TODO
	# supported only by using external tool. maybe another step
	echo "Action currently not supported! Terminating..."
	exit 1
fi

exit $action_result
