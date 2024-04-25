if ARGV.size < 4 || ARGV.includes?("-h") 
  puts "syntax: pdf_filename_incoming.pdf \"replace this\" \"with that\" pdf_filename_outgoing.pdf [regex for matching lines to be affected]
    see the README, filenames can be - for stdin/stdout"
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
  STDERR.puts "only replacing lines matching regex #{regex_for_matching_lines}"
else
  regex_for_matching_lines = ".*"
end

output, count = transmogrify(input, desired, replace_with, regex_for_matching_lines)

if ARGV[3] == "-"
  STDOUT.print output
else
  File.write(ARGV[3], output)
end

STDERR.puts "wrote num_modified=#{count} replacing '#{desired}' with '#{replace_with}' files: #{ARGV[0]} -> #{ARGV[3]}"
if count == 0
  STDERR.puts "  No changes made, is pdf compressed perhaps? If so please decompress first."
end
