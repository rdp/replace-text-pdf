if ARGV.size < 4 || ARGV.includes?("-h") 
  puts "syntax: pdf_filename_incoming.pdf \"replace this\" \"with that\" pdf_filename_outgoing.pdf [just_print_numbers]
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
  just_print_numbers = true
else
  just_print_numbers = false
end

output, count = transmogrify(input, desired, replace_with, just_print_numbers)

if ARGV[3] == "-"
  STDOUT.print output
else
  File.write(ARGV[3], output)
end

STDERR.puts "wrote num_modified=#{count} replacing '#{desired}' with '#{replace_with}' files: #{ARGV[0]} -> #{ARGV[3]}"
if count == 0
  STDERR.puts "  No changes made, is pdf compressed perhaps? If so please decompress first."
end
