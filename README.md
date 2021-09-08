# replace-text-pdf

replace text within pdf files.  Harder than you might suppose...

To use: 

convert your pdf to "uncompressed" format.  pdftk is one way https://stackoverflow.com/a/920471/32453

Now at this point, your raw pdf file might well have some text in it that looks wonky, like this:

[(O)-16(ther i)-20(nformati)-11(on )]TJ

The weird numbers denote text offsets, allowing for kerning and controlling the space between words and such https://stackoverflow.com/a/66282749/32453

So this program, you tell it which text to replace.  If it finds it it discards the glyph numbers and does the replace.  
It works a lot of the time.  More often than sed typically.  At least as good at sed always (assuming you don't need regex).

To run it, install "crystal" programming language compiler first
then clone this repo.  Then

$ crystal replaceinpdf.cr input_filename.pdf "something you want replaced" "what you want it replaced with" output.pdf

output.pdf can be the input filename if you'd like to overwrite it.  input and output filenames can be "-" if you want to output to stdout and chain (ex: multiple replacements)

For instance 

Limitations: only replaces text within the same line.  Might lose some formatting, your mileage may vary.

Feedback welcome via  github issues.

More features possible: keeping the exact formatting if the text is the "same size" (today it basically removes all the numbers in the Tj box, which defaults back to defaults, which may or may not work as you desire...
  and variations on the same.

Related: you can also replace text manually in Pdfs using openoffice draw or inkscape.

Cheers!
