require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(name: "Example User", email: "user@example.com") }
  subject { @user }

  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:email) }
#  どっちでも通る is_expectedはexpect(subject)として定義されてる
#  it { is_expected.to respond_to(:name) }
#  it { is_expected.to respond_to(:email) }
  it { is_expected.to be_valid }  

  describe "whn name is not present" do
    before { @user.name = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { is_expected.not_to be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_bar.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        is_expected.not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        is_expected.to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { is_expected.not_to be_valid }
  end

end
