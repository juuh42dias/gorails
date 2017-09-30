class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :type
      t.string :origin_type
      t.boolean :situation
      t.references :origin, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
