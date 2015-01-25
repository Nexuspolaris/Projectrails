class CreateTypeDocs < ActiveRecord::Migration
  def self.up
    create_table :type_docs do |t|
      t.string :libelle

      t.timestamps
    end
  end
  def self.down
    drop_table :type_docs
  end
end
