class CreateDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :details do |t|
      t.string :name
      t.string :string
      t.string :age
      t.string :integer
      t.string :phone
      t.string :title
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
