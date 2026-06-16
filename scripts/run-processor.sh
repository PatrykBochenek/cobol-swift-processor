#!/usr/bin/env sh
set -eu

BATCH_FILE="${BATCH_FILE:-data/input/messages/batch.txt}"

echo "Building COBOL programs..."
make -C cobol all

if [ -x "cobol/bin/IBAN-CHECK-HARNESS" ]; then
  echo "Running IBAN harness..."
  ./cobol/bin/IBAN-CHECK-HARNESS
else
  echo "IBAN harness not found, skipping harness run."
fi

echo "Container runtime is ready."
echo "Expected batch file: ${BATCH_FILE}"
if [ -f "${BATCH_FILE}" ]; then
  echo "Batch file found."
else
  echo "Batch file not found yet."
fi
