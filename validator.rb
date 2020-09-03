#!/usr/bin/env ruby

require '~/Testing/validator/rx.rb' # Taken from the Rx repository, see https://github.com/rjbs/Rx/blob/master/ruby/Rx.rb
require 'yaml'

schema_file = File.open(ARGV[1]).read
schema = YAML.load(schema_file)

file = File.open(ARGV[0]).read
validatable = YAML.load(file)

rx = Rx.new({ :load_core => true })

puts "Loading schema to validate against"
begin
  schema = rx.make_schema(schema)
  puts "  ✅  Schema loaded successfully"
rescue Exception => e
  puts "  ❌  An error occurred loading the schema"
  puts "      #{e.message}"
  exit
end

puts "Validating"
if schema then
  begin  
    schema.check!(validatable)
    puts "  ✅  File is according to schema."
  rescue Exception => e
    puts "  ❌  An error occurred validating the file against the schema"
    puts "      #{e.message}"
  end
end
