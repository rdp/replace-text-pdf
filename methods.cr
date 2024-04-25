
def transmogrify(input, replace_this, with_this, should_just_display_numbers = false, targeted_line_number : Int32? = nil) # too annoying for unit tests with no default

  count = 0
  text_line_num = 0
  opt = Regex::MatchOptions::NO_UTF_CHECK # pcre1 later crystals require this for weirdly formatted pdf's like we have...

  # for each substring that matches [...]TJ possibly replace it...
  # assume for now TJ boxes don't span lines...I think they don't....XX do they always begin lines? Assume not for now...
  output = input.gsub(/(\[.*?\]|\(.*?\))\s*TJ/i, options: opt) { | original_line |
    text_line_num += 1
    # [(O)-16(ther i)-20(nformati)-11(on )]TJ => [(Other information but with replacement)]TJ
    simplified = removeGlyph(original_line) 
    output_line = original_line
    if should_just_display_numbers
      puts "#{text_line_num}: #{simplified}"
    else
      if !targeted_line_number || targeted_line_number == text_line_num
        pdf_text_matcher = Regex.new("\\([^)]*" + Regex.escape(replace_this) + ".*\\)") # ( then no ")", then the thing, then somewhere a ")", think that's enough
        # XXX unit test the Regex.escape is used...
        if original_line.matches?(pdf_text_matcher, options: opt) 
          count += 1
          output_line = original_line.gsub(replace_this, with_this) # do low damage...
        else
          if simplified.includes?(replace_this)
            count += 1
            replaced = simplified.gsub(replace_this, with_this)
            output_line = "[(" + replaced.gsub("(", "\\(").gsub(")", "\\)") + ")]TJ" # escape parens, add back in glyphs
          else
            if targeted_line_number
              STDERR.puts "unable to replace on line #{targeted_line_number}? line=#{simplified} trying_to_replace=#{replace_this}" # a miss
            end
          end
        end
      end
    end
    output_line
  }
  [output, count]
end

def removeGlyph(input) # [(O)-16(ther i)2(b)]TJ => Other ib
  opt = Regex::MatchOptions::NO_UTF_CHECK # what kind of crazy UTF stuff do these pdf's have in them?? weird chars arbitrarily? huh?
  with_escaped_parens_removed = input.gsub("\\(", "(").gsub("\\)", ")")
  without_interior_parens = with_escaped_parens_removed.strip.gsub( /\)-?\d*\(/ , "", options: opt)
  without_begin_end_stuff = without_interior_parens.sub(/^\[/, "", options: opt) # intro [
  without_begin_end_stuff = without_begin_end_stuff.sub(/^\(/, "", options: opt) # intro (
  without_begin_end_stuff = without_begin_end_stuff.sub(/\s*TJ$/i, "", options: opt) # ending TJ
  without_begin_end_stuff = without_begin_end_stuff.sub(/\]$/, "", options: opt) # ending ]
  without_begin_end_stuff = without_begin_end_stuff.sub(/\)$/, "", options: opt) # ending ) NB if it isn't array this doesn't allow closing escaped )...
  without_begin_end_stuff
end

