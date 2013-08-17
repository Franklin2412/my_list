require 'spec_helper'

describe "User Pages" do
	subject { page }
	describe "Signup page" do
		before { visit signup_path }
		it { should have_title(full_title('Signup')) }
		it { should have_content('Signup') }
	end
  	describe "profile page" do
  		let(:user) { FactoryGirl.create(:user) }
  		before { visit user_path(user) }
  		it { should have_title(full_title(user.name)) }
  		it { should have_content(user.name) }
  	end
  	describe "signup" do
  		before { visit signup_path }
  		let(:submit) { "Signup" }
  		describe "with invalid information" do
  			it "should not create an user" do
  				expect { click_button submit }.not_to change(User, :count)
  			end
  		end
  		describe "with valid information" do
  			before do
  				fill_in "Name",			with: "Example User"
  				fill_in "Email", 		with: "exampleuser@mylist.com"
  				fill_in "Password", 	with: "foobar"
  				fill_in "Confirmation", with: "foobar"	
  			end
  			it "should create an user" do
  				expect { click_button submit }.to change(User, :count).by(1)
  			end
  		end
  	end
end


