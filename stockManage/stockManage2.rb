

$isOnline = false


require 'YahooFinance'



class Firm

  attr_reader :clients, :name
  attr_writer
  attr_accessor

  def initialize(name)
    @name = name
    @clients = {}
  end

  def addClient(name, cash = 0)
    @clients[name.to_sym] = Client.new(name, cash)
  end

  def to_s
    printString = "\n#{@name} \n"
    @clients.each { |client|  printString << "#{client.name}\n"}
    return printString
  end

end



class Client

  attr_reader :cash, :portfolios, :name
  attr_writer
  attr_accessor

  def initialize(name, cash = 0)
    @name = name
    @cash = cash
    @portfolios = {}
  end

  def addPortfolio(name)
    @portfolios[name.to_sym] = Porfolio.new(name)
  end

  def buyStock(portfolioName, id, numShares)
    price = Porfolio.getStockPrice(id)
    if price * numShares <= @cash
      portfolios[portfolioName.to_sym].addStock(id, numShares)
      @cash -= (price * numShares)
    else
      raise RunTimeError "NOT ENOUGH MONEY!"
    end
  end

  def sellStock(portfolioName, id, numShares)
    price = Porfolio.getStockPrice(id)
    portfolios[portfolioName.to_sym].removeStock(id, numShares)
    @cash += (price * numShares)
  end

  def to_s
    printString = "\n#{@name} \n"
    @portfolios.each { |portfolio|  printString << "#{portfolio.name}: #{portfolio.value}: \n"}
    return printString
  end

end



class Porfolio

  attr_reader :value, :stocks, :name
  attr_writer
  attr_accessor

  def initialize(name)
    @name = name
    @value = nil
    @stocks = {}
  end

  def addStock(id, numShares)
    if @stocks[id.to_sym].nil?
      @stocks[id.to_sym] = {:id => id, :numShares => numShares}
    else
      @stocks[id.to_sym][:numShares] += numShares
    end
  end

  def removeStock(id, numShares)
    @stocks[id.to_sym][:numShares] -= numShares
    @stocks.delete_if{ |key, value| value[:numShares] <= 0}
  end

  def self.getStockPrice(id)
    if $isOnline
      YahooFinance::get_quotes(YahooFinance::StandardQuote, id)[id].lastTrade
    else
      rand(1...100)
    end
  end

  def update
    updateValue = 0
    @stocks.each do |curStockKeys, curStockValues|
      price = Porfolio.getStockPrice(curStockValues[:id])
      updateValue += price.to_f * curStockValues[:numShares]
    end
    @value = updateValue
  end

  def to_s
    printString = "\n#{@name} \n"
    @stocks.each { |stockKeys, stockValues|  printString << "#{stockValues[:id]}: #{stockValues[:numShares]} shares \n"}
    return printString
  end

end
