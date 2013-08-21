require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Bobby Example", email: "derp@doodie.com", password: "meyowmix", password_confirmation: "meyowmix")
  end

  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}

  it {should be_valid}

  describe "when name is not present" do
    before { @user.name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it {should_not be_valid}
  end

  describe "when a name is too long +50chars" do
    before {@user.name = "b" * 51 }
    it { should_not be_valid}
  end

  describe "when and email is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo foo@bar_baz.com foo@bar+baz.com 34534543atjingledotcom]
      addresses.each do |invalid|
        @user.email = invalid
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when an email is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org some.thing@check.jp a+b@baz.cn]
      addresses.each do |valid|
        @user.email = valid
        expect(@user).to be_valid
      end
    end
  end

  describe "when an email addy is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Bobby Example", email: "derp@doodie.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it {should be_invalid}
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
  
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end