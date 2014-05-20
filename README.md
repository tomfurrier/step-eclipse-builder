steps-eclipse-builder
==================================

# Input Environment Variables
- CONCRETE_SOURCE_DIR
- CONCRETE_ACTION=[BUILD/DEBUG]
- CONCRETE_BUILD_TOOL: "ant" is the default; "gradle" is supported, "maven" is supported

# Output Environment Variables
(accessible for Steps running after this Step)

## if CONCRETE_ACTION == BUILD
- CONCRETE_BUILD_STATUS=[success/failed] 

## if CONCRETE_ACTION == DEBUG
- CONCRETE_DEBUG_STATUS=[success/failed]


---------------------------------------


xcode schema =~ build system specifikus config file (default ant-nal: build.xml, maven: pom.xml, gradle: build.gradle) 
eclipse config kulon (?)




virtualis gep fellovesekor erdemes lehet + idonkent: __android update sdk --no-ui --all --force --filter tool,platform-tool__
TODO csak az SDKt rakja fel, sample meg ilyeneket ne


Needed for android build

# http://zeroturnaround.com/rebellabs/java-build-tools-maven-gradle-and-ant-plus-the-dsl-vs-xml-debate/



# Downloads
- http://developer.android.com/sdk/index.html
- http://maven.apache.org/download.cgi
- http://ant.apache.org/bindownload.cgi
- http://www.gradle.org/downloads


.bash_profile-ba:

export JAVA_HOME=$(/usr/libexec/java_home)
export ANT_HOME=/usr/local/ant
export PATH=${PATH}:${ANT_HOME}/bin
export ANDROID_HOME=/Users/dev/adt/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
export GRADLE_HOME=/Users/dev/tools/gradle
export PATH=${PATH}:${GRADLE_HOME}/bin
export M2_HOME=/Users/dev/tools/maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH


gradle-nel nincs only build egybol deploy is lesz belole (APK keszul ??)


— ANT BUILD ———

Projektnel:
target megfelelo beallitasa v az elvart SDK-nak fenn kell lennie - mostmar telepiti a szkript ha nincs fenn
build.xml kell hozza - ANT-hoz


TODO Reference libraries http://blog.standalonecode.com/?p=269

Analyze alapbol nincs benne, Sonar Ant Task-kal lehet
http://frommyworkshop.blogspot.hu/2011/04/analyse-with-ant-sonar-way.html



TODO Ivy support?


— GRADLE BUILD ——————

based on: http://www.vogella.com/tutorials/AndroidBuild/article.html

- MAVEN BUILD ----------
based on: http://www.vogella.com/tutorials/AndroidBuildMaven/article.html

+


-- NDK build : http://stackoverflow.com/questions/7432449/android-ndk-build-with-ant-script

Android NDKt kulon le kell szedni hozza
http://lolengine.net/blog/2011/3/11/build-run-android-ndk-without-eclipse
ant-tal kulon parancs - ha nincs build.xml, amugy maven, gradle config fajlokba beepitheto


— APP SIGNING ———
	build system specifikusan is megadhato

	keytool
	http://developer.android.com/tools/publishing/app-signing.html


		keytool -genkey -v -keystore my-release-key.keystore
		-alias alias_name -keyalg RSA -keysize 2048 -validity 10000
