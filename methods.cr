def transmogrify(input, replace_this, with_this)

  # [(O)-16(ther i)-20(nformati)-11(on )]TJ => [Other information replaced]
  # assume for now TJ boxes don't span lines...I think they don't...
  output = input.gsub(/(\[.*?\]|\(.*?\))\s*TJ/i) { | moi |
    if moi.includes?(replace_this)
      moi.sub(replace_this, with_this)
    else
      cleaned = removeGlyph(moi)
      if cleaned.includes?(replace_this)
        "[(" + cleaned.sub(replace_this, with_this) + ")]TJ"
      else
        moi # didn't find it, return original
      end
    end
  }
  output
end

def removeGlyph(input) # [(O)-16(ther i)2(b)]TJ => Other ib
  # assume balanced for now...XXX handle it not having glyph at all, I think that's allowable...
  # XXX handle escaped parens...
  without_interior_parens = input.strip.gsub(/\)-?\d*\(/, "") 
  # remove beginning and ending stuff now...
  without_interior_parens.sub(/^[\[\(]+/, "").sub(/[\)\]]+\s*TJ$/i, "")
end

