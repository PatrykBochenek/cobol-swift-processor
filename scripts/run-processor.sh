#!/usr/bin/env sh
set -eu

BATCH_FILE="${BATCH_FILE:-data/input/messages/batch.txt}"

echo "Building COBOL programs..."
make -C cobol all

echo "Container runtime is ready."
echo "Expected batch file: ${BATCH_FILE}"
if [ -f "${BATCH_FILE}" ]; then
  echo "Batch file found."
else
  echo "Batch file not found yet."
fi
