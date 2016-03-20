class ChangeApplyforTypeInApplicants < ActiveRecord::Migration
  
  def change
    change_column :applicants, :apply_for, :string
    change_column :applicants, :phone, :string
    remove_column :applicants, :upload_cv
  end
  
  
end
