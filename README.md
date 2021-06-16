# replace-text-pdf

replace text within pdf files

To use: 

convert your pdf to "uncompressed" format.  pdftk is one way https://stackoverflow.com/a/920471/32453

your pdf might well have some text in it that looks wonky, like this:

[(O)-16(ther i)-20(nformati)-11(on )]TJ
The weird numbers denote text offsets, allowing for kerning and controlling the space between words and such https://stackoverflow.com/a/66282749/32453

So this program, you tell it which text to replace.  If it finds it it discards the glyph numbers and does the replace.  
It works a lot of the time.  More often than sed certainly.

To run it, install "crystal" programming language compiler first
then clone the repo.

$ crystal replaceinpdf.cr input_filename.pdf "something you want replaced" "what you want it replaced with" output.pdf

output.pdf can be the input filename if you'd like to overwrite it

For instance 

Limitations: only replaces text within the same line.  Might lose some formatting, your mileage may vary.

Feedback on github issues.

Related: you can replace text in Pdfs using openoffice draw or inkscape.

Cheers!
