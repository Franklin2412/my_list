FactoryGirl.define do 
	factory :user do
		name "Example User"
		email "exampleuser@mylist.com"
		password "foobar"
		password_confirmation "foobar"
	end
end