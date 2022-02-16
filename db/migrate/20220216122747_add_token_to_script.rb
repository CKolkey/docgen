class AddTokenToScript < ActiveRecord::Migration[7.0]
  def change
    add_column :scripts, :token, :text
  end
end
