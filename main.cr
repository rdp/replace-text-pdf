if ARGV.size != 4 || ARGV.includes?("-h") 
  puts "syntax: input_filename desired_old_text replace_with_this_text output_filename"
  exit 1
end

require "replacepdf.cr"

input = File.read(ARGV[0])
desired = ARGV[1]
replace_with = ARGV[2]
output = transmogrify(input, desired, replace_with)
File.write(ARGV[3], output)
