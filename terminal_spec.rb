require_relative "terminal"
require "json"

describe Terminal do
  before do
    file = File.read("pricing.json")
    pricing_info = JSON.parse(file, symbolize_names: true)
    @terminal = Terminal.new(pricing_info)
  end

  describe "#scan" do
    it "adds item to @items" do
      @terminal.scan("A")
      expect(@terminal.items).to eq({ A: 1 })
    end

    it "adds item to @items" do
      @terminal.scan("A")
      @terminal.scan("A")
      @terminal.scan("B")
      expect(@terminal.items).to eq({ A: 2, B: 1 })
    end
  end

  describe "#total" do
    it "calculates total" do
      @terminal.scan("A")
      expect(@terminal.total).to eq 2.00
    end

    it "calculates total" do
      @terminal.scan("A")
      expect(@terminal.total).to eq 2.00
    end

    it "calculates total of multiple items using discount" do
      4.times { @terminal.scan("A") }
      expect(@terminal.total).to eq 7.00
    end

    it "calculates total of multiple items using discount" do
      5.times { @terminal.scan("A") }
      expect(@terminal.total).to eq 9.00
    end

    # Code challenge required tests
    it "calculates total of multiple items" do
      "ABCDABAA".chars.each { |char| @terminal.scan(char) }
      expect(@terminal.total).to eq 32.40
    end

    it "uses discounts" do
      "CCCCCCC".chars.each { |char| @terminal.scan(char) }
      expect(@terminal.total).to eq 7.25
    end

    it "counts discounts with duplicated items" do
      "ABCD".chars.each { |char| @terminal.scan(char) }
      expect(@terminal.total).to eq 15.40
    end
  end
end
