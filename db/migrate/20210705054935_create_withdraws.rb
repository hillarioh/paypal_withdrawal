class CreateWithdraws < ActiveRecord::Migration[6.1]
  def change
    create_table :withdraws do |t|
      t.integer :amount
      t.boolean :convert

      t.timestamps
    end
  end
end
