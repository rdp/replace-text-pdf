def transmogrify(input, replace_this, with_this, lines_containing = ".*")

  count = 0
  lines_matching = Regex.new(lines_containing)

  # for each substring that matches [...]TJ possibly replace it...
  # assume for now TJ boxes don't span lines...I think they don't....
  output = input.gsub(/(\[.*?\]|\(.*?\))\s*TJ/i) { | original_line |
    # [(O)-16(ther i)-20(nformati)-11(on )]TJ => [(Other information but with replacement)]TJ
    cleaned = removeGlyph(original_line) 
    if cleaned =~ lines_matching
      pdf_text_matcher = Regex.new("\\([^)]*" + Regex.escape(replace_this) + ".*\\)") # ( then no ")", then the thing, then somewhere a ")", think that's enough
      # XXX test the Regex.escape used...
      if original_line.matches?(pdf_text_matcher) 
        count += 1
        original_line.gsub(replace_this, with_this) # do low damage...
      else
        if cleaned.includes?(replace_this)
          count += 1
          replaced = cleaned.gsub(replace_this, with_this)
          "[(" + replaced.gsub("(", "\\(").gsub(")", "\\)") + ")]TJ" # escape parens, add back in glyphs
        else
          original_line # didn't find it, stick with original
        end
      end
    else
      original_line
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

