class AddGuardianNameToDistributorComplaint < ActiveRecord::Migration
  def change
    add_column :distributor_complaints, :guardian_name, :string
    add_column :distributor_complaints, :dob, :date
    add_column :distributor_complaints, :gender, :string
    add_column :distributor_complaints, :educational_qualification, :string
    add_column :distributor_complaints, :permanent_address, :string
    add_column :distributor_complaints, :present_address, :string
    add_column :distributor_complaints, :marital_status, :string
    add_column :distributor_complaints, :contact_no, :string
    add_column :distributor_complaints, :alternate_contact_no, :string
    add_column :distributor_complaints, :occupation, :string
    add_column :distributor_complaints, :current_income, :string
    add_column :distributor_complaints, :working_hrs, :string
    add_column :distributor_complaints, :total_exp, :string
    add_column :distributor_complaints, :source_of_adv, :string
    add_column :distributor_complaints, :submitted_name, :string
  end
end
