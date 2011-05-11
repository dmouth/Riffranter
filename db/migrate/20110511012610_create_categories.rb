class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories_personas, :id => false do |t|
      t.references :category
      t.references :persona
    end                            
    add_index :categories_personas, [:persona_id, :category_id]
  end

  def self.down
    remove_index :categories_personas, [:persona_id, :category_id]
    drop_table :categories
    drop_table :categories_personas
  end
end