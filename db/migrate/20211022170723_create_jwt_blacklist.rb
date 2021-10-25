class CreateJwtBlacklist < ActiveRecord::Migration[5.2]
  def change
    create_table :jwt_blacklists do |t|
    end
  end
end
