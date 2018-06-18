class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end