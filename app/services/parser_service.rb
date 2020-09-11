class ParserService
  def initialize(order)
    @order = order
  end

  def parse
    {
      externalCode: @order[:id],
      storeId: @order[:store_id],
      subTotal: @order[:total_amount],
      deliveryFee: @order[:total_shipping],
      total: @order[:paid_amount],
      country: @order[:shipping]["receiver_address"]["country"]["id"],
      state: @order[:shipping]["receiver_address"]["state"]["name"],
      city: @order[:shipping]["receiver_address"]["city"]["name"],
      district: @order[:shipping]["receiver_address"]["neighborhood"]["name"],
      street: @order[:shipping]["receiver_address"]["street_name"],
      complement: @order[:shipping]["receiver_address"]["comment"],
      latitude: @order[:shipping]["receiver_address"]["latitude"],
      longitude:  @order[:shipping]["receiver_address"]["longitude"],
      dtOrderCreate: @order[:date_created],
      postalCode: @order[:shipping]["receiver_address"]["zip_code"],
      number: @order[:shipping]["receiver_address"]["street_number"],

      customer: {
          externalCode: @order[:buyer]["id"],
          name: @order[:buyer]["nickname"],
          email: @order[:buyer]["email"],
          contact: "#{@order[:buyer]['phone']['area_code']}#{@order[:buyer]['phone']['number']}",
      },

      items: order_items_parse(@order[:order_items]),

      payments: order_payments_parse(@order[:payments])
    }
  end

  private

  def order_items_parse(items)
    result = []
    items.each do |item|
      result << {
        externalCode: item["item"]["id"],
        name: item["item"]["title"],
        price: item["unit_price"],
        quantity: item["quantity"],
        total: item["full_unit_price"],
        subItems: []
      }
    end

    result
  end

  def order_payments_parse(payments)
    result = []
    payments.each do |payment|
      result << {
        type: payment["payment_type"].upcase,
        value: payment["total_paid_amount"]
      }
    end

    result
  end

end
