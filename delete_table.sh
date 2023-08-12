#!/bin/bash
source "createTable.sh"

# Function to check if a table exists in the directory
is_existing_table() {
  local table_name="$1"
  if [ -f "database/$dbName/$table_name.txt" ]; then
    return 0
  else
    return 1
  fi
}

# Function to delete data from a table
delete_from_table() {
  echo "Enter the name of the database:"
  read dbName

  if validate_db_name "$dbName" && [ -d "database/$dbName" ]; then
    echo "Connected to '$dbName' database."
    echo "Enter the name of the table to delete data from:"
    read table_name

    if is_existing_table "$table_name"; then
      data_file="database/$dbName/$table_name.txt"
      num_records=$(wc -l < "$data_file")
      echo "Select an option:"
      echo "1. Delete Specific Line"
      echo "2. Delete Specific Column"
      echo "3. Delete All Data"
      echo "4. Back to Menu"
      read choice

      case $choice in
        1)
          echo "Enter the id of the line to delete:"
          read line_id
          if [[ $line_id -ge 1 && $line_id -le $((num_records - 2)) ]]; then
            sed -i "$((line_id+2))d" "$data_file"
            echo "Line $line_id has been deleted."
          else
            echo "Invalid ID number. Deletion canceled."
          fi
          ;;
        2)
          echo "Enter the number of the column to delete:"
          read col_num
          if [[ $col_num -ge 2 && $col_num -lt $(($(awk -F: '{print NF; exit}' "$data_file")+2)) ]]; then
            awk -v col_num="$col_num" 'BEGIN {FS = OFS = ":"} {if (NF >= col_num) $col_num = ""; $1=$1}1' "$data_file" > tmp_file && mv tmp_file "$data_file"
            echo "Column $col_num has been deleted."
          else
            echo "Invalid column number. Deletion canceled."
          fi
          ;;
        3)
          echo "Are you sure you want to delete all data? (y/n)"
          read confirmation
          if [[ $confirmation == "y" || $confirmation == "Y" ]]; then
            sed -i '3,$d' "$data_file"
            echo "All data has been deleted."
          else
            echo "Deletion canceled."
          fi
          ;;
        4)
          return
          ;;
        *)
          echo "Invalid choice."
          ;;
      esac
    else
      echo "Table '$table_name' does not exist."
    fi
  else
    echo "Invalid database name or database does not exist."
  fi
}
