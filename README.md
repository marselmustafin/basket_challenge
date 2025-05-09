# Basket Challenge by Piktochart

Implementation of Piktochart Coding Test: a product basket that accepts products from a catalog and returns the total price, with applied offers and calculated delivery charges.

## Details

*NOTE*: This code is not production-ready, but rather a demonstration of how to model the solution. Some constraints and checks are skipped for simplicity. Money is represented as cents (integers) for convenience.

### Classes
- `Product` – Entity object class that represents a product with a `name`, `code`, and `price`.  
- `Basket` – The main class that accepts an array of `Product`'s as a catalog, an array of offers to be applied, and a `Deliveries::Calculator` object to calculate the delivery price.  
- `Offers::EachNthProductDiscount` – Class that represents a discount applied to every Nth product in the basket and returns the total discount amount. It is configurable via a specific `product_code`, the number of products per which the offer should be applied, and the discount amount in percent. It is assumed that other offer classes will implement the same interface to follow the Strategy Pattern, allowing different or multiple offers to be applied to specific baskets. It is also assumed that the discount should be applied to each *repetitive* Nth product.  
- `Deliveries::Calculator` – Class responsible for calculating the delivery price based on the total basket amount and the applied `Deliveries::Rule` objects.  
- `Deliveries::Rule` – Class that returns a specific delivery price for a given total basket price based on required minimal price. For the purpose of this task, it only depends on the basket's total price.

### Tests

RSpec is used for testing, and all tests are located in the `spec/` directory. `spec/basket_spec.rb` represents use-case described in task requirements.

To run tests:
- Install the Ruby version specified in `.ruby-version` (or update it to any 3.x version you have)
- Run `bundle install`
- Run `rspec`
