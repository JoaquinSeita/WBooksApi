class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.date :from, null: false, default: Date.today
      t.date :to, null: false
    end
  end
end
