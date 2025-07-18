# Acme Widget Co. Sales System

This project implements a proof of concept for Acme Widget Co.'s new sales system, focusing on a shopping basket with delivery charge rules and special offers.

## Project Structure

- `Gemfile`: Manages Ruby dependencies (`rspec`, `pry`, `activemodel`, `zeitwerk`).
- `config/autoload.rb`: Configures Zeitwerk for autoloading models from `lib/models`.
- `lib/models`: Contains all application models, including:
  - `Product.rb`: Defines the `Product` for Acme, with `code`, `name`, and `price`.
  - `Basket.rb`: Implements the shopping basket, handling item addition, total calculation, delivery charges, and offers.
  - `DeliveryChargeRules.rb`: Defines the logic for calculating delivery charges based on subtotal.
  - `Offer.rb`: Abstract base class for special offers.
  - `offers/buy_one_get_one_half_price.rb`: Specific offer implementation for "buy one red widget, get the second half price".
- `spec`: Contains RSpec tests for all models.
- `console.rb`: A simple console application to demonstrate the models and the basket functionality using `pry`.

## Setup and Running

1.  **Clone the repository:**
    ```bash
    git clone git@github.com:shaokun/simple_sale_system.git
    cd simple_sale_system
    ```
2.  **Install dependencies:**
    ```bash
    bundle install
    ```
3.  **Run tests:**
    ```bash
    bundle exec rspec
    ```
4.  **Run the console:**
    ```bash
    ruby console.rb
    ```

## Design Choices and Assumptions

### Data Modeling

The project focuses on the core models required for the Acme Widget Co. sales system, including `Product`, `Basket`, `DeliveryChargeRules`, and `Offer`.

### Sales System

-   **Product Catalogue:** For simplicity, the product list is just a hash passed to the `Basket` when you create it. In a real app, this would probably come from a database or another service.
-   **Delivery Charge Rules:** Delivery charges are handled by a static method in `DeliveryChargeRules`. If things get more complicated, this could be swapped out for a more flexible service.
-   **Offers (Strategy Pattern):** Special offers use the Strategy pattern. There's a base `Offer` class, and each specific offer (like "buy one get one half price") is its own class. This makes it easy to add new offers without changing the main basket logic.
-   **Floating Point Precision:** Prices use Ruby's `Float` type. To avoid rounding errors with money, totals are rounded to two decimal places after all calculations.
-   **ActiveModel Validations:** The models use `ActiveModel` for validations to help keep the data clean and show good design practices.

### Autoloading

Zeitwerk is used for efficient and automatic loading of classes, eliminating the need for explicit `require` statements for models in test files and the console.

### Testing

-   **RSpec:** Used for unit testing all components, ensuring correctness and providing a safety net for future changes.
-   **Example Baskets:** The provided example baskets from the problem description are used as test cases to verify the `Basket`'s total calculation, including delivery charges and offers.

### Code Quality

-   **RuboCop:** Used for maintaining consistent code style and detecting potential issues. The project includes:
    -   Custom RuboCop configuration in `.rubocop.yml`
    -   Integration with `rubocop-rspec` for RSpec-specific rules

    To run RuboCop:
    ```bash
    # Run analysis
    bundle exec rubocop

    # Auto-correct issues
    bundle exec rubocop --autocorrect

    # Aggressive auto-correction
    bundle exec rubocop -A
    ```

### Extensibility

The design aims for extensibility:
-   New products can be easily added to the catalogue.
-   New delivery charge rules can be implemented by modifying `DeliveryChargeRules` or by introducing a rule engine.
-   New offers can be added by creating new classes inheriting from `Offer` and passing them to the `Basket`.
