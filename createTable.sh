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
        if [ -f "$PWD/$tableName.txt" ]; then
            echo "Table '$tableName' already exists."
        elif [ -d "database/$dbName" ]; then
            echo " Database '$dbName' does not exist."
            return 1
        else
            # Create the table file
            cd $PWD
            touch "${tableName}.txt"
            echo "Table '${tableName}' created."

            # Ask the user about the number of additional columns
            echo "Enter the number of columns for '$tableName':"
            read numColumns

            for ((i = 1; i <= $numColumns; i++)); do
                # Create metadata for the table with the primary key as the first column
              
                echo "Enter name for column $i:"
                read colName

                while true; do
                    echo "Enter type for column $colName (string or integer):"
                    read colType

                    if [ "$colType" == "string" ] || [ "$colType" == "integer" ]; then
                        if [ $i -eq 1 ]; then
                            tableMetadata+="Column No.${colNumber=1} called $colName is primary key\n\n"
                        fi
                        tableMetadata+="Column No.${colNumber=1}: name=$colName,type=$colType\n"
                        ((colNumber++))
                        break
                    else
                        echo "Invalid column type. Please enter 'string' or 'integer'."
                    fi
                done

            done

            echo -e "$tableMetadata" >"${tableName}.metadata"
            echo "Table metadata created for '${tableName}'."
            # Display the created table metadata
            echo -e "\nTable Metadata for '${tableName}':"
            echo -e "$tableMetadata"
        fi
    else
        echo -e "\nInvalid Table Name. \nPlease start with a letter or underscore followed by letters, numbers, or underscores."
    fi
}
