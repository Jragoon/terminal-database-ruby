require 'terminal-table'
require 'json'

#-- Read schema file containing Fields object and obtain properties --#
parsed = JSON.parse(File.read("schema.json"));
properties = parsed["fields"];

#--   Example Schema result   --#
#   schema["Name"]  = "string"  #
#   schema["Age"]   = "integer" #
schema = Hash.new
properties.each do |property|
    schema[property["name"]] = property["type"]
end

#-- Read database file by line into array --#
data = []
if not File.exist?("database.csv")
    database = File.new("database.csv", "w")
    database.close
end
database = File.open("database.csv", "r")
database.each_line do |line|
    row = line.split(",")
    data << row
end
database.close

def create_terminal_table(headings, data)
    return Terminal::Table.new :title => "Database", :headings => headings do |t|
        data.each do |row|
            t.add_row row
        end
        t.style = {:all_separators => true}
    end
end

def print_examples(schema)
    insert_example = create_insert_example(schema.values)
    delete_example = "Example deletion:  delete where (age < 18)"
    filter_example = "Example selection: select where (honor student = true)"
    puts insert_example
    puts delete_example
    puts filter_example
end

def is_integer(num)
    Integer(num) rescue return false
    return true
end

def is_float(num)
    Float(num) rescue return false
    return true
end

def is_boolean(bool)
    bool == "true" || bool == "false"
end

def insert_data(query, schema, data)
    new_row = query.split("(").last.split(")").first.delete(' ').downcase
    split_row = new_row.split(",")
    split_row.zip(schema.values).each do |value, type|
        case type
        when "integer"
            if not is_integer(value)
                puts "#{value} is not an integer."
                return data
            end
        when "float"
            if not is_float(value)
                puts "#{value} is not a float."
                return data
            end
        when "boolean"
            if not is_boolean(value)
                puts "#{value} is not a boolean."
                return data
            end
        end
    end

    #-- The data is valid. Append it to the file and return the updated data set --#
    open("database.csv", "a") { |file|
        file.puts new_row + "\n"
    }
    data << split_row
    puts "Row added succesfully."
    return data
end

def handle_input(query, schema, data)
    query = query.downcase
    if query.include? "insert"
        data = insert_data(query, schema, data)
    elsif query.include? "delete"
        puts "Deleting"
    elsif query.include? "select"
        puts "Filtering"
    elsif query == "q" || query == "quit" || query == "exit"
        puts "Quitting..."
    elsif query == "help" || query == "h"
        print_examples(schema)
    else
        puts "Command not received. Please see the example"
    end
    return data
end

def create_insert_example(types)
    example = "Example insertion: insert ("
    types.each do |type|
        case type
        when "integer"
            example << "77, "
        when "float"
            example << "44.4, "
        when "string"
            example << "string, "
        when "boolean"
            example << "true, "
        else
            puts "Received invalid type #{type}, exiting program."
            abort
        end
    end
    example = example[0...-2]
    example << ")"
    return example
end

def default_display(table)
    puts table
    puts "Enter (h) to see example queries"
    puts "Enter (q) to quit"
    print "\n~> "
end

def clear_screen()
    puts "\e[H\e[2J"
end

def pause()
    puts "Press (enter)"
    gets
end

query = nil
table = create_terminal_table(schema.keys, data)

while query != 'q'
    clear_screen()
    default_display(table)
    query = gets.chomp
    data = handle_input(query, schema, data)
    table = create_terminal_table(schema.keys, data)
    pause()
end
