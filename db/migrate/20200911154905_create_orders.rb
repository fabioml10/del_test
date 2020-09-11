class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :externalCode
      t.integer :storeId
      t.string :subTotal
      t.string :deliveryFee
      t.string :total

      t.string :country
      t.string :state
      t.string :city
      t.string :district
      t.string :street
      t.string :complement

      t.decimal :latitude, precision: 6
      t.decimal :longitude, precision: 6

      t.string :dtOrderCreate
      t.string :postalCode
      t.string :number

      t.jsonb :customer
      t.jsonb :items
      t.jsonb :payments

      t.timestamps
    end
  end
end
