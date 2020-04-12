require 'terminal-table'
require 'json'

rows = []
rows << ['Field 1', 'Field 2', 'Field 3', 'Field 4'];
table = Terminal::Table.new :rows => rows

puts table
