class ExportService

  require 'rest-client'

  def initialize(payload)
    @payload = payload
  end

  def send
    begin
      url = "https://delivery-center-recruitment-ap.herokuapp.com/"
      x_sent_header = format_date(DateTime.now)
      RestClient.post(url, @payload, :'X-sent' => x_sent_header)
    rescue Exception => e
      p e
    end
  end

  private

  def format_date(date)
    DateFormatService.new(date).format
  end

end