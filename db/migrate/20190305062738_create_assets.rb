class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.string :file_name, null: false
      t.json :file_body, null: false, default: {}

      t.timestamps
    end

    add_index :assets, :file_name, unique: true
  end
end
