class Car
  AVAILABLE_COLORS = %i(white black green)
  @@default_color_id = 0
  attr_reader :brand, :color_name

  def initialize(brand, options = {})
    @brand = brand.to_s.split('_').map(&:capitalize).join(' ')
    if options[:color]
      @color_name = options[:color].to_s.split('_').map(&:capitalize).join(' ')
    else
      @color_name = AVAILABLE_COLORS[@@default_color_id].to_s.capitalize
      @@default_color_id = (@@default_color_id + 1) % AVAILABLE_COLORS.length
    end
  end
end
