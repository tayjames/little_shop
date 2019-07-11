require "rails_helper"

RSpec.describe "Merchant Statistics", type: :feature do
  describe "When I visit a merchant's show page" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = Order.create!(name: "Valentino Valentine", address: "1111 Lovers Lane", city: "Heaven", state: "Hawaii", zip: 77777)
      @order_2 = Order.create!(name: "Hoku Mildrexler", address: "12 Gumball Ave.", city: "Portland", state: "Oregon", zip: 77777)
      @order_3 = Order.create!(name: "Leigh Sachieye", address: "1 Waifu Ln.", city: "Los Angeles", state: "CA", zip: 77777)
      @order_4 = Order.create!(name: "Kevin Chavez", address: "343 Full Set St.", city: "Paris", state: "Georgia", zip: 77777)
      @order_5 = Order.create!(name: "Murphy Welch", address: "777 Club Lav Dr.", city: "Portland", state: "Oregon", zip: 77777)

      @order_items_1 = OrderItem.create!(order: @order_1, item: @ogre, quantity: 1, price_per_item: 3.00)
      @order_items_2 = OrderItem.create!(order: @order_2, item: @hippo, quantity: 1, price_per_item: 3.00)
      @order_items_3 = OrderItem.create!(order: @order_3, item: @giant, quantity: 1, price_per_item: 3.00)
      @order_items_4 = OrderItem.create!(order: @order_4, item: @hippo, quantity: 1, price_per_item: 3.00)
      @order_items_5 = OrderItem.create!(order: @order_5, item: @hippo, quantity: 1, price_per_item: 3.00)
    end

    describe "I see statistics for that merchant" do
      it "displays a count of items for that merchant" do
        visit "/merchants/#{@megan.id}"

        within "#statistics-#{@megan.id}" do
          expect(page).to have_content("Count of Items: 2")
        end

        visit "/merchants/#{@brian.id}"

        within "#statistics-#{@brian.id}" do
          expect(page).to have_content("Count of Items: 1")
        end
      end

      it "displays average price of that merchant's items" do
        visit "/merchants/#{@megan.id}"
        within "#statistics-#{@megan.id}" do
          expect(page).to have_content("Average Item Price: #{number_to_currency(35)}")
        end

        visit "/merchants/#{@brian.id}"

        within "#statistics-#{@brian.id}" do
          expect(page).to have_content("Average Item Price: #{number_to_currency(50)}")
        end
      end

      it "displays distinct cities where my items have been ordered" do
        visit "/merchants/#{@brian.id}"

        within "#statistics-#{@brian.id}" do
          expect(page).to have_content("Cities you can find our monsters: Paris, Portland")
        end

        visit "/merchants/#{@megan.id}"

        within "#statistics-#{@megan.id}" do
          expect(page).to have_content("Cities you can find our monsters: Heaven, Los Angeles")
        end
      end
    end
  end
end
