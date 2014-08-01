#!/bin/bash

if [ -z ${PROCESSING_PATH} ]; then
  echo "No PROCESSING_PATH environment variable detected"
  echo "1. Open Processing."
  echo "2. Processing -> Preferences (Command + ,)."
  echo "3. Sketchbook Location is what you're looking for."
  echo "4. In your shell RC file, create that environment variable!"
  exit 1
fi

if [ ! -d ${PROCESSING_PATH}/libraries/gifAnimation ]; then
  echo "---- Installing gifAnimation ----"
  git clone git@github.com:extrapixel/gif-animation.git ./gifAnimation
  mv ./gifAnimation/gifAnimation ${PROCESSING_PATH}/libraries/.
  rm -rf ./gifAnimation
fi
