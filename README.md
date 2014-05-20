steps-eclipse-builder
==================================

# Input Environment Variables
- CONCRETE_SOURCE_DIR
- CONCRETE_ACTION=[BUILD/DEBUG]
- CONCRETE_BUILD_TOOL: "ant" is the default; "gradle" is supported

# Output Environment Variables
(accessible for Steps running after this Step)

## if CONCRETE_ACTION == BUILD
- CONCRETE_BUILD_STATUS=[success/failed] 

## if CONCRETE_ACTION == DEBUG
- CONCRETE_DEBUG_STATUS=[success/failed]




Needed for android build

# http://zeroturnaround.com/rebellabs/java-build-tools-maven-gradle-and-ant-plus-the-dsl-vs-xml-debate/

——— ANT BUILD ———

.bash_profile-ba:

export JAVA_HOME=$(/usr/libexec/java_home)
export ANT_HOME=/usr/local/ant
export PATH=${PATH}:${ANT_HOME}/bin
export ANDROID_HOME=/Users/dev/adt/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export GRADLE_HOME=/Users/dev/tools/gradle
export PATH=${PATH}:${GRADLE_HOME}/bin

Projektnel:
target megfelelo beallitasa v az elvart SDK-nak fenn kell lennie
build.xml kell hozza - ANT-hoz


Reference libraries http://blog.standalonecode.com/?p=269

Analyze alapbol nincs benne, Sonar Ant Task-kal lehet
http://frommyworkshop.blogspot.hu/2011/04/analyse-with-ant-sonar-way.html


adt
ant tool


———— GRADLE BUILD ——————

gradle required http://www.gradle.org/downloads :)

http://www.vogella.com/tutorials/AndroidBuild/article.html




— — APP SIGNING ———
keytool
http://developer.android.com/tools/publishing/app-signing.html

-- NDK build : http://stackoverflow.com/questions/7432449/android-ndk-build-with-ant-script