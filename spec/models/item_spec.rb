require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it { should belong_to :merchant }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }

    it { should have_many :reviews }
  end

  describe "instance methods" do
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

    describe "#sort_reviews" do
      it "returns the top 3 reviews for an item" do
        expect(@ogre.sort_reviews(:desc, 3)).to eq([@review_5, @review_6, @review_7])
      end

      it "returns the bottom 3 reviews for an item" do
        expect(@ogre.sort_reviews(:asc, 3)).to eq([@review_1, @review_2, @review_3])
      end
    end

    describe "#average_rating" do
      it "returns the average rating of all reviews for an item" do
        expect(@ogre.average_rating.to_f).to eq(3.75)
      end
    end
  end
end
