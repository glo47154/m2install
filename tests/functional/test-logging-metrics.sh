#!/usr/bin/env bash
source tests/functional.sh

export M2INSTALL_CSV_LOG="$SANDBOX_PATH/m2install.csv"
OUTPUT=$(${BIN_M2INSTALL} --force --source composer -v 2.3.7 2>error.log)

CURRENT="$(cat $M2INSTALL_CSV_LOG)"

assertContains "$CURRENT" "datetime, mode, home_response_code, home_url, admin_response_code, admin_url, duration, user, dir, script, args" "Csv File header is not match"
assertContains "$CURRENT" "install, [0,2]00, http://${CURRENT_DIR_NAME}.127.0.0.1.nip.io/, [0,2,3]0[0,2], http://${CURRENT_DIR_NAME}.127.0.0.1.nip.io/admin, [0-9]*, $(whoami), $(pwd), $BIN_M2INSTALL, \"--force --source composer -v 2.3.7\"" "CSV File row is not match"

