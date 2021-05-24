class CreateBanknoteData < ActiveRecord::Migration[6.0]
  def change
    create_table :banknote_data do |t|
      t.integer :banknote1
      t.integer :banknote2
      t.integer :banknote5
      t.integer :banknote10
      t.integer :banknote25
      t.integer :banknote50

      t.timestamps
    end
  end
end
