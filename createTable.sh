#!/bin/bash

validate_table_name() {
    local tableName="$1"
    if [[ ! "$tableName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        return 1
    fi
    return 0
}

create_table() {
    echo "Enter the name of the new table:"
    read tableName

    if validate_table_name "$tableName"; then
        if [ -f "database/$dbName/table_$tableName.txt" ]; then
            echo "Table '$tableName' already exists."
        else
            # To prevent the error of touch file in non-existing directory
            cd $PWD
            echo "Current directory: $(pwd)"

            touch "${tableName}.txt"
            echo "Table '${tableName}' created."

            # Ask the user about the number of additional columns
            echo "Enter the number of columns for '$tableName':"
            read numColumns

            # Create metadata for the table with the primary key as the first column
            tableMetadata="primary_key\n"
            tableMetadata+="name=pk,type=integer\n"

            for ((i = 1; i <= $numColumns; i++)); do
                echo "Enter name for column $i:"
                read colName

                while true; do
                    echo "Enter type for column $colName (string or integer):"
                    read colType

                    if [ "$colType" == "string" ] || [ "$colType" == "integer" ]; then
                        tableMetadata+="name=$colName,type=$colType\n"
                        break
                    else
                        echo "Invalid column type. Please enter 'string' or 'integer'."
                    fi
                done
            done

            echo -e "$tableMetadata" > "${tableName}.metadata"
            echo "Table metadata created for '${tableName}'."
             # Display the created table metadata
            echo -e "\nTable Metadata for '${tableName}':"
            echo -e "$tableMetadata"
        fi
    else
        echo -e "\nInvalid Table Name. \nPlease start with a letter or underscore followed by letters, numbers, or underscores."
    fi
}
