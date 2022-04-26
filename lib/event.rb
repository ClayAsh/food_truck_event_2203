
class Event
  attr_reader :name,
              :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |trucks|
      trucks.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck|
      truck.inventory.include?(item)
    end
  end

# Return a sorted list of Item names for an Event (from it3 prompt)
#couldn't figure out how to sort an array of the item objects by name 
  def sorted_item_list
    item_list = []
    @food_trucks.map do |truck|
      truck.inventory.find_all do |item|
        item_list << item[0].name
      end
    end
    item_list.sort.uniq
  end

  def overstocked_items
    overstocked = []
    total_inventory.each_pair do |item, inventory|
      if inventory[:food_trucks].count > 1 && inventory[:quantity] > 50
        overstocked << item
      end
    end
    overstocked
  end

  def total_inventory
    inventory_hash = {}
    @food_trucks.map do |truck|
      truck.inventory.map do |item, quantity|
        if inventory_hash[item].nil?
          inventory_hash[item] = {quantity: quantity, food_trucks: [truck]}
        else
        inventory_hash[item][:quantity] += quantity
        inventory_hash[item][:food_trucks] << truck
        end
      end
    end
    inventory_hash
  end
end
