class CreateTaggedFiles < ActiveRecord::Migration
  def change
    create_table :tagged_files do |t|
      t.text :sha1
      t.integer :size
      t.text :original_filename
      t.text :comment

      t.timestamps
    end
  end
end
