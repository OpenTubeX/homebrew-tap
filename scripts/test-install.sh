#!/bin/bash
set -euo pipefail

app='/Applications/OpenTubeX.app'
test -f "$app/Contents/Resources/app.asar"
test -x "$app/Contents/MacOS/OpenTubeX"
/usr/bin/codesign --verify --deep --strict "$app"
result="$(ELECTRON_RUN_AS_NODE=1 "$app/Contents/MacOS/OpenTubeX" -e 'process.stdout.write("opentubex-homebrew")')"
test "$result" = 'opentubex-homebrew'
