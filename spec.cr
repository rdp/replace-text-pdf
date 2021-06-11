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

end


