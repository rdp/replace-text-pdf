if ARGV.size < 4 || ARGV.includes?("-h") 
  puts "syntax: pdf_filename_incoming.pdf \"replace this\" \"with that\" pdf_filename_outgoing.pdf [just_print_line_numbers | desired_line_number]
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

just_print_numbers = false
desired_line_number = nil
if ARGV.size == 5
  if ARGV[4] == "just_print_line_numbers"
    just_print_numbers = true
  else
    desired_line_number = ARGV[4].to_i
  end
end

output, count = transmogrify(input, desired, replace_with, just_print_numbers, desired_line_number)

if ARGV[3] == "-"
  STDOUT.print output
else
  File.write(ARGV[3], output)
end

STDERR.puts "wrote num_modified=#{count} replacing '#{desired}' with '#{replace_with}' files: #{ARGV[0]} -> #{ARGV[3]}"
STDERR.puts "  on only line #{desired_line_number}" if desired_line_number
if count == 0
  STDERR.puts "  No changes made, is pdf compressed perhaps? If so please decompress first."
end
