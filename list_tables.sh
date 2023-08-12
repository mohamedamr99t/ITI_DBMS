#!/bin/bash

# Function to check if a table exists in the directory
is_existing_table() {
  local table_name="$1"
  if [ -f "database/$dbName/$table_name.txt" ]; then
    return 0
  else
    return 1
  fi
}

# Function to list all tables
list_all_tables() {
  echo "Listing all tables..."
  for tableFile in database/$dbName/*.txt; do
    tableName=$(basename "$tableFile" .txt)
    echo "- $tableName"
  done
}

# Function to list a specific table
list_specific_table() {
  echo "Enter the name of the table you want to list:"
  read tableName

  if is_existing_table "$tableName"; then
    echo "Listing '$tableName' table structure..."
    cat "database/$dbName/$tableName.txt"
  else
    echo "Table '$tableName' does not exist."
  fi
}

# Main menu
list_tables() {
  while true; do
    echo "Select an option:"
    echo "1. List All Tables"
    echo "2. List Specific Table"
    echo "3. Back to Main Menu"
    read choice

    case $choice in
      1) list_all_tables ;;
      2) list_specific_table ;;
      3) break ;;
      *) echo "Invalid choice, please select a valid option." ;;
    esac
    echo
  done
}
