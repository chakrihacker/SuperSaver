class CreateDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :deals do |t|
      t.string :deal_type
      t.string :name
      t.string :description
      t.string :vendor
      t.boolean :is_local_deal
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.boolean :status
      t.datetime :end_date
      t.decimal :min_price
      t.string :cashback
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
