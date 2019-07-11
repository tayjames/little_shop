require "rails_helper"
include ActionView::Helpers::NumberHelper

RSpec.describe "New Order Page", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    describe "When I check out from my cart" do
      it "I see the details of my cart and I see a form to enter my shipping info for the order" do

        ogre_item_quantity = 1
        hippo_item_quantity = 2

        visit "/items/#{@ogre.id}"
        click_on("Add Item")

        visit "/items/#{@hippo.id}"
        click_on("Add Item")

        visit "/cart"

        within "#item-#{@hippo.id}" do
          click_on("+")
        end

        expect(page).to have_link("Checkout")
        click_on("Checkout")
        expect(current_path).to eq("/orders/new")

        within "#item-#{@ogre.id}" do
          expect(page).to have_content("Name: #{@ogre.name}")
          expect(page).to have_content("Merchant: #{@ogre.merchant.name}")
          expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
          expect(page).to have_content("Quantity: #{ogre_item_quantity}")
          expect(page).to have_content("Subtotal: #{number_to_currency(@ogre.price * ogre_item_quantity)}")
        end

        within "#item-#{@hippo.id}" do
          expect(page).to have_content("Name: #{@hippo.name}")
          expect(page).to have_content("Merchant: #{@hippo.merchant.name}")
          expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
          expect(page).to have_content("Quantity: #{hippo_item_quantity}")
          expect(page).to have_content("Subtotal: #{number_to_currency(@hippo.price * hippo_item_quantity)}")
        end

        expect(page).to have_content("Grand Total: #{number_to_currency(120)}")

        expect(page).to have_content("Name")
        expect(page).to have_content("Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zip")
        expect(page).to have_button("Create Order")
      end
    end

    describe "When I fill out all information on the new order page, and click on 'Create Order'" do
      describe "An order is created & saved in the database" do
        it "I am redirected to that order's show page" do
          visit "/items/#{@ogre.id}"
          click_on("Add Item")

          visit "/items/#{@hippo.id}"
          click_on("Add Item")

          visit "/cart"

          within "#item-#{@hippo.id}" do
            click_on("+")
          end

          click_on("Checkout")
          expect(current_path).to eq("/orders/new")

          fill_in "Name", with: "Valentino Valentine"
          fill_in "Address", with: "1111 Lovers Lane"
          fill_in "City", with: "Heaven"
          fill_in "State", with: "Hawaii"
          fill_in "Zip", with: 77777

          expect(page).to have_button("Create Order")
          click_on "Create Order"

          expect(page).to have_content("Cart: 0")

          new_order = Order.last

          ogre_item_quantity = 1
          hippo_item_quantity = 2

          expect(current_path).to eq("/orders/#{new_order.id}")

          expect(page).to have_content(new_order.name)
          expect(page).to have_content(new_order.address)
          expect(page).to have_content(new_order.city)
          expect(page).to have_content(new_order.state)
          expect(page).to have_content(new_order.zip)

          within "#item-#{@ogre.id}" do
            expect(page).to have_content("Item: #{@ogre.name}")
            expect(page).to have_content("Merchant: #{@ogre.merchant.name}")
            expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
            expect(page).to have_content("Quantity: #{ogre_item_quantity}")
            expect(page).to have_content("Subtotal: #{number_to_currency((@ogre.price) * ogre_item_quantity)}")
          end

          within "#item-#{@hippo.id}" do
            expect(page).to have_content("Item: #{@hippo.name}")
            expect(page).to have_content("Merchant: #{@hippo.merchant.name}")
            expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
            expect(page).to have_content("Quantity: #{hippo_item_quantity}")
            expect(page).to have_content("Subtotal: #{number_to_currency((@hippo.price) * hippo_item_quantity)}")
          end

          expect(page).to have_content("Created on: #{new_order.created_at.to_date}")
          expect(page).to have_content("Grand Total: #{number_to_currency(120)}")
        end
      end

      describe "From the order creation page" do
        describe "When I click 'Create Order' without completing the shipping address form" do
          it "I see a flash message indicating that I need to complete the form for successful order creation" do
            visit "/items/#{@ogre.id}"
            click_on("Add Item")

            visit "/items/#{@hippo.id}"
            click_on("Add Item")

            visit "/cart"

            within "#item-#{@hippo.id}" do
              click_on("+")
            end

            click_on("Checkout")
            expect(current_path).to eq("/orders/new")

            fill_in "Name", with: "Valentino Valentine"
            # DON'T fill_in "Address"
            fill_in "City", with: "Heaven"
            fill_in "State", with: "Hawaii"
            fill_in "Zip", with: 77777

            click_on "Create Order"

            expect(page).to have_field("Address")
            expect(page).to have_content("Order not created. You are missing required field(s).")
          end
        end
      end
    end
  end
end
