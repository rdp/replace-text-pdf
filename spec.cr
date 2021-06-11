require "spec"
require "./methods.cr"

describe "works" do

  it "should remove old glyph spacing" do
    removeGlyph("(O)-16(ther i)2(b)").should eq "Other ib"
  end

  it "should replace" do
    out = transmogrify("[(O)-16(ther i)-20(nformati)-11(on )]TJ", "Other", "zzz")
    out.should eq("[zzz information ]TJ")
  end

  it "should retain other lines" do
    out = transmogrify("stuff\n[(O)-16(ther i)-20(nformati)-11(on )]TJ\nstuff2", "Other", "zzz")
    out.should eq("stuff\n[zzz information ]TJ\nstuff2")
  end

  it "should replace more than one instance" do
    out = transmogrify("stuff\n[(O)-16(ther i)-20(nformati)-11(on )]TJ\n[(OO)-16(ther i)]TJ\nstuff2\n[(O)-16(ther i)-20(nformati)-11(on )]TJ", "Other", "zzz")
    out.should eq("stuff\n[zzz information ]TJ\n[(OO)-16(ther i)]TJ\nstuff2\n[zzz information ]TJi\nstuff2")

  end

end


