class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :object
      t.text :body
      t.boolean :read

      t.timestamps
    end
  end
end
