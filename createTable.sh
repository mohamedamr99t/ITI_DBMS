#!/bin/bash
# Check if the database directory exists, otherwise create it
if [ ! -d "database" ]; then
    mkdir "database"
    echo "Database directory created."
fi
# Function to validate database name
validate_db_name() {
    dbName="$1"
    if [[ ! "$dbName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo -e "\nInvalid database name.\nPlease start with a letter or underscore"
        echo "followed by letters, numbers, or underscores."
        echo "Follow the instructions above, Please try again."
        echo "__________________________________________________"
        return 1
    fi  
}
# Function to generate create script
create_table() {
  # Get table name
  read -p "Enter name of table: " table_name

  # Validate table name
  if [[ ! $table_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    echo "Error: Invalid table name"
    return 1
  fi

  # Check if the table name is redundant
  if is_existing_table "$table_name"; then
    echo "Error: Table name '$table_name' already exists."
    return 1
  fi

  # Get number of columns (excluding 'id')
  read -p "Enter number of columns (excluding 'id'): " num_cols

  # Validate number of columns
  if ! [[ $num_cols =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid number of columns"
    return 1
  fi

  # Initialize column names, types, and data with default 'id' column
  col_names="id:"
  col_types="int:"
  col_data="1:"

  # Loop through columns to get details
  for (( i=2; i<=$num_cols+1; i++ )); do
    # Get column name
    read -p "Enter name of column $i: " col_name

    # Validate column name
    if [[ ! $col_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
      echo "Error: Invalid column name"
      return 1
    fi

    # Get column type
    read -p "Enter type of column $i (int|string): " col_type

    # Validate column type
    if [[ ! $col_type =~ ^(int|string)$ ]]; then
      echo "Error: Invalid column type"
      return 1
    fi

    if [[ $col_type == "int" ]]; then
      # Get column data (integer validation)
      while true; do
        read -p "Enter data for column $col_name: " col_data_value
        if ! [[ $col_data_value =~ ^[0-9]+$ ]]; then
          echo "Error: Invalid data. Expected an integer for 'int' type column."
        else
          break
        fi
      done
    else
      # Get column data (string type)
      read -p "Enter data for column $col_name: " col_data_value
    fi

    # Add column name, type, and data to respective variables
    col_names+="$col_name:"
    col_types+="$col_type:"
    col_data+="$col_data_value:"

  done


  # Write column names, types, and data horizontally to a file
  echo "$col_names" > "database/$dbName/$table_name.txt"
  echo "$col_types" >> "database/$dbName/$table_name.txt"
  echo "$col_data" >> "database/$dbName/$table_name.txt"

  echo "Create script '$table_name.txt' generated and saved successfully."
  echo "Note: The 'id' column is the primary key of the table."
}
