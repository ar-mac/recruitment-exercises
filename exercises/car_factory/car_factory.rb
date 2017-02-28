require_relative 'car'

class CarFactory
  SUPPORTED_BRANDS = %i(fiat lancia ford subaru)
  attr_reader :brands

  def initialize(name, options = {})
    @name = name

    brands = [options[:brands]].flatten
    unless (brands - SUPPORTED_BRANDS).empty?
      raise UnsupportedBrandException, "Brand not supported: '#{brands[0].capitalize}'"
    end
      @brands = brands
  end

  def make_car(brand = nil)
    brand_not_supported = brand && !brands.include?(brand)
    brand_required_but_empty = brand.nil? && brands.length > 1
    if brand_not_supported || brand_required_but_empty
      raise UnsupportedBrandException, "Factory does not have a brand or do not support it"
    end

    Car.new(brand || brands[0])
  end

  def name
    "#{@name} (produces #{brands.map(&:capitalize).join(', ')})"
  end

  def make_cars(options)
    cars = []
    if options.respond_to?(:each_pair)
      options.select! { |brand, count| SUPPORTED_BRANDS.include? brand }
      options.each_pair do |brand, count|
        count.times { cars << make_car(brand) }
      end
    else
      options.times do |n|
        cars << make_car(brands[n % brands.length])
      end
    end

    cars
  end

  class UnsupportedBrandException < Exception
  end
end
