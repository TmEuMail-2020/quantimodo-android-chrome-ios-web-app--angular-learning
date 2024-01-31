#!/bin/sh

#####################
# Make the ipa file #
#####################
OUTPUTDIR="$PWD/platforms/ios/build/device"

xcrun -log -sdk iphoneos \
PackageApplication -v "$OUTPUTDIR/$APP_DISPLAY_NAME.app" \
-o "$OUTPUTDIR/$APP_DISPLAY_NAME.ipa"

/usr/bin/zip --verbose --recurse-paths "$OUTPUTDIR/$APP_DISPLAY_NAME.dsym.zip" "$OUTPUTDIR/$APP_DISPLAY_NAME.app.dsym"

echo "EXECUTING COMMAND: security delete-keychain ios-build.keychain"
security delete-keychain ios-build.keychain

echo "EXECUTING COMMAND: pilot upload -u ${FASTLANE_USER} -i "$OUTPUTDIR/$APP_DISPLAY_NAME.ipa" -a ${APP_IDENTIFIER} -p ${APPLE_ID} --verbose"
pilot upload -u ${FASTLANE_USER} -i "$OUTPUTDIR/$APP_DISPLAY_NAME.ipa" -a "${APP_IDENTIFIER}" -p "${APPLE_ID}" --verbose
#echo "Watching for Waiting for iTunes Connect to finish processing the new build"
#until pilot upload -u ${FASTLANE_USER} -i "${PWD}/build/${APP_DISPLAY_NAME}.ipa" -a "${APP_IDENTIFIER}" -p "${APPLE_ID}" --verbose | grep -m 1 "Waiting for iTunes Connect to finish processing the new build"; do : ; done


# pilot upload -u ios@quantimodo.com -i "MoodiModo.ipa" -a "com.quantimodo.moodimodoapp" -p "1046797567" --verbose

# until my_cmd | grep -m 1 "String Im Looking For"; do : ; done

#    -u, --username STRING Your Apple ID Username (PILOT_USERNAME)
#    -a, --app_identifier STRING The bundle identifier of the app to upload or manage testers (optional) (PILOT_APP_IDENTIFIER)
#    -i, --ipa STRING     Path to the ipa file to upload (PILOT_IPA)
#    -w, --changelog STRING Provide the what's new text when uploading a new build (PILOT_CHANGELOG)
#    -s, --skip_submission [VALUE] Skip the distributing action of pilot and only upload the ipa file (PILOT_SKIP_SUBMISSION)
#    -p, --apple_id STRING The unique App ID provided by iTunes Connect (PILOT_APPLE_ID)
#    --distribute_external [VALUE] Should the build be distributed to external testers? (PILOT_DISTRIBUTE_EXTERNAL)
#    -f, --first_name STRING The tester's first name (PILOT_TESTER_FIRST_NAME)
#    -l, --last_name STRING The tester's last name (PILOT_TESTER_LAST_NAME)
#    -e, --email STRING   The tester's email (PILOT_TESTER_EMAIL)
#    -c, --testers_file_path STRING Path to a CSV file of testers (PILOT_TESTERS_FILE)
#    -k, --wait_processing_interval INTEGER Interval in seconds to wait for iTunes Connect processing (PILOT_WAIT_PROCESSING_INTERVAL)
#    -q, --team_id [VALUE] The ID of your team if you're in multiple teams (PILOT_TEAM_ID)
#    -r, --team_name STRING The name of your team if you're in multiple teams (PILOT_TEAM_NAME)
#    --verbose
#    -h, --help           Display help documentation
#    -v, --version        Display version information