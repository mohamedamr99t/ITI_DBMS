#!/bin/bash

# Check if the database directory exists, otherwise create it
if [ ! -d "database" ]; then
    mkdir "database"
    echo "Database directory created."
fi

# Function to validate database name
validate_db_name() {
    local dbName="$1"
    if [[ ! "$dbName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "-------------------------------------------------------------"
        echo "Invalid database name. Please start with a letter or underscore"
        echo "followed by letters, numbers, or underscores."
        echo "Follow the instructions above, Please try again."
        echo "-------------------------------------------------------------"
        return 1
    fi
    return 0
}

# Function to create a new database
create_database() {
    while true; do
        echo "Enter the name of the database:"
        echo "-------------------------------------------------------------"
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
          return
        fi
    done
    echo
}

# Function to list existing databases
# Function to list existing databases
list_databases() {
    while true; do
        echo "Enter the name of the database:"
        echo "-------------------------------------------------------------"
        read dbName
        if validate_db_name "$dbName"; then
            echo "Existing databases:"
            ls -d database/*/
            break
        else
         echo "Invalid database name."
        fi
    done
    echo
}

# Function to connect to a database
connect_to_database() {
    echo "Enter the name of the database you want to connect to:"
    read dbName
    if validate_db_name "$dbName"; then
        if [ -d "database/$dbName" ]; then
            cd "database/$dbName"
            echo "Connected to database '$dbName'."
        else
            echo "Database '$dbName' does not exist."
        fi
    else
        echo "Invalid database name."
    fi
    echo
}

# Function to drop a database
drop_database() {
    echo "Enter the name of the database you want to drop:"
    read dbName
    if validate_db_name "$dbName"; then
        if [ -d "database/$dbName" ]; then
            rm -r "database/$dbName"
            echo "Database '$dbName' dropped."
        else
            echo "Database '$dbName' does not exist."
        fi
    else
        echo "Invalid database name."
    fi
}

# Main menu
echo "Welcome to Database Management"
echo "***********************************************"

while true; do
    echo "Select an option:"
    echo "1. Create Database"
    echo "2. List Databases"
    echo "3. Connect To Database"
    echo "4. Drop Database"
    echo "5. Exit"
    read choice

    case $choice in
        1) create_database;;
        2) list_databases;;
        3) connect_to_database;;
        4) drop_database;;
        5) exit;;
        *) echo "Invalid choice, please select a valid option.";;
    esac
    echo
done
