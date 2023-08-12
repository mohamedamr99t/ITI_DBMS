# ITI_DBMS
Database Management Script

This Bash script provides a simple database management system with the following functionalities:

1. Create a Database:
   - Enter a new database name.
   - Validates the name and creates a new database directory if it doesn't exist.

2. List Databases:
   - Lists all existing databases.

3. Connect to a Database:
   - Enter the name of an existing database.
   - Validates the name and connects to the selected database.
   - Provides a menu to perform various operations on the connected database.

4. Drop a Database:
   - Choose whether to drop a single database or all databases.
   - If dropping a single database, enter the name of the database to drop.
   - Validates input and removes the specified database directory.

5. Exit:
    - Terminate the script and exit the database management system.
      
Tables Menu:
- Create Table: Define a new table with columns and data types.
- List Tables: Display the list of tables within the connected database.
- Drop Table: Delete a table from the connected database.
- Insert into Table: Add new rows to a table in the database.
- Select From Table: Retrieve and display data from a table.
- Delete From Table: Remove specific rows or columns from a table.
- Update Table: Modify data in a table based on specified conditions.
- Back to Main Menu: Return to the main menu.

Note: 
- The script utilizes modular design with separate source files for each functionality.
- Error handling and validation are implemented for database and table operations.
- The script provides a user-friendly interface to interact with the database system.



