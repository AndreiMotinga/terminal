require_relative "terminal"

describe Terminal do
  before do
    pricing_info = {
      A: {
        price: 2.00,
        "disounts": [
          {
            count: 4,
            price: 7.00
          }
        ]
      },
      B: {
        price: 12.00,
        disounts: []
      },
      C: {
        price: 1.25,
        disounts: [
          {
            count: 6,
            price: 6.00
          }
        ]
      },
      D: {
        price: 0.15,
        discounts: []
      }
    }
    @terminal = Terminal.new(pricing_info)
  end
  describe "#scan" do
    it "adds item to @items" do
      @terminal.scan("A")
      expect(@terminal.items).to eq({ A: 1 })
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
