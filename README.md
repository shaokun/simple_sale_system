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
    git clone <repository_url>
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