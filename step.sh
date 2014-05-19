#!/bin/sh
# @Author: Tamas Szucs
# @Date:   2014-05-19 10:39:46
# @Last Modified by:   Tamas Szucs
# @Last Modified time: 2014-05-19 13:55:13

echo "$ cd $CONCRETE_SOURCE_DIR"
cd "$CONCRETE_SOURCE_DIR"

if [[ $CONCRETE_PROJECT_PATH == *".xcodeproj" ]]; then
  export XCODE_PROJECT_ACTION="-project"
elif [[ $CONCRETE_PROJECT_PATH == *".xcworkspace" ]]; then
  export XCODE_PROJECT_ACTION="-workspace"
else
  echo "Failed to get valid project file: $CONCRETE_PROJECT_PATH"
  exit 1
fi

projectdir="$(dirname "$CONCRETE_PROJECT_PATH")"
projectfile="$(basename "$CONCRETE_PROJECT_PATH")"
echo "$ cd $projectdir"
cd "$projectdir"