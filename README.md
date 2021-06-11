# replace-text-pdf

replace text within pdf files

To use: 

convert your pdf to "uncompressed" format

your pdf might well have some text in it that looks wonky, like this:

[(O)-16(ther i)-20(nformati)-11(on )]TJ
The weird numbers denote text offsets, allowing for kerning and controlling the space between words and such https://stackoverflow.com/a/66282749/32453

So this program, you tell it which text to replace.
To run it, install "crystal" programming language compiler first

$ crystal replaceinpdf.cr input_filename.pdf "something you want replaced" "what you want it replaced with" output.pdf

For instance 

$ crystal replaceinpdf.cr input.pdf "Other inf" "zzz" in the above example
would change the above example to [zzzormation]TJ in your pdf, which seems to work despite not having any text offsets anymore.

Limitations: only replaces text within the same locale.

Feedback as github issues.

Related: you can replace text in Pdfs using openoffice draw. 

Cheers!
