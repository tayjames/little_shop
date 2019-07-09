require 'rails_helper'

RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

      @order_1 = Order.create!(name: "Hoku Mildrexler", address: "12 Gumball Ave.", city: "Portland", state: "Oregon", zip: 77777)
      @order_items_1 = OrderItem.create!(order: @order_1, item: @hippo, quantity: 1, price_per_item: 3.00)
    end

    it 'I see merchant name and address' do
      visit "/merchants/#{@megan.id}"

      expect(page).to have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(@megan.address)
        expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
      end
    end

    it 'I see a link to this merchants items' do
      visit "/merchants/#{@megan.id}"

      click_link "Items"
    end

    describe "If a merchant has items that have been ordered" do
      it "there is no button visible for me to delete the merchant" do
        visit "/merchants/#{@brian.id}"

        expect(page).to_not have_button('Delete')

        visit "/merchants/#{@megan.id}"

        expect(page).to have_button('Delete')
      end
    end
  end
end
