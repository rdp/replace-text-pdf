# replace-text-pdf

replace text within pdf files.  A trickier task than you might suppose...made easy here.

To use: 

convert your pdf to "uncompressed" format.  pdftk is one way https://stackoverflow.com/a/920471/32453
  pdftk original.pdf output original.uncompressed.pdf uncompress

Now at this point, your raw pdf file might well have some text in it that looks wonky, like this:

[(O)-16(ther i)-20(nformati)-11(on )]TJ

The weird numbers denote text offsets, allowing for kerning and controlling the size of the spaces between words and such https://stackoverflow.com/a/66282749/32453, and appear to be common.  But make it hard to use a tool like "sed" to replace text.

So this program is "TJ aware", you tell it which text to replace.  If it finds it it discards the glyph numbers and does the replace.  
It works a lot of the time.  More often than sed typically.  At least as good at sed always (assuming you don't need a regular expression).

To run it, install "crystal" programming language compiler first
then clone this repo.  Then run make or 

$ crystal build replaceinpdf.cr

now run

$ ./replaceinpdf.cr input_filename.pdf "something you want replaced" "what you want it replaced with" output_filename.pdf

output_filename.pdf can be the input filename if you'd like to overwrite it.  input and output filenames can be "-" if you want to output to stdout and chain (ex: multiple replacements)

For instance $ ./replaceinpdf input.pdf "this" "with that" - | ./replaceinpdf - "this2" "with that2" final_output.pdf

Or 
$ cp myinput.pdf munged.pdf
$ ./replaceinpdf munged.pdf "this" "with that" munged.pdf
$ ./replaceinpdf munged.pdf "this2" "with that2" munged.pdf

Limitations: only replaces text within the same line.  Might lose some formatting, your mileage may vary.  Basically today if you were to replace the word "information" with "info" in our example it would convert it to
[Other info ]TJ
Which may or may not be what you want, but lines up OK most times.  More features available if desired.  One trick that might work in the meantime is to add spaces like "replace x with "  x"

Feedback/bugs welcome via  github issues.

More features possible: keeping the exact formatting if the text is the "same exact size" 
  and variations on the same.

Related: you can also replace text manually in Pdfs using openoffice draw or inkscape.

You can change the "title" that shows up in the browser when you view a pdf using this other tool
  sed -i 's/old title/new title/' filename.pdf

Cheers!
