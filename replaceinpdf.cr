if ARGV.size != 4 || ARGV.includes?("-h") 
  puts "syntax: input_filename desired_old_text replace_with_this_text output_filename"
  exit 1
end

require "./methods.cr"

if ARGV[0] == "-"
  input = STDIN.gets_to_end
else
  input = File.read(ARGV[0])
end
desired = ARGV[1]
replace_with = ARGV[2]
output, count = transmogrify(input, desired, replace_with)
if ARGV[3] == "-"
  STDOUT.print output
else
  File.write(ARGV[3], output)
end

STDERR.puts "wrote num_modified=#{count} to #{ARGV[3]} from #{ARGV[0]}"
