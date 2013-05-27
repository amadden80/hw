
require_relative "stockManage2.rb"

describe Firm do

  describe '#new' do
    it 'builds a new Firm with a name' do
      firm = Firm.new('TDDStock')
      firm.should be_instance_of Firm
      firm.name.should eq('TDDStock')
    end
  end

  describe '#addClient' do
    let(:firm) { Firm.new('TDDStock')}

    it 'create a new client with a name' do
      name = "Joe"
      firm.addClient(name, 5003)
      firm.clients[:Joe].name.should eq("Joe")
    end

    it 'create multiple clients' do
      firm.addClient("Joe", 5003)
      firm.addClient("Tina")
      firm.clients.count.should eq(2)
    end

  end

end



describe Client do

  describe '#new' do
    it 'builds a new Client with a name' do
      client = Client.new('Joe')
      client.should be_instance_of Client
      client.name.should eq('Joe')
    end

    it 'has default cash value of zero'do
      client = Client.new('Joe')
      client.cash.should eq(0)
    end
  end

  describe '#addPortfolio' do
    let(:client) {Client.new('Joe')}

    it 'create a new portfolio with a name' do
      client.addPortfolio("MyFutureMillions")
      client.portfolios[:MyFutureMillions].name.should eq("MyFutureMillions")
    end

    it 'create multiple portfolios' do
      client.addPortfolio("MyFutureMillions1")
      client.addPortfolio("MyFutureMillions2")
      client.portfolios.count.should eq(2)
    end
  end

  describe '#buyStock' do
    let(:client) {Client.new('Joe', 999999999999)}

    it 'create a new portfolio with a name' do
      client.addPortfolio("MyFutureMillions")
      client.buyStock("MyFutureMillions", 'AAPL', 2)
      client.portfolios[:MyFutureMillions].stocks[:AAPL][:numShares].should eq(2)
    end

    it 'purchase takes from client cash' do
      startCash = client.cash;
      client.addPortfolio("MyFutureMillions")
      client.buyStock("MyFutureMillions", 'AAPL', 2)
      endingCash = client.cash;
      startCash.should_not eq(endingCash)
    end
  end

  describe '#sellStock' do
    let(:client) {Client.new('Joe', 999999999999)}

    it 'sell stock' do
      client.addPortfolio("MyFutureMillions")
      client.buyStock("MyFutureMillions", 'AAPL', 2)
      startCash = client.cash;
      client.sellStock("MyFutureMillions", 'AAPL', 1)
      endingCash = client.cash;
      startCash.should_not eq(endingCash)
    end

    it 'sell all stock' do
      client.addPortfolio("MyFutureMillions")
      client.buyStock("MyFutureMillions", 'AAPL', 2)
      startCash = client.cash;
      client.sellStock("MyFutureMillions", 'AAPL', 2)
      endingCash = client.cash;
      startCash.should_not eq(endingCash)
    end
   end
end



describe Porfolio do

  describe '#new' do
    it 'builds a new Porfolio with a name' do
      portfolio = Porfolio.new('MyFutureMillions')
      portfolio.should be_instance_of Porfolio
      portfolio.name.should eq('MyFutureMillions')
    end
  end

  describe '#addStock' do
    let(:portfolio) {Porfolio.new('MyFutureMillions')}

    it 'add a stock to a portfolio' do
      portfolio.addStock('AAPL', 1)
      portfolio.stocks[:AAPL][:id].should eq('AAPL')
    end

    it 'add multiple stocks' do
      portfolio.addStock('AAPL', 1)
      portfolio.addStock('GE', 2)
      portfolio.stocks.count.should eq(2)
    end

    it 'add shares to stock' do
      portfolio.addStock('AAPL', 1)
      portfolio.addStock('AAPL', 2)
      portfolio.stocks[:AAPL][:numShares].should eq(3)
    end
  end

  describe '#removeStock' do
    let(:portfolio) {Porfolio.new('MyFutureMillions')}

    it 'remove stock' do
      portfolio.addStock('GE', 1)
      portfolio.removeStock('GE', 1)
      portfolio.stocks[:GE].should eq(nil)
    end

    it 'remove stock shares' do
      portfolio.addStock('GE', 2)
      portfolio.removeStock('GE', 1)
      portfolio.stocks[:GE][:numShares].should eq(1)
    end

  end


  describe '#update' do
    let(:portfolio) {Porfolio.new('MyFutureMillions')}

    it 'updates prices' do
      portfolio.addStock('AAPL', 1)
      oldPrice = portfolio.value
      portfolio.update
      newPrice = portfolio.value
      oldPrice.should_not == newPrice
    end

  end

end
