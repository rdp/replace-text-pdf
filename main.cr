if ARGV.size != 4 || ARGV.includes?("-h") || ARGV.includes?("--help")
  puts "syntax: input_filename desired_old_text replace_with_this_text output_filename"
  exit 1
end


input = File.read(ARGV[0])
desired = ARGV[1]
replace_with = ARGV[2]
output = File.open(ARGV[3], "w")

# [(O)-16(ther i)-20(nformati)-11(on )]TJ

# assume for now TJ boxes don't span lines?
# assume for now we don't support more than single TJ box ...

input = input.gsub(/\[.*?\]TJ/) { | moi |

  puts moi
}


