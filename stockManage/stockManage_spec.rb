

require_relative 'bank'


describe Bank do

  describe '#new' do
    it 'builds a new bank with a name' do
      bank = Bank.new('MyCiti')
      bank.should be_instance_of Bank
      bank.name.should == 'MyCiti'
    end
  end



  it "Create an account for client (name, balance)"
  it "A client can create multiple portfolios"
  it "A client can buy stocks at market rate"
  
  it "Stocks will be added to a client portfolio"
  it "Client purchase subtract from cash their clash"
  it "Negative cash balance is not possible"

  it "A client can sell a stock"
  it "Proceeds go into clients account at sale"

  it "List all client portfolios and their values"
  it "List all stocks in a portfolio"
  it "List all clients"

  it "Calculate portfolio balance"
  it "Get current stock prices"

end

