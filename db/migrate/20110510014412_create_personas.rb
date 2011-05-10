class CreatePersonas < ActiveRecord::Migration
  def self.up
    create_table :personas do |t|
      t.string :name
      t.string :title
      t.text :image

      t.timestamps
    end
  end

  def self.down
    drop_table :personas
  end
end
