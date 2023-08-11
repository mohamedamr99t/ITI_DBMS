#!/bin/bash

# Check if the database directory exists, otherwise create it
if [ ! -d "database" ]; then
    mkdir "database"
    echo "Database directory created."
fi

# Function to create a new database
create_database() {
    echo "Enter the name of database"
    read dbName
    if [ -d "database/$dbName" ]; then
        echo "Database '$dbName' already exists."
    else
        mkdir "database/$dbName"
        echo "Database '$dbName' is created."
    fi
}

# Function to list existing databases
list_databases() {
    echo "Existing databases:"
    ls -d database/*/
}

# Function to connect to a database
connect_to_database() {
    echo "Enter the name of the database you want to connect to:"
    read dbName
    if [ -d "database/$dbName" ]; then
        cd "database/$dbName"
        echo "Connected to database '$dbName'."
        # ---------------------------------You can add more logic here for interacting with tables/files.
        
    else
        echo "Database '$dbName' does not exist."
    fi
}

# Function to drop a database
drop_database() {
    echo "Enter the name of the database you want to drop:"
    read dbname
    if [ -d "database/$dbName" ]; then
        rm -r "database/$dbName"
        echo "Database '$dbName' dropped."
    else
        echo "Database '$dbName' does not exist."
    fi
}

# Main menu
while true; do
    echo "Main Menu:"
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
done
