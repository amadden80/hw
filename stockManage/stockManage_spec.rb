
require_relative 'stockManage'

describe StockManagement do

  describe '#new' do
    it 'builds a new StockManagement with a name' do
      stockManagement = StockManagement.new('TDDStock')
      stockManagement.should be_instance_of StockManagement
      stockManagement.name.should == 'TDDStock'
    end
  end

  describe '#new client' do
    it 'Create an account for client (name, balance)' do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      balance = 500
      stockManagement.newClient(name, balance)
      stockManagement.getClient(name).name.should == name
    end
  end


  describe '#new portfolios' do

    it "make new portfolio" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      balance = 50000
      id = "AAPL"
      numShares = 1
      portName = "MyPortfolio"
      stockManagement.newClient(name, balance)
      stockManagement.getClient(name).newPortfolio(portName, id, numShares)
      stockManagement.getClient(name).portfolios[0].stocks[0][:stock].id.should == id
    end

    it "make multiple portfolio" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      stockManagement.newClient(name, 50000)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 1)
      stockManagement.getClient(name).newPortfolio("Port2", "GE", 3)
      stockManagement.getClient(name).portfolios.length == 2
    end

    it "buy multiple stocks in a portfolio" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      stockManagement.newClient(name, 50000)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 1)
      stockManagement.getClient(name).portfolios[0].addStock("GE", 2)
      stockManagement.getClient(name).portfolios[0].stocks.length.should == 2
    end

  end

  describe '#exchange stocks' do
    it "Client sells more shares" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 500000
      stockManagement.newClient(name, 5)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 2)
      stockManagement.getClient(name).sellStock("Port1", "AAPL", 1)
      stockManagement.getClient(name).portfolios[0].stocks[0][:numShares].should == 1
    end
  end

  describe '#exchange money' do
    it "Client purchase subtracts from client cash" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 50000
      stockManagement.newClient(name, 5)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 2)
      stockManagement.getClient(name).cash.should < startingCash
    end

    it "Client sells more shares for $" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 5000000
      stockManagement.newClient(name, startingCash)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 2)
      cashAfterBuy = stockManagement.getClient(name).cash
      stockManagement.getClient(name).sellStock("Port1", "AAPL", 1)
      cashAfterSell = stockManagement.getClient(name).cash
      cashAfterBuy.should < cashAfterSell
    end
    
    it "protect for negitive cash" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      stockManagement.newClient(name, 1)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 100000000000000)
      stockManagement.getClient(name).portfolios.length.should == 0
    end

  end

  describe '#update stocks' do
    it "stock price updated" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 500
      stockManagement.newClient(name, 500)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 20)
      bal1 = stockManagement.getClient(name).portfolios[0].balance
      stockManagement.getClient(name).update
      bal2 = stockManagement.getClient(name).portfolios[0].balance
      bal1.should_not == bal2
    end
  end
  
  describe '#print lists' do
    it "show all stocks in a portfolio" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 500
      stockManagement.newClient(name, 500)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 20)
      stockManagement.getClient(name).portfolios[0].addStock("GE", 10)
      puts stockManagement.getClient(name).portfolios[0]
    end

    it "show all client in a portfolio" do
      stockManagement = StockManagement.new('MrStockyManager')
      name = "Joe"
      startingCash = 500
      stockManagement.newClient(name, 500)
      stockManagement.getClient(name).newPortfolio("Port1", "AAPL", 20)
      stockManagement.getClient(name).portfolios[0].addStock("GE", 10)
      puts stockManagement.getClient(name).portfolios[0]
    end

    it "show clients and balance" do
      stockManagement = StockManagement.new('MrStockyManager')
      stockManagement.newClient("Joe", 500)
      stockManagement.newClient("Tina", 1003)
      stockManagement.getClient("Joe").newPortfolio("Port1", "AAPL", 2)
      stockManagement.getClient("Tina").newPortfolio("Port1", "GE", 3)
      stockManagement.getClient("Joes").portfolios[0].addStock("GE", 10)
      stockManagement.getClient("Tina").newPortfolio("Port1", "AAPL", 4)
      puts stockManagement
    end

    it "show clients and balance" do
      stockManagement = StockManagement.new('MrStockyManager')
      stockManagement.newClient("Joe", 500)
      stockManagement.newClient("Tina", 1003)
      stockManagement.getClient("Joe").newPortfolio("Port1", "AAPL", 2)
      stockManagement.getClient("Tina").newPortfolio("Port1", "GE", 3)
      stockManagement.getClient("Joes").portfolios[0].addStock("GE", 10)
      stockManagement.getClient("Tina").newPortfolio("Port1", "AAPL", 4)
      stockManagement.displayClients
    end

  end

end



