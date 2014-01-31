require 'spec_helper'

describe User do
	before do 
		@user = FactoryGirl::create(:user)
	end

	subject { @user }

	# test required
	it { should respond_to(:name) }
	it { should respond_to(:email) } # tests if subject (@user) has email attribute
	it { should respond_to(:password_digest) } # tests if subject (@user) has email attribute
	it { should respond_to(:password) } # tests if subject (@user) has email attribute
	it { should respond_to(:password_confirmation) } # tests if subject (@user) has email attribute
	it { should respond_to(:remember_token)}
	it { should respond_to(:authenticate)}

	it { should be_valid }
	it { should_not be_admin }

	describe "with admin attribute set to true" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end

		it { should be_admin}
	end

	it { should respond_to(:authenticate) }

	describe "when name is not present" do
		before { @user.name = ' ' }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = ' ' } 
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before {@user.name = "a"*100}
		it { should_not be_valid }
	end

	describe "when email is invalid" do
		it "should be invalid" do
			addresses = %w[user@yahoo,com user_at_foo.org user@foo. foo@bar_baz.com foo@boar+bass.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email is valid" do
		it "should be valid" do 
			addresses = %w[markronquillo23@gmail.com markronquillo@yahoo.com yehey@facebook.com]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email is already taken" do
		before do
			user_with_the_same_email = @user.dup
			user_with_the_same_email.email = @user.email.upcase
			user_with_the_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before do
			@user.password = " "
			@user.password_confirmation	= " "
		end

		it { should_not be_valid }
	end

	describe "when password confirmation doesn't match" do 
		before { @user.password_confirmation = "mismatch" }

		it { should_not be_valid }
	end

	describe "when password is too short" do
		before { @user.password = @user.password_confirmation = 'a'*5}
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save } # save the user model
		let(:found_user) { User.find_by(email: @user.email) } # then retrieve it store in found_user variable

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) } # test authentication
		end

		describe "with invalid password" do
			let (:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false } # specify and it is synonym, we only use the specify to sound better
		end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end
end
