class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product
      t.string :location
      t.string :status
      t.string :investors
      t.string :kitna
    end
  end
end
