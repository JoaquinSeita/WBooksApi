class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.date :from, null: false
      t.date :to, null: false
      t.date :returned_at, null: false, default: nil
    end
  end
end
