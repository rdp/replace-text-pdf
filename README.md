# replace-text-pdf

Replaces text occurrences within pdf files.  
A trickier task than you might suppose...made easy-er here,
and possible to script via the command line.

To use: 

convert your pdf to "uncompressed" format.  pdftk is one way https://stackoverflow.com/a/920471/32453

  $ sudo apt install pdftk
  $ pdftk original.pdf output original.uncompressed.pdf uncompress

Now at this point, your raw pdf file might well have some text in it that looks wonky, like this syntax for the text "Other information ":

[(O)-16(ther i)-20(nformati)-11(on )]TJ

The weird numbers denote text offsets, allowing for kerning and controlling the size of the spaces between words and such 
https://stackoverflow.com/a/66282749/32453, and appear to be common.  But make it hard to use a tool like "sed" to modify text.

So this program is "TJ aware"'ish, you tell it which text to replace.  If it finds it, it discards the glyph numbers and does the replace.  
It works most of the time.  More often than sed typically.  At least as good at sed always (assuming you don't need regular expression replace).
Give it a shot!

To run it, install "crystal" programming language compiler first
then clone this repo.  Then cd into it, run 
$ make

 or 

$ crystal build replaceinpdf.cr

now run the program like:

$ ./replaceinpdf.cr input_filename.pdf "something you want replaced" "what you want it replaced with" output_filename.pdf

output_filename.pdf can be the input filename if you'd like to overwrite it.  input and output filenames can be "-" if you want to output to stdout and chain (ex: multiple replacements)

For instance $ ./replaceinpdf input.pdf "this" "with that" - | ./replaceinpdf - "this2" "with that2" final_output.pdf

Or another way to do it:

$ cp myinput.pdf munged.pdf
$ ./replaceinpdf munged.pdf "this" "with that" munged.pdf
$ ./replaceinpdf munged.pdf "this2" "with that2" munged.pdf

Or a bash script to wrap it/do the same might look like this (named "go.sh" or what have you):

#!/usr/bin/env bash
go() { # params: replace this, with that
  ./replaceinpdf  utah.2021.pdf "$1" "$2" utah.2021.pdf
}

cp utah.uncompressed.pdf utah.2021.pdf

go "my original stuff" "replace that with this new thing"
go 4.56 7.32
go "more stuff" "replace with this stuff"
...

Can have an optional end parameter of a regular expression 'only make changes on lines matching this regex' like a..b a.*b etc"
  ex: replaceinpdf myfilename.pdf "a common string" "replace with this string" "a common string.*123"
     Only lines matching "a common string.*123" will be affected, like "a common string is on this line right matey 123 and some more stuff"
       Will become "replace with this string is on this line right matey 123 and some more stuff"
     But lines that don't contain 123 won't be touched.
    Note sometimes this doesn't work if a long line like "Hello.      43" Is split into "two lines" internally 
      (one for "Hello", one for "43"), feature request welcome.

Limitations: only replaces text within a line.  

Might lose some formatting, your mileage may vary.  Basically today if you were to replace the word "information" with "info" in our example it would convert [(O)-16(ther i)-20(nformati)-11(on )]TJ to just [Other info ]TJ
Which may or may not be what you want, but lines up OK most times.  

More features available if desired.  One trick that might work (if it gets spacing wrong) in the meantime is to add spaces like replace "x" with "    x" to move it right a bit.

Feedback/bugs/requests welcome via github issues.
More features possible: keeping the exact formatting if the text is the "same exact size" 
  and variations on the same.

Contributing: run existing specs like $ crystal spec.cr

Related: you can also replace text manually in Pdfs using openoffice draw or inkscape.

You can change the "title" that shows up in the browser when you view a pdf using a different tool, sed:
  sed -i 's/old title/new title/' filename.pdf

Cheers!
