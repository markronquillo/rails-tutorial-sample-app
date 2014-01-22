require 'spec_helper'

describe "StaticPages" do
  # describe "GET /static_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get static_pages_index_path
  #     response.status.should be(200)
  #   end
  # end

  subject {page}

	describe "Home Page" do 
		before { visit root_path }
		it { should have_content("Sample App") }
		it { should have_title('Ruby on Rails Tutorial Sample App') }
		it { should_not have_title('| Home') }
	end

	describe "Help Page" do 
		before { visit help_path }
		it { should have_content('Help') }
		it { should have_title('Help') }
	end

	describe "About Us Page" do
		before { visit about_path }
		it { should have_content('About Us') }
		it { should have_title('About') }
	end

	describe "Contact Page" do 
		before{ visit contact_path }

		it { should have_content('Contact') }
		it { should have_title('Contact') }
	end

end
