#!/bin/bash

echo "Running tests..."

if [ -f index.html ]
then
  echo "Test Passed"
  exit 0
else
  echo "Test Failed"
  exit 1
fi
