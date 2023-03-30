if ARGV.size < 4 || ARGV.includes?("-h") 
  puts "syntax: see the README"
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

if ARGV.size == 5
  regex_for_matching_lines = ARGV[4]
  STDERR.puts "using regex #{regex_for_matching_lines}"
else
  regex_for_matching_lines = ".*"
end

output, count = transmogrify(input, desired, replace_with, regex_for_matching_lines)

if ARGV[3] == "-"
  STDOUT.print output
else
  File.write(ARGV[3], output)
end

STDERR.puts "wrote num_modified=#{count} #{ARGV[0]} -> #{ARGV[3]}"
if count == 0
  STDERR.puts "no changes looking for '#{desired}', is pdf compressed perhaps? If so please decompress first."
end
