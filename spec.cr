require "spec"
require "./methods.cr"

describe "works" do

  it "should remove old glyph spacing" do
    removeGlyph("[(O)-16(ther i)2(b)]TJ").should eq "Other ib"
  end

  it "should remove spacing2" do
    removeGlyph("[(O)-16(ther i)-20(nformati)-11(on )]TJ").should eq "Other information "
  end

  it "should remove old glyph with non array syntax" do
    removeGlyph(" (Hello PSPDFKit) Tj").should eq "Hello PSPDFKit"
  end

  it "should replace on match" do
    out, count = transmogrify("[(O)-16(ther i)-20(nformati)-11(on )]TJ", "Other", "zzz")
    out.should eq("[(zzz information )]TJ")
  end

  it "should replace with weird tj syntax" do
    transmogrify(" (Hello PSPDFKit) Tj\n", "PSPD", "yoyo").should eq ([" (Hello yoyoFKit) Tj\n", 1])
  end

  it "should replace to caps" do
    out, count = transmogrify("[(O)-16(ther i)-20(nformati)-11(on )]TJ", "information", "Zzz")
    out.should eq("[(Other Zzz )]TJ")
  end

  it "should retain next lines" do
    out, count = transmogrify("stuff\n[(O)-16(ther i)-20(nformati)-11(on )]TJ\nstuff2", "Other", "zzz")
    out.should eq("stuff\n[(zzz information )]TJ\nstuff2")
  end

  it "should retain parens when removing glyph" do
    removeGlyph("[(\\()-12(201)12(9\\))]TJ").should eq "(2019)"
  end

  it "should replace text more than once" do # which implies split lines in pdf format apparently
    out, count = transmogrify("stuff\n[(O)-16(ther i)-20(nformati)-11(on )]TJ\n[(ZZ)-16(ther i)]TJ\nstuff2\n[(O)-16(ther i)-20(nformati)-11(on )]TJ\nstuff3", "Other", "zzz")
    out.should eq("stuff\n[(zzz information )]TJ\n[(ZZ)-16(ther i)]TJ\nstuff2\n[(zzz information )]TJ\nstuff3")
    count.should eq(2)
  end

  it "should replace more than one instance same line" do
    out, count = transmogrify("stuff\n[(O)-16(ther i)-20(nformati)-11(on Oth)-11(er )]TJ\nstuff2", "Other", "zzz")
    out.should eq("stuff\n[(zzz information zzz )]TJ\nstuff2")
  end # XXX mix them??

  it "should do minimal damage" do # minimal damage see comment elsewhere
    out, count = transmogrify("[(Software)-6600(GOODNESS PLUS LLC)-14400(82bbb)]TJ", "GOODNESS", "blah")
    out.should eq("[(Software)-6600(blah PLUS LLC)-14400(82bbb)]TJ")
  end

  it "should do minimal damage not starting at paren" do # regex messed this once
    out, count = transmogrify("[(Software)-6600(GOODNESS PLUS LLC)-14400(82bbb)]TJ", "OODNESS", "blah")
    out.should eq("[(Software)-6600(Gblah PLUS LLC)-14400(82bbb)]TJ")
  end

  it "should do minimal damage multiples" do
    out, count = transmogrify("[(Software)-6600(GOODNESS PLUS LLC)-14400(GOODNESS 22 )]TJ", "GOODNESS", "blah")
    out.should eq("[(Software)-6600(blah PLUS LLC)-14400(blah 22 )]TJ")
    count.should eq(2) # broken XXX
  end

  it "should escape parens in strings with parens" do
    out, count = transmogrify("[(\\()-12(201)12(9\\))]TJ", "2019", "2020")
    out.should eq("[(\\(2020\\))]TJ")
    count.should eq(1)
  end

  it "should not modify non text numbers that match" do
    out, count = transmogrify("[(Software)-6600(GOODNESS PLUS LLC)-20600(82-3157378)]TJ", "206", "207")
    count.should eq(0)
  end

  it "should not modify non text numbers when there is a match" do # currently broke
    out, count = transmogrify("[(Software)-6600(GOODNESS PLUS LLC 6600)-206600(82-3157378)]TJ", "6600", "777")
    out.should eq("[(Software)-6600(GOODNESS PLUS LLC 777)-206600(82-3157378)]TJ")
  end

  # TODO it should work with internal parens too??

  # could do: if you have minimal damage and split, like (Something Some)22(thing) replacign Something should do minimal (?)

end


