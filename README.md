steps-eclipse-builder
==================================

# Input Environment Variables
- CONCRETE_PROJECT_PATH
- CONCRETE_SCHEME
- CONCRETE_ACTION_BUILD or CONCRETE_ACTION_ANALYZE or CONCRETE_ACTION_ARCHIVE
- CONCRETE_CERTIFICATE_PASSPHRASE
- CONCRETE_CERTIFICATE_URL
- CONCRETE_PROVISION_URL
- CONCRETE_BUILD_TOOL: "xcodebuild" is the default; "xctool" is supported; CONCRETE_ARCHIVE_STATUS can only use "xcodebuild"

# Output Environment Variables
(accessible for Steps running after this Step)

## if CONCRETE_ACTION_BUILD
- CONCRETE_BUILD_STATUS=[success/failed] 

## if CONCRETE_ACTION_ANALYZE
- CONCRETE_ANALYZE_STATUS=[success/failed]

## if CONCRETE_ACTION_ARCHIVE
- CONCRETE_ARCHIVE_STATUS=[success/failed]
- CONCRETE_IPA_PATH
- CONCRETE_DSYM_PATH