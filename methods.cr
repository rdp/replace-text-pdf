def transmogrify(input, replace_this, with_this, lines_containing = nil)

  # [(O)-16(ther i)-20(nformati)-11(on )]TJ => [(Other information but with replacement)]TJ
  # assume for now TJ boxes don't span lines...I think they don't....
  count = 0
  output = input.gsub(/(\[.*?\]|\(.*?\))\s*TJ/i) { | moi |
    if moi.includes?(replace_this)
      count += 1
      moi.gsub(replace_this, with_this) # do low damage...
    else
      cleaned = removeGlyph(moi) 
      if cleaned.includes?(replace_this)
        count += 1
        replaced = cleaned.gsub(replace_this, with_this)
        "[(" + replaced.gsub("(", "\\(").gsub(")", "\\)") + ")]TJ" # escape parens, add back in glyphs
      else
        moi # didn't find it, stick with original
      end
    end
  }
  [output, count]
end

def removeGlyph(input) # [(O)-16(ther i)2(b)]TJ => Other ib
  with_escaped_parens_removed = input.gsub("\\(", "(").gsub("\\)", ")")
  without_interior_parens = with_escaped_parens_removed.strip.gsub(/\)-?\d*\(/, "") 
  without_begin_end_stuff = without_interior_parens.sub(/^\[/, "") # intro [
  without_begin_end_stuff = without_begin_end_stuff.sub(/^\(/, "") # intro (
  without_begin_end_stuff = without_begin_end_stuff.sub(/\s*TJ$/i, "") # ending TJ
  without_begin_end_stuff = without_begin_end_stuff.sub(/\]$/, "") # ending ]
  without_begin_end_stuff = without_begin_end_stuff.sub(/\)$/, "") # ending ) NB if it isn't array this doesn't allow closing escaped )...
  without_begin_end_stuff
end

