class ParserController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :init_order, only: [:create]

  def create
    
    begin
      new_order = Order.create(@parsed_order)
      export(new_order.as_json(except: :id))
      render json: new_order.as_json(except: :id), status: :ok
    rescue Exception => e
      render json: {message: e}, status: :unprocessable_entity
    end
    
  end

  private

  def order_params
    params.permit(:id, :store_id, :date_created, :total_amount, :total_shipping, :paid_amount,
      order_items: [:quantity, :unit_price, :full_unit_price, item: [:id, :title]],
      payments: [:payment_type, :total_paid_amount],
      shipping: [receiver_address: [:street_name, :street_number, :comment, :zip_code, :latitude, :longitude, city: [:name], state: [:name], country: [:id], neighborhood: [:name]]],
      buyer: [:id, :nickname, :email, phone: [:area_code, :number]]
    )
  end

  def init_order
    @parsed_order = ParserService.new(order_params).parse
  end

  def export(order)
    ExportService.new(order).send
  end

end
