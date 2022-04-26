
class FoodTruck
  attr_reader :name,
              :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def check_stock(item)
  @inventory.find do |k, v|
    item == k
    return v
    end
  end

  def potential_revenue
    revenue = 0
    @inventory.map do |items|
      revenue += items[0].price * items[1]
    end
    revenue
  end

end
