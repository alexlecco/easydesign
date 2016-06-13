class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cost, :decimal, precision: 10, scale: 3
  end
end
