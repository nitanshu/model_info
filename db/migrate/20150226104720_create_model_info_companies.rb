class CreateModelInfoCompanies < ActiveRecord::Migration
  def change
    create_table :model_info_companies do |t|
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end
