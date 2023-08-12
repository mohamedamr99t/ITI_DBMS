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

# Function to select and print data from a table
select_table() {
  echo "Enter the name of the database:"
  read dbName

  if validate_db_name "$dbName" && [ -d "database/$dbName" ]; then
    echo "Connected to '$dbName' database."
    echo "Enter the name of the table to select data from:"
    read table_name

    if is_existing_table "$table_name"; then
      data_file="database/$dbName/$table_name.txt"
      while true; do
        echo "Select an option:"
        echo "1. ALL Data"
        echo "2. Specific Row"
        echo "3. Specific Columns"
        echo "4. Back to Menu"
        read choice

        case $choice in
          1)
            sed -n '3,$p' "$data_file"
            ;;
          2)
            echo "Enter the id of the row to select:"
            read row_id
            sed -n "$((row_id+2))p" "$data_file"
            ;;
          3)
            col_names=($(head -n 1 "$data_file" | tr ':' '\n'))

            echo "Available columns:"
            for ((i = 0; i < ${#col_names[@]}; i++)); do
              echo "$((i + 1)). ${col_names[i]}"
            done

            echo "Select column's number:"
            read -a selected_columns

            echo "Selected data:"
            awk -v indices="${selected_columns[*]}" -F: 'BEGIN {split(indices, arr, " ");} {for (i in arr) printf "%s ", $arr[i]; printf "\n";}' "$data_file" | sed -n '3,$p'
            ;;
          4)
            break
            ;;
          *)
            echo "Invalid choice."
            ;;
        esac
      done
    else
      echo "Table '$table_name' does not exist."
    fi
  else
    echo "Invalid database name or database does not exist."
  fi
}

