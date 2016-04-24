require './app'

describe "collates" do

  it "one item and prints it" do
    collator = Collator.new
    collator.collate("RaspberryPI2")
    expect(collator.print).to eq(["RaspberryPI2"])
  end

  it "two items and prints them in order asc" do
    collator = Collator.new
    collator.collate("B PI")
    collator.collate("A PI")

    expect(collator.print).to eq(["A PI", "B PI"])
  end
  it "two clashing items, but only records one" do
    collator = Collator.new
    collator.collate("B PI")
    collator.collate("B PI")

    expect(collator.print).to eq(["B PI"])
  end
end
