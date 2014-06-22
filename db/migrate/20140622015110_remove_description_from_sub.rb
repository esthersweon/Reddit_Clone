class RemoveDescriptionFromSub < ActiveRecord::Migration
  def change
  	remove_column :subs, :description
  end
end
