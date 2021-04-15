require "rails_helper"

RSpec.describe User, type: :model do

  context "columns" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:reset_sent_at).of_type(:datetime) }
    it { should have_db_column(:role).of_type(:integer) }
    it { should have_db_column(:status).of_type(:boolean) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
    it { should have_many(:spending_plans).dependent(:destroy) }
    it { should have_many(:user_diaries).dependent(:destroy) }
    it { should have_many(:budgets).dependent(:destroy) }
    it { should have_many(:allow_sharings).dependent(:destroy) }
  end

  describe "#downcase_email" do
    it "downcases an email before saving" do
      user = User.new(email: "DOWNCASE@gmail.com")
      user.run_callbacks(:save)
      expect(user.email).to eq("downcase@gmail.com")
    end
  end

  describe ".digest" do
    password_test = "123123"
    it "convert password to Bcrypt" do
      expect(password_test == User.digest(password_test)).to be false
    end
  end
end
