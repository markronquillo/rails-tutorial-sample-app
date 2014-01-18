require 'spec_helper'

describe "StaticPages" do
  # describe "GET /static_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get static_pages_index_path
  #     response.status.should be(200)
  #   end
  # end

  	describe "Home Page" do 
  		it "should have content, 'Sample App'" do
  			visit '/static_pages/home'
  			expect(page).to have_content("Sample App")
		end

		it "shoud have title, Home" do
			visit '/static_pages/home'
			expect(page).to have_title('Ruby on Rails Tutorial Sample App')
		end

		it "should not have custom page title" do
			visit '/static_pages/home'
			expect(page).not_to have_title('| Home')
		end
	end

	describe "Help Page" do 
		it "should have content, 'Help'" do 
			visit "/static_pages/help"
			expect(page).to have_content('Help')
		end

		it "shoud have title, Help" do
			visit '/static_pages/help'
			expect(page).to have_title('Help')
		end
	end

	describe "About Us Page" do
		it "should have content, About Us" do
			visit "/static_pages/about"
			expect(page).to have_content('About Us')
		end

		it "shoud have title, About" do
			visit '/static_pages/about'
			expect(page).to have_title('About')
		end
	end
end
