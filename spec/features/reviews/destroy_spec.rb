require "rails_helper"

RSpec.describe "Delete a Review", type: :feature do
  describe "As a visitor" do
    describe "When I visit an item's show page" do
      before(:each) do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)

        @review_1 = @hippo.reviews.create!(title: "Title 1", content: "Description of Review 1", rating: 1)
        @review_2 = @hippo.reviews.create!(title: "Title 2", content: "Description of Review 2", rating: 2)
        @review_3 = @hippo.reviews.create!(title: "Title 3", content: "Description of Review 3", rating: 3)
      end

      it "I see a link next to each review to delete the review" do
        visit item_path(@hippo)

        within "#review-#{@review_1.id}" do
          expect(page).to have_button("Delete Review")
        end

        within "#review-#{@review_2.id}" do
          expect(page).to have_button("Delete Review")
        end

        within "#review-#{@review_3.id}" do
          expect(page).to have_button("Delete Review")
        end
      end

      it "When I delete a review I am returned to the item's show page and no longer see that review" do

        visit item_path(@hippo)

        within "#review-#{@review_2.id}" do
          click_button "Delete Review"
        end

        expect(current_path).to eq(item_path(@hippo))
        expect(page).to_not have_content(@review_2.title)
        expect(page).to_not have_content(@review_2.content)

        within "#review-#{@review_1.id}" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_1.content)
          expect(page).to have_content(@review_1.rating)
        end

        within "#review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content(@review_3.content)
          expect(page).to have_content(@review_3.rating)
        end
      end
    end
  end
end
