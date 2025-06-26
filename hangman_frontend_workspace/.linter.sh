#!/bin/bash
cd /home/kavia/workspace/code-generation/hangmanquest-74403-1efa6c04/hangman_frontend_workspace/hangman_frontend
npm run lint
ESLINT_EXIT_CODE=$?
npm run build
BUILD_EXIT_CODE=$?
if [ $ESLINT_EXIT_CODE -ne 0 ] || [ $BUILD_EXIT_CODE -ne 0 ]; then
   exit 1
fi

