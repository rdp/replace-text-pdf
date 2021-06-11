def transmogrify(input, replace_this, with_this)


  # [(O)-16(ther i)-20(nformati)-11(on )]TJ
  # assume for now TJ boxes don't span lines?
  # assume for now we don't support more than single TJ box ...

  output = input.gsub(/\[(.*?)\]TJ/) { | moi |
    puts moi
    cleaned = removeGlyph(moi)
    if cleaned.includes?(replace_this)
      cleaned.sub(replace_this, with_this)
    else
      moi
    end
  }
  output
end

def removeGlyph(input) # (O)-16(ther i)2(b) => Other ib
  # assume balanced for now...XXX handle it not having glyph at all, I think that's legal...
  # XXX escaped parens...
  without_interior_parents = input.gsub(/\)-?\d*\(/, "") 
  # remove beginning and ending now...
  without_interior_parents[1..-2]
end



