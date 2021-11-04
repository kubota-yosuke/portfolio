class AddColumnToMatter < ActiveRecord::Migration[6.0]
  def change
    add_column :matters, :start_time, :datetime
    add_column :matters, :finish_time, :datetime
  end
end
