1. How many users are there?
	* 50 `User.count`
* What are the 5 most expensive items?
	`Item.order(price: :desc).first(5)`
	* 25    Small Cotton Gloves  Automotive, Shoes & Beauty  Multi-layered modular service-desk  9984
	* 83    Small Wooden Computer  Health  Re-engineered fault-tolerant adapter  9859
	* 100   Awesome Granite Pants  Toys & Books  Upgradable 24/7 access  9790
	* 40    Sleek Wooden Hat  Music & Baby  Quality-focused heuristic info-mediaries  9390
	* 60    Ergonomic Steel Car  Books & Outdoors  Enterprise-wide secondary firmware  9341
* What's the cheapest book? (Does that change for "category is exactly 'book'" versus "category contains 'book'"?)
	* Ergonomic Granite Chair  1496 `Item.where(category: "Books").order(price: :asc).first`
	* Ergonomic Granite Chair  1496 `Item.where("category LIKE '%Books%'").order(price: :asc).first`
* Who lives at "6439 Zetta Hills, Willmouth, WY"? Do they have another address?   `User.find_by(id:  Address.find_by(street: "6439 Zetta Hills").user_id)`
`Address.where(user_id: Address.find_by(street: "6439 Zetta Hills").user_id)`
	* Corrine Little
	* She has 2 addresses
* Correct Virginie Mitchell's address to "New York, NY, 10108".
	* `addresses = Address.where(user_id: User.find_by(first_name: "Virginie", last_name: "Mitchell").id)`
  * `add_to_change = addresses.select {|add| add.state == "NY"}`
  * `add_to_change[0].city, add_to_change[0].zip = "New York", 10108`
  * `add_to_change[0].save`
* How much would it cost to buy one of each tool?
	* 7383 `Item.where(category: "Tools").sum(:price)`
* How many total items did we sell?
	* 2125 `Order.sum(:quantity)`
* How much was spent on books?
	* 1081352 `Order.joins('JOIN items ON item_id = items.id').where("category LIKE '%book%'").map {|book| book.price *​ book.quantity}.inject(:+)`
* Simulate buying an item by inserting a User for yourself and an Order for that User.
	* Insert user `User.create(first_name: "Abby", last_name: "Hunter", email: "email@email.com")`
	* Insert orders `Order.new(user_id: 51, item_id: 5, quantity: 1)`

* What item was ordered most often? Grossed the most money?
	* Incredible Granite Car 72 `Item.find_by(id: Order.group(:item_id).sum(:quantity).sort_by{|k,v| v}.reverse.first[0])`
* What user spent the most?
	* Hassan  Runte 639386 `User.find_by(id: Order.joins('JOIN items ON items.id = item_id').joins('JOIN users ON users.id = user_id').group(:user_id).select("*").sum('items.price * orders.quantity').sort_by{|k,v| v}.reverse.first)`
* What were the top 3 highest grossing categories?
	* Music, Sports & Clothing  525240
Beauty, Toys & Sports  449496
Sports  448410 `Item.joins('JOIN orders ON items.id = orders.item_id').group(:category).select("*").sum('items.price * orders.quantity').sort_by{|k,v| v}.reverse.first(3)`
