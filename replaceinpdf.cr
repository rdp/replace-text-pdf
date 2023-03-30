if ARGV.size < 4 || ARGV.includes?("-h") 
  puts "syntax: input_filename desired_old_text replace_with_this_text output_filename"
  puts "  filenames can be - for stdin/stdout"
  puts "  can have an option another parameter of a regular expression 'only make changes on lines matching this regex' like a..b a.*b etc"
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
  STDERR.puts "no changes, is pdf compressed perhaps? If so please decompress first."
end
