class AddIsRead < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :is_read?, :boolean, default:false
  end
end
