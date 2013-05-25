

require_relative 'stockManage'


describe StockManagement do

  describe '#new' do
    it 'builds a new StockManagement with a name' do
      stockManagement = StockManagement.new('MyStocky')
      stockManagement.should be_instance_of StockManagement
      stockManagement.name.should == 'MyStocky'
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

