require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }
	describe "sign in  page" do
		before { visit signin_path }
		it { should have_content("Sign in") }
		it { should have_title("Sign in") }
	end
	describe "Signin" do
		before { visit signin_path }
		describe " with invalid information " do
			before { click_button "Sign in" }
			it { should have_title("Sign in") }
			it { should have_selector("div.alert.alert-error", text: "Mismatch") }
		end
		describe "with valid information" do
			let(:user){ FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Sign in"
			end
			it { should have_title(user.name) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }
			describe "followed by signout " do
				before { click_link "Sign out" }
				it { should have_title('Sign in') }
			end
		end
	end
	describe "Authorization" do
		describe " For non signed in users" do 
			let(:user) { FactoryGirl.create(:user) }
			describe "in users control" do
				describe "submitting update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end
		end
	end
end
