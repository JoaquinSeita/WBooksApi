class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :Genre
      t.string :Author
      t.string :Image
      t.string :Title
      t.string :Publisher
      t.string :Year
      t.timestamps
    end
  end
end
