require 'spec_helper'

describe 'User' do

  before {@user = User.new(name: 'Nir', email: 'nir@example.com',
                          password: 'foobar', password_confirmation: 'foobar')}
  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:admin)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}

  it{should be_valid}
  it{should_not be_admin}

  describe "accessible attributes" do
    it "should not have allow access to admin" do
      expect do
        User.new(admin: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'when name is empty' do
    before {@user.name=''}
    it {should be_valid}
  end

  describe 'when email is empty' do
    before {@user.email=''}
    it {should_not be_valid}
  end

  describe 'when name already exists' do
    before do
      duplicate_user = @user.dup
      duplicate_user.email='other@exaple.com'
      duplicate_user.save
    end
    it {should_not be_valid}
  end

  describe 'when email already exists' do
    before do
      duplicate_user =@user.dup
      duplicate_user.email = @user.email.upcase
      duplicate_user.save
    end
    it{should_not be_valid}
  end

  describe 'when email is in the correct format' do
    it 'should be valid' do
      addresses = %w[a@b.com a1@bb.il a+b@asd.cv.or]
      addresses.each do |address|
        @user.email=address
        should be_valid
      end
    end
  end

  describe 'when email is NOT in the correct format' do
    it 'should not be valid' do
      addresses = %w[b.com a1@bb,il a+b@a+sd.cv.or]
      addresses.each do |address|
        @user.email=address
        should_not be_valid
      end
    end
  end

  describe 'when password is not present' do
    before {@user.password = @user.password_confirmation = ''}
    it{ should_not be_valid}
  end

  describe 'when password dont match confirmation' do
    before{@user.password_confirmation = 'mismatch'}
    it{should_not be_valid}
  end

  describe 'when password too short' do
    before {@user.password = @user.password_confirmation = 'aaaaa'}
    it{ should_not be_valid}
  end

  describe 'return value of authenticate method' do
    before {@user.save}
    let(:found_user) { User.find_by_email(@user.email) }

    describe 'with valid password' do
      it { should == founduser.authenticate(@user.password)}
    end

    describe 'with invalid password' do
      let(:invalid_password_user){found_user.authenticate('invalid')}
      it {should_not ==invalid_password_user}
      specify {invalid_password_user.should be_false}
    end
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank}
  end
end
