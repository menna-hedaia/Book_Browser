class ChangeColumn < ActiveRecord::Migration
  def up
  	change_column :books, :title, :string, :null => false
  end

  def down
  end
end
