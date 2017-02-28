class CarPark
  attr_reader :cars, :capacity

  def initialize(capacity)
    @capacity = capacity
    @cars = []
  end

  def places_left
    @capacity - cars.length
  end

  def receive(cars)
    @cars += [cars].flatten.shift(places_left)
  end

  def retrieve(taken_cars_count)
    @cars.pop(taken_cars_count)
  end

  def brands
    cars.map(&:brand).uniq
  end

  def brands_stats
    grouped = cars.group_by(&:brand)
    grouped.each_pair {|brand, cars| grouped[brand] = cars.count }
  end
end
