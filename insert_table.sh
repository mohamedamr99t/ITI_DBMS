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

# Function to insert data into a table
insert_table() {
  echo "Enter the name of the database:"
  read dbName

  if validate_db_name "$dbName"; then
    if [ -d "database/$dbName" ]; then
      echo "Connected to '$dbName' database."
      echo "Enter the name of the table to insert data into:"
      read table_name

      if is_existing_table "$table_name"; then
        create_script="database/$dbName/$table_name.txt"
        col_names=$(head -n 1 "$create_script" | tr ':' ' ')

        data_file="database/$dbName/$table_name.txt"
        if [ -f "$data_file" ]; then
          # Get the last id
          last_id=$(tail -n 1 "$data_file" | cut -d ':' -f 1)
          new_id=$((last_id + 1))
        else
          new_id=1
        fi

        # Get data for other columns
        col_data="$new_id:"
        for col_name in $col_names; do
          if [ "$col_name" != "id" ]; then
            read -p "Enter data for $col_name: " col_data_value
            col_data+="$col_data_value:"
          fi
        done

        # Append data to the existing file
        echo "$col_data" >> "$data_file"

        echo "Data inserted into '$table_name' successfully."
      else
        echo "Table '$table_name' does not exist."
      fi
    else
      echo "Database '$dbName' does not exist."
    fi
  else
    echo "Invalid database name. Please try again."
  fi
}
