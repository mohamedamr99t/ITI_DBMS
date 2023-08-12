#!/bin/bash
source "createTable.sh"  

# Function to drop all tables
drop_all_tables() {
    read -p "Are you sure you want to drop ALL tables? (y/n) " confirm
    if [ "$confirm" = "y" ]; then
        rm database/*.txt
        echo "Dropped ALL tables."
    else
        echo "Operation cancelled."
    fi
}

# Function to drop a specific table
drop_specific_table() {
    echo "Enter the name of the table you want to drop:"
    read tableName

    if table_exists "$tableName"; then
        read -p "Are you sure you want to drop '$tableName' table? (y/n) " confirm
        if [ "$confirm" = "y" ]; then
            rm "database/$tableName.txt"
            echo "Dropped '$tableName' table."
        else
            echo "Operation cancelled."
        fi
    else
        echo "Table '$tableName' does not exist."
    fi
}

# Main menu
drop_table(){
while true; do
    echo "Select an option:"
    echo "1. Drop All Tables"
    echo "2. Drop Specific Table"
    echo "3. Back to Main Menu"
    read choice

    case $choice in
    1) drop_all_tables ;;
    2) drop_specific_table ;;
    3) break ;;
    *) echo "Invalid choice, please select a valid option." ;;
    esac
    echo
done
}