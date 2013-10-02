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
  it {should respond_to(:remember_token)}  #token to keep track of persistant login
  it {should respond_to(:authenticate)}
  it {should respond_to(:admin)}
  it {should respond_to(:microposts)}
  it {should respond_to(:feed)}
  it {should respond_to(:relationships)}

  it {should be_valid}
  it {should_not be_admin}

  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end

    it "should be newest to oldest order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do  #user destroy = micro destroy
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micro|
        expect(Micropost.where(id: micro.id)).to be_empty
      end
    end
  end

  describe " with admin attributes set to TRUE" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {should be_admin}
  end

  describe "when name is not present" do
    before { @user.name = " "}
    it {should_not be_valid}
  end

  describe "remember_token" do    #check for a valid token
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it {should_not be_valid}
  end

  describe "email with mixed cases" do
    let(:mixed_case) { "CaPit@AlS.CoM" }

    it "should all be saved to lower case" do
      @user.email = mixed_case
      @user.save
      expect(@user.reload.email).to eq mixed_case.downcase
    end
  end

  describe "when a name is too long +50chars" do
    before {@user.name = "b" * 51 }
    it { should_not be_valid}
  end

  describe "when and email is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo foo@bar_baz.com foo@bar+baz.com 34534543atjingledotcom foo@bar..com]
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