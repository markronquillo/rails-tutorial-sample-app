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

  shared_examples_for "all static pages" do
		it { should have_selector('h1', heading) }
		it { should have_title(title) }
  end

	describe "Home Page" do 
		before { visit root_path }
		let(:heading) { 'Sample App' }
		let(:title) { '' }

		it_should_behave_like "all static pages"
		it { should_not have_title('| Home') }
	end

	describe "Help Page" do 
		before { visit help_path }
		let(:heading) { 'Help' }
		let(:title) { '' }

		it_should_behave_like "all static pages"
	end

	describe "About Us Page" do
		before { visit about_path }
		let(:heading) { 'About' }
		let(:title) { 'About' }

		it_should_behave_like "all static pages"
	end

	describe "Contact Page" do 
		before{ visit contact_path }

		let(:heading) { 'Contact' }
		let(:title) { 'Contact' }

		it_should_behave_like "all static pages"
	end

	it "should have right links" do 
		visit root_path
		click_link "About"
		expect(page).to have_title('About')
	end
end
