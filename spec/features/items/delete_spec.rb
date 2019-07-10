require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

        @order_1 = Order.create!(name: "Murphy Welch", address: "777 Club Lav Dr.", city: "Portland", state: "Oregon", zip: 77777)

        @order_items_1 = OrderItem.create!(order: @order_1, item: @hippo, quantity: 1, price_per_item: 3.00)

        @review_1 = @ogre.reviews.create!(title: "Title 1", content: "Description of Review 1", rating: 1)
        @review_2 = @ogre.reviews.create!(title: "Title 2", content: "Description of Review 2", rating: 2)
        @review_3 = @ogre.reviews.create!(title: "Title 3", content: "Description of Review 3", rating: 3)
      end

      it 'I can click a link to delete that item' do
        visit "/items/#{@giant.id}"

        click_link 'Delete'

        expect(current_path).to eq('/items')

        expect(page).to have_css("#item-#{@ogre.id}")
        expect(page).to have_css("#item-#{@hippo.id}")
        expect(page).to_not have_css("#item-#{@giant.id}")
      end

      describe "When I delete an item" do
        it "deletes all reviews associated with that item" do
          visit "items/#{@ogre.id}"

          within "#review-#{@review_1.id}" do
            expect(page).to have_content(@review_1.title)
            expect(page).to have_content(@review_1.content)
            expect(page).to have_content(@review_1.rating)
          end

          within "#review-#{@review_2.id}" do
            expect(page).to have_content(@review_2.title)
            expect(page).to have_content(@review_2.content)
            expect(page).to have_content(@review_2.rating)
          end

          within "#review-#{@review_3.id}" do
            expect(page).to have_content(@review_3.title)
            expect(page).to have_content(@review_3.content)
            expect(page).to have_content(@review_3.rating)
          end

          click_on "Delete"

          expect(page).to_not have_content(@review_1.title)
          expect(page).to_not have_content(@review_2.title)
          expect(page).to_not have_content(@review_3.title)
        end
      end

      describe "Items with Orders cannot be deleted" do
        it "If an item has been ordered I cannot delete that item" do
          visit "/items/#{@hippo.id}"

          expect(page).to_not have_link("Delete")

          visit "/items/#{@ogre.id}"

          expect(page).to have_link("Delete")
        end
      end
    end
  end
end
