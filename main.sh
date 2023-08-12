#!/bin/bash
source "createTable.sh"
source "list_tables.sh"
source "drop_tables.sh"
source "insert_table.sh"
source "select_tables.sh"
source "delete_table.sh"
source "update_tables.sh"

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
    return 0
}

# Function to create a new database
create_database() {
  while true; do
    echo "Enter the name of the database:" 
    echo "_____________________________"
    read dbName
    
    if validate_db_name "$dbName"; then
      if [ -d "database/$dbName" ]; then
        echo "Database '$dbName' already exists."
      else
        mkdir "database/$dbName" 
        echo "Database '$dbName' is created."
      fi
      # Break the loop if the user enters a valid database name  
      break
      
    else
      echo "Invalid database name. Please try again."
      echo "1. Try again"
      echo "2. Return to main menu"
      read choice
      if [ "$choice" = "2" ]; then
        return
      fi
    fi
  
  done

}
# List databases
list_databases() {

  echo "Listing databases..."
  
  if [ -z "$(ls -A database/)" ]; then
    echo "No databases found."

  else
    for db in database/*/; do
      echo "- $(basename "$db")"
    done
  
  fi

  echo "1. List databases again"
  echo "2. Return to main menu"

  read choice

  if [ "$choice" = "2" ]; then
    return
  fi

}
# Function to drop a database
drop_database() {

  echo "1. Drop single database"
  echo "2. Drop all databases"
  echo "3. Return to main menu"

  read -p "Select an option: " choice

  if [ "$choice" = "1" ]; then

    # Original logic to drop single database 
    echo "Enter name of database to drop:"
    read dbName
    
    if validate_db_name "$dbName"; then
    
      if [ -d "database/$dbName" ]; then
        rm -r "database/$dbName"
        echo "Dropped database $dbName."
      else
        echo "Database $dbName does not exist."
      fi
      
    else
      echo "Invalid database name."
    fi

  elif [ "$choice" = "2" ]; then

    # Logic to drop all databases
    read -p "Are you sure you want to drop ALL databases? (y/n) " confirm
    
    if [ "$confirm" = "y" ]; then
      rm -r database/*
      echo "Dropped ALL databases."
    else
      echo "Operation cancelled."
    fi

  elif [ "$choice" = "3" ]; then
    return

  else
    echo "Invalid choice."

  fi

}

# Function to connect to a database
connect_to_database() {
    echo "Enter the name of the database you want to connect to:"
    read dbName
    if validate_db_name "$dbName"; then
        if [ -d "database/$dbName" ]; then
            echo "Connected to '$dbName' database."
            while true; do
                echo "Choose an option:"
                echo "1. Create Table"
                echo "2. List Tables"
                echo "3. Drop Table"
                echo "4. Insert into Table"
                echo "5. Select From Table"
                echo "6. Delete From Table"
                echo "7. Update Table"
                echo "8. Back to Main Menu" 
                read dbChoice

                case $dbChoice in
                    1) create_table ;;
                    2) list_tables ;;
                    3) drop_table ;;
                    4) insert_table ;;
                    5) select_table ;;
                    6) delete_from_table ;;
                    7) update_table ;;
                    8)
                        echo "Disconnected from database '$dbName'."
                        break
                        ;;
                    *)
                        echo "Invalid choice. Please enter a valid option."
                        ;;
                esac
            done
        else
            echo "Database '$dbName' does not exist."
        fi
    else
        echo "Invalid database name. Please try again."
    fi
}

# Main menu
echo "Welcome to Database Management"
echo "__________________________________________________"

while true; do
    echo "Select an option:"
    echo "1. Create Database"
    echo "2. List Databases"
    echo "3. Connect To Database"
    echo "4. Drop Database"
    echo "5. Exit"
    read choice

    case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_to_database ;;
        4) drop_database ;;
        5) exit ;;
        *) echo "Invalid choice, please select a valid option." ;;
    esac
    echo
done
