class CreateMatters < ActiveRecord::Migration[6.0]
  def change
    create_table :matters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :place

      t.timestamps
    end
  end
end
