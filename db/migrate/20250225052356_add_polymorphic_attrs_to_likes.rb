class AddPolymorphicAttrsToLikes < ActiveRecord::Migration[8.0]
  def change
    add_column :likes, :likeable_type, :string
    add_column :likes, :likeable_id, :bigint
  end
end
