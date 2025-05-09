catalogue = [
  Product.new(name: "Red Widget", code: "R01", price: 3295),
  Product.new(name: "Green Widget", code: "G01", price: 2495),
  Product.new(name: "Blue Widget", code: "B01", price: 795)
]

basket = Basket.new(catalogue)

basket.add_product("B01")
basket.add_product("G01")
basket.total_price # 30000
