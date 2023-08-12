#!/bin/bash
source "createTable.sh"

# Function to check if a table exists in the directory
is_existing_table() {
  local table_name="$1"
  [ -f "database/$dbName/$table_name.txt" ]
}

# Function to update data in a table
update_table() {
  echo "Enter the name of the database:"
  read dbName

  if validate_db_name "$dbName" && [ -d "database/$dbName" ]; then
    echo "Connected to '$dbName' database."
    echo "Enter the name of the table to update data in:"
    read table_name

    if is_existing_table "$table_name"; then
      data_file="database/$dbName/$table_name.txt"
      num_records=$(wc -l < "$data_file")
      echo "Enter the id of the row to update:"
      read row_id

      if [[ $row_id -ge 1 && $row_id -le $((num_records - 2)) ]]; then
        col_names=($(head -n 1 "$data_file" | tr ':' '\n'))
        col_data=($(sed -n "$((row_id+2))p" "$data_file" | tr ':' '\n'))

        echo "Columns to update:"
        for ((i = 1; i < ${#col_names[@]}; i++)); do
          echo "$i. ${col_names[i]} (${col_data[i]})"
        done

        echo "Enter the column number to update:"
        read col_num

        if [[ $col_num -ge 1 && $col_num -lt ${#col_names[@]} ]]; then
          col_name="${col_names[$col_num]}"
          echo "Enter the new value for $col_name:"
          read new_value

          col_data[$col_num]=$new_value
          updated_row="${col_data[*]}"

          sed -i "$((row_id+2))s/.*/$updated_row/" "$data_file"
          echo "Row $row_id has been updated."
        else
          echo "Invalid column number. Update canceled."
        fi
      else
        echo "Invalid ID number. Update canceled."
      fi
    else
      echo "Table '$table_name' does not exist."
    fi
  else
    echo "Invalid database name or database does not exist."
  fi
}

