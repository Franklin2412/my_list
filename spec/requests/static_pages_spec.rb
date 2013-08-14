require 'spec_helper'

describe "Static pages" do
  subject { page } 
  describe "About page" do
    before { visit about_path }
    it { should have_title(full_title('About')) }
    it { should have_content('About') }
  end
end