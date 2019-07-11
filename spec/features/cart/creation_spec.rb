require "rails_helper"

RSpec.describe "Cart Creation", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "In the Item's Show page, I see a link or button to add this item to my cart" do
      visit "/items"
      
      expect(page).to have_link(@hippo.name)
      click_on(@hippo.name)
      expect(current_path).to eq("/items/#{@hippo.id}")

      expect(page).to have_button("Add Item")
      click_on("Add Item")
      expect(current_path).to eq("/items")

      expect(page).to have_content("#{@hippo.name} has been added to your cart.")
      expect(page).to have_content("Cart: 1")

      visit "/items"
      expect(page).to have_link(@giant.name)
      click_on(@giant.name)
      expect(current_path).to eq("/items/#{@giant.id}")

      expect(page).to have_button("Add Item")
      click_on("Add Item")
      expect(current_path).to eq("/items")

      expect(page).to have_content("#{@giant.name} has been added to your cart.")
      expect(page).to have_content("Cart: 2")
    end
  end
end
