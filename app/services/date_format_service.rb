class DateFormatService
  def initialize(date)
    @date = date
  end

  def format
    @date.strftime("%Hh%M - %d/%m/%y")
  end
end