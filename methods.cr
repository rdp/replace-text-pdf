def transmogrify(input, replace_this, with_this)


  # [(O)-16(ther i)-20(nformati)-11(on )]TJ
  # assume for now TJ boxes don't span lines?
  # assume for now we don't support more than single TJ box ...

  output = input.gsub(/\[.*?\]TJ/) { | moi |
    puts moi
    cleaned = removeGlyph(moi)
    puts "cleaned=" + cleaned
    if cleaned.includes?(replace_this)
      "[" + cleaned.sub(replace_this, with_this) + "]TJ"
    else
      moi # original
    end
  }
  output
end

def removeGlyph(input) # [(O)-16(ther i)2(b)]TJ => Other ib
  # assume balanced for now...XXX handle it not having glyph at all, I think that's allowable...
  # XXX handle escaped parens...
  without_interior_parens = input.gsub(/\)-?\d*\(/, "") 
  # remove beginning and ending junk now...
  without_interior_parens[2..-5]
end



