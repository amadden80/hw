

require 'YahooFinance'


class StockManagement

  attr_reader :name, :clients

  def initialize(name)
    @name = name
    @clients = []
  end

  def newClient(name, cash)
    client = Client.new(name)
    client.cash = cash
    @clients << client
  end

  def getClient(name)
    @clients.each{|cur| cur.name == name}.first
  end


  def to_s
    printString = "#{@name}\n"
    @clients.each{|cur| printString << "#{cur.name}: #{cur.balance}\n"}
    return printString
  end

  def displayClients
    puts @clients.map{|cur| "#{cur.name}"}.join(', ')
  end

end


class Client

  attr_accessor :name, :cash, :portfolios

  def initialize(name)
    @name = name
    @balance = nil
    @portfolios = []
  end

  def newPortfolio(name, id, numShares)
    if Stock.new(id).price * numShares < @cash
      portfolio = Portfolio.new(name)
      cost = portfolio.addStock(id, numShares)
      @cash -= cost
      @portfolios << portfolio
    else
      puts "Purchace price exceeds cash.  Transaction Ignored"
    end
  end

  def buyStock(portfolioName, id, numShares)
    portfolio = @portfolios.each {|port| port.name == portfolioName}.first

    if Stock.new(id).price * numShares < @cash
      cost = portfolio.addStock(id, numShares)
      @cash -= cost
    else
      puts "Purchace price exceeds cash.  Transaction Ignored"
    end

  end

  def sellStock(portfolioName, id, numShares)
    portfolio = @portfolios.each {|port| port.name == portfolioName}.first
    cost = portfolio.removeStock(id, numShares)
    @cash += cost
  end

  def update
    @portfolios.each do |portfolio|
      portBalance = 0
      portfolio.stocks.each do |stock|
        stock[:value] = stock[:numShares] * (stock[:stock].update)
        portBalance += stock[:value]
      end
      portfolio.balance = portBalance
    end
  end

  def balance
    update
    balance = 0
    @portfolios.each{|portfolio| balance+=portfolio.balance}
    return balance
  end

  def to_s
    printString = "\n#{@name} \n"
    @portfolios.each { |portfolio|  printString << "#{portfolio.name} : #{portfolio.name}\n"}
    return printString
  end

end


class Portfolio

  attr_accessor :name, :stocks, :balance

  def initialize(name)
    @name = name
    @stocks = []
    @balance = nil
  end

  def addStock(id, numShares)
    stock = Stock.new(id)
    cost = stock.price * numShares
    stocks << {:stock => stock, :numShares => numShares, :cost => cost, :value => cost}
    return cost
  end


  def removeStock(id, numShares)

    stock = @stocks.each {|stk| stk[:stock].id == id}.first

    stock[:stock].update
    cost = stock[:value] * numShares

    if numShares < stock[:numShares]
      stock[:numShares] -= numShares
    elsif numShares == stock[:numShares]
      @stocks.pop(stock)
    end

    return cost
  end

  def to_s
    printString = "\n#{@name} \n"
    @stocks.each { |stock|  printString << "#{stock[:stock].id} : #{stock[:numShares]} shares = totaling $#{stock[:value]}\n"}
    return printString
  end

end


class Stock

  attr_accessor :id, :price

  def initialize(id)
    @id = id
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @id)[@id].lastTrade
  end

  def update
    @price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @id)[@id].lastTrade
    return @price
  end

end
