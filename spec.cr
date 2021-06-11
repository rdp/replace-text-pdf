require "spec"
require "./replacepdf.cr"

describe "works" do

  it "should replace" do
    out = transmogrify("[(O)-16(ther i)-20(nformati)-11(on )]TJ", "Other", "zzz")
    out.should eq("[zzz information ]TJ")
  end

end


