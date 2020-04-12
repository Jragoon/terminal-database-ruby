require 'terminal-table'
require 'json'

#-- Read file containing Fields object and obtain properties --#
parsed = JSON.parse(File.read("schema.json"));
properties = parsed["fields"];

#--   Example Schema result   --#
#   schema["Name"]  = "string"  #
#   schema["Age"]   = "integer" #
schema = Hash.new
properties.each do |property|
    schema[property["name"]] = property["type"]
end

#-- Create the terminal table --#
rows = []
rows << schema.keys
table = Terminal::Table.new :rows => rows

def print_examples(schema)
    example = create_insert_example(schema.values)
    puts example
end

def handle_input(query, schema)
    query = query.downcase
    if query.include? "insert"
        puts "Attemping insert"
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

while query != 'q'
    clear_screen()
    default_display(table)
    query = gets.chomp
    handle_input(query, schema)
    pause()
end
