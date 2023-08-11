#!/bin/bash

create_table() {
    echo "Enter the name of the table:"
    read tableName

    # Check if table already exists
    if table_exists "$tableName"; then
        echo "Table '$tableName' already exists."
        return
    fi

    # Create a file for the table
    touch "database/$tableName.txt"

    # Create the id column as the primary key
    echo "id:int" >> "database/$tableName.txt"

    echo "Enter the number of fields:"
    read numFields

    echo "Primary Key: id"  # Display primary key in the table structure

    for ((i = 1; i <= numFields; i++)); do
        echo "Enter field $i information in the format 'name:type':"
        read fieldInfo

        IFS=':' read -ra fieldArray <<< "$fieldInfo"

        fieldName="${fieldArray[0]}"
        fieldType="${fieldArray[1]}"

        # Validate fieldType
        if [ "$fieldType" != "string" ] && [ "$fieldType" != "int" ]; then
            echo "Invalid field type. Please choose 'string' or 'int'."
            return
        fi

        # Append column details to the table file
        echo "${idCounter}=$i $fieldName:$fieldType" >> "database/$tableName.txt"
    done

    echo "Table '$tableName' is created."
    echo "Table Structure:"
    cat "database/$tableName.txt"
}

table_exists() {
    tableName="$1"
    if [ -f "database/$tableName.txt" ]; then
        return 0 # Table exists
    else
        return 1 # Table does not exist
    fi
}
