require 'rails_helper'

RSpec.describe 'Existing Merchant Update' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end

    it 'I can link to an edit merchant page from merchant show page' do
      visit "/merchants/#{@megan.id}"

      click_button 'Edit'

      expect(current_path).to eq("/merchants/#{@megan.id}/edit")
    end

    it 'I can use the edit merchant form to update the merchant information' do
      visit "/merchants/#{@megan.id}/edit"

      name = 'Megans Monsters'
      address = '321 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Update Merchant'

      expect(current_path).to eq("/merchants/#{@megan.id}")
      expect(page).to have_content(name)
      expect(page).to_not have_content(@megan.name)

      within '.address' do
        expect(page).to have_content(address)
        expect(page).to have_content("#{city} #{state} #{zip}")
      end
    end

    describe "When I am updating a new merchant" do
      describe "If I try to submit the form with incomplete information" do
        it 'I see a flash message indicating which field(s) I am missing - Name' do
          visit "/merchants/#{@megan.id}/edit"

          name = 'Megans Marmalades'
          address = '123 Main St'
          city = "Denver"
          state = "CO"
          zip = 80218

          # fill_in 'Name', with: name
          fill_in 'Address', with: address
          fill_in 'City', with: city
          fill_in 'State', with: state
          fill_in 'Zip', with: zip

          click_button 'Update Merchant'

          expect(page).to have_content("Name can't be blank")
        end

        it 'I see a flash message indicating which field(s) I am missing - Address' do
          visit "/merchants/#{@megan.id}/edit"

          name = 'Megans Marmalades'
          address = '123 Main St'
          city = "Denver"
          state = "CO"
          zip = 80218

          fill_in 'Name', with: name
          # fill_in 'Address', with: address
          fill_in 'City', with: city
          fill_in 'State', with: state
          fill_in 'Zip', with: zip

          click_button 'Update Merchant'

          expect(page).to have_content("Address can't be blank")
        end

        it 'I see a flash message indicating which field(s) I am missing - City' do
          visit "/merchants/#{@megan.id}/edit"

          name = 'Megans Marmalades'
          address = '123 Main St'
          city = "Denver"
          state = "CO"
          zip = 80218

          fill_in 'Name', with: name
          fill_in 'Address', with: address
          # fill_in 'City', with: city
          fill_in 'State', with: state
          fill_in 'Zip', with: zip

          click_button 'Update Merchant'

          expect(page).to have_content("City can't be blank")
        end

        it 'I see a flash message indicating which field(s) I am missing - State' do
          visit "/merchants/#{@megan.id}/edit"

          name = 'Megans Marmalades'
          address = '123 Main St'
          city = "Denver"
          state = "CO"
          zip = 80218

          fill_in 'Name', with: name
          fill_in 'Address', with: address
          fill_in 'City', with: city
          # fill_in 'State', with: state
          fill_in 'Zip', with: zip

          click_button 'Update Merchant'

          expect(page).to have_content("State can't be blank")
        end

        it 'I see a flash message indicating which field(s) I am missing - Zip' do
          visit "/merchants/#{@megan.id}/edit"

          name = 'Megans Marmalades'
          address = '123 Main St'
          city = "Denver"
          state = "CO"
          zip = 80218

          fill_in 'Name', with: name
          fill_in 'Address', with: address
          fill_in 'City', with: city
          fill_in 'State', with: state
          # fill_in 'Zip', with: zip

          click_button 'Update Merchant'

          expect(page).to have_content("Zip can't be blank")
        end
      end
    end
  end
end
