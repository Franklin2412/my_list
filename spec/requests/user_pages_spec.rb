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
  	before do 
      sign_in user
      visit user_path(user) 
    end
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
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "exampleuser@mylist.com") }
        it { should have_link("Sign out") }
        it { should have_title(user.name) }
        it { should have_selector("div.alert.alert-success", text: "Welcome") } 
      end
  	end
  end
  describe "Edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end
    describe "Page" do
      it { should have_content("Update your profile") }
      it { should have_title(full_title("Edit user")) }
    end
    describe "with invalid information" do
      before { click_button "Update" }
      it { should have_content("error") }
    end
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "New Email" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Update"
      end
    end
  end
end


