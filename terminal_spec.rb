require_relative ".terminal"

describe Terminal do
  describe "#scan" do
    before do
      pricing_info = {  }
      @terminal = Terminal.new(pricing_info)
    end

    it "calculates total" do
      expect(terminal.scan("A")).to eq 2.00
    end

    it "calculates total of multiple items using discount" do
      expect(terminal.scan("AAAA")).to eq 7.00
    end

    it "calculates total of multiple items using discount" do
      expect(terminal.scan("AAAAA")).to eq 9.00
    end

    # Code challenge tests
    it "calculates total of multiple items" do
      expect(terminal.scan("ABCDABAA")).to eq 32.40
    end

    it "uses discounts" do
      expect(terminal.scan("CCCCCCC")).to eq 7.25
    end

    it "counts discounts with duplicated items" do
      expect(terminal.scan("ABCD")).to eq 15.40
    end
  end
end
