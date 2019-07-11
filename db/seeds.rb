# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

hof = Merchant.create!(name: "House of Flora's Fresh Fruit and Flowers", address: "777 Secret Ave.", city: "Denver", state: "CO", zip: 80202)
val = Merchant.create!(name: "Valentino's Valentines", address: "720 Ash Ave", city: 'Denver', state: 'CO', zip: 80218)
leigh = Merchant.create!(name: 'Lauretta Jeans', address: '125 Main St', city: 'Portland', state: 'OR', zip: 97202)
hoku = Merchant.create!(name: "Fresh Refreshmants", address: '214 Jakes House', city: 'Portland', state: 'OR', zip: 97212)
hof.items.create!(name: 'Assorted Flowers', description: "Los flores", price: 2000, image: 'https://payload.cargocollective.com/1/20/666861/13467193/R0022978_2500_c.jpg', active: true, inventory: 5 )
val.items.create!(name: 'Roses/Flowers/Card Combo', description: "Ask about a la cart options.", price: 200, image: 'https://payload.cargocollective.com/1/20/666861/13467193/R0022978_2500_c.jpg', active: true, inventory: 5 )
leigh.items.create!(name: 'Pie', description: "Only pumpkin", price: 50, image: 'https://static1.squarespace.com/static/55414f2ae4b0da2ec4c5e756/55769824e4b03fee62698458/55769944e4b099e58035be5d/1433835845633/LJwholeapplepie_web.jpg?format=2500w', active: true, inventory: 3 )
hoku.items.create!(name: 'Agua Fresca', description: ":,)", price: 530, image: 'https://foodchannelcom.files.wordpress.com/2018/01/watermelon-juice.jpg?w=1000&h=600&crop=1', active: true, inventory: 3 )
