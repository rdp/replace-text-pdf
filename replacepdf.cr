def transmogifry(input, replace_this, with_this)


# [(O)-16(ther i)-20(nformati)-11(on )]TJ

# assume for now TJ boxes don't span lines?
# assume for now we don't support more than single TJ box ...

  input = input.gsub(/\[.*?\]TJ/) { | moi |
    puts moi
  }
  input
end
