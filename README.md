# Terminal - Database

This program manages a database (stored in database.csv, with a schema defined in schema.json) that can be accessed
and updated through the terminal interface. Screenshots are provided at the bottom of this document.

# Example
![Alt text](screenshots/ruby-database.gif?raw=true "Demo")

# Installing

The program requires to Ruby gems, to install them, first install the `ruby` software package.

Then, run the following command:

`# gem install json terminal-table`

After the required packages are installed, run the following commands to launch the program:

```
$ git clone https://github.com/Jragoon/terminal-database-ruby

$ cd terminal-database-ruby

$ ruby database.rb
```

# Using the Terminal Database

Upon launching the program, you will see this interface:
![Alt text](screenshots/default_prompt.png?raw=true "Default Prompt")

If you removed the default `database.csv` file from the directory, the script will create a new one upon launch.

There are three main actions that can be done using the interface: inserting rows, deleting rows, and filtering rows.

All actions are done in the following format: `action (condition)` or `action(details)`

For example, to insert a new row given the schema in the picture, you would use something that fit the following format:

`insert (name, mail@provider.com, 20, 90, true)`

# The Schema

The schema properties are defined in the schema.json file. The schema.json file can be adjusted to fit any properties that
the user desires, however it must exist in order for the program to start. That is, the program cannot run without a defined
schema. Additionally, the properties defined in the schema must exist within the "fields" array, that name should not be
changed. The program expects all fields for the table to be objects in the fields array for the schema.json file.

# The Database

The database is the database.csv file found in the same directory. The program can start without this file- if it does not
exist, it will be created. The values for the database are naturally stored here as comma separated values, and will
be adjusted during the program's lifetime as users are inserted and deleted.

# Deleting Rows

Rows are not deleted specifically since they are not numbered, instead they are deleted based off of conditions (similar to
selection). For example, to delete honor students from the example table, you would run the command:

`delete (honor student = true)`

# Screenshots

![Alt text](screenshots/delete_part1.png?raw=true "Deleting...")
![Alt text](screenshots/delete_part2.png?raw=true "Deleted!")
![Alt text](screenshots/insert_part1.png?raw=true "Inserting...")
![Alt text](screenshots/insert_part2.png?raw=true "Inserted!")
![Alt text](screenshots/age_query.png?raw=true "Age Query")
