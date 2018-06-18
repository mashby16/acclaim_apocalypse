class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :badge
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
