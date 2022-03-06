require "./spec_helper"

describe Z3 do
  it ".version" do
    Z3.version.should match(/\A\d+\.\d+\.\d+\.\d+\z/)
  end
end
