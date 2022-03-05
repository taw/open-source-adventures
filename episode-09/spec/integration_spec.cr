describe "Integration Tests" do
  it "Sudoku" do
    actual = `./examples/sudoku.cr`
    expected = File.read("#{__DIR__}/integration/sudoku.txt")
    actual.should eq(expected)
  end

  it "SEND + MORE = MONEY" do
    actual = `./examples/send_more_money.cr`
    expected = File.read("#{__DIR__}/integration/send_more_money.txt")
    actual.should eq(expected)
  end
end
