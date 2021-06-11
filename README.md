# replace-text-pdf
replace text within pdf files

To use: 

convert pdf to "uncompressed"

now your pdf might well have some text in it that looks wonky, like

[(O)-16(ther i)-20(nformati)-11(on )]TJ
Which denotes the text "Other information" in your pdf.  While controlling the width of each text section.
Good news, if we convert this to [Other information]TJ it usually works fine.
So this basically you tell it which text "in" and what to replace it with.
ex: crystal replaceinpdf.cr input.pdf "Other inf" "zzz" would replace the above line with

[zzzormation]TJ in your pdf, thus allowing you to programmatically replace text in pdf's.

Feedback as github issues.

To run it, install "crystal" programming language compiler first

Cheers!
