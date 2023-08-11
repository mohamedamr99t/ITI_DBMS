#!/bin/bash

# Function to interact with a connected database
interact_with_database() {
 while true; do
        echo "Connected to database '$dbName'."
        echo "Select an option:"
        echo "1. Create Table"
        echo "2. List Tables"
        echo "3. Drop Table"
        echo "4. Insert into Table"
        echo "5. Select From Table"
        echo "6. Delete From Table"
        echo "7. Update Table"
        echo "8. Exit"
        read dbChoice

        case $dbChoice in
            1) echo "Create Table";;    
            2) echo "List Tables";;        
            3) echo "Drop Table";;         
            4) echo "Insert into Table";;  
            5) echo "Select From Table";; 
            6) echo "Delete From Table";;  
            7) echo "Update Table";;       
            8) break;;                    
            *) echo "Invalid choice, please select a valid option.";;
        esac
        echo
    done
}