#!/bin/bash

list_table() {
  echo "Listing tables..."
  echo ".................."

  # Check if there are any table metadata files
  if [ -z "$(ls -A *.metadata *.txt)" ]; then
    echo "No tables found."
  else
    # Loop through table metadata files and print each table name
    for metadataFile in *.metadata; do
      tableName=$(basename "$metadataFile" .metadata)
      echo "$tableName"
    done
  fi
}