
class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title  , :null => false
      t.string :author
      t.string :publisher

      t.timestamps
    end
    #change_column :books, :title , :string , :null =>false
  end
end
