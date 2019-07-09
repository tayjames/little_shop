require "rails_helper"

RSpec.describe "Review Statistics", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

      @review_1 = @ogre.reviews.create!(title: "Title 1", content: "Description of Review 1", rating: 1)
      @review_2 = @ogre.reviews.create!(title: "Title 2", content: "Description of Review 2", rating: 2)
      @review_3 = @ogre.reviews.create!(title: "Title 3", content: "Description of Review 3", rating: 3)
      @review_4 = @ogre.reviews.create!(title: "Title 4", content: "Description of Review 4", rating: 4)
      @review_5 = @ogre.reviews.create!(title: "Title 5", content: "Description of Review 5", rating: 5)
      @review_6 = @ogre.reviews.create!(title: "Title 6", content: "Description of Review 6", rating: 5)
      @review_7 = @ogre.reviews.create!(title: "Title 7", content: "Description of Review 7", rating: 5)
      @review_8 = @ogre.reviews.create!(title: "Title 8", content: "Description of Review 8", rating: 5)
    end

    describe "When I visit an item's show page" do
      it "I see an area on the page for statistics about reviews" do
        visit "/items/#{@ogre.id}"

        within "#top-reviews" do
          expect(page.all('li')[0]).to have_content("Title: #{@review_5.title}")
          expect(page.all('li')[1]).to have_content("Rating: #{@review_5.rating}")
          expect(page.all('li')[2]).to have_content("Title: #{@review_6.title}")
          expect(page.all('li')[3]).to have_content("Rating: #{@review_6.rating}")
          expect(page.all('li')[4]).to have_content("Title: #{@review_7.title}")
          expect(page.all('li')[5]).to have_content("Rating: #{@review_7.rating}")
        end

        within "#worst-reviews" do
          expect(page.all('li')[0]).to have_content("Title: #{@review_1.title}")
          expect(page.all('li')[1]).to have_content("Rating: #{@review_1.rating}")
          expect(page.all('li')[2]).to have_content("Title: #{@review_2.title}")
          expect(page.all('li')[3]).to have_content("Rating: #{@review_2.rating}")
          expect(page.all('li')[4]).to have_content("Title: #{@review_3.title}")
          expect(page.all('li')[5]).to have_content("Rating: #{@review_3.rating}")
        end

        expect(page).to have_content("Average Rating: 3.75")
      end
    end
  end
end
