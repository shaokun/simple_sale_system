# Acme Widget Co. Sales System

This project implements a proof of concept for Acme Widget Co.'s new sales system, focusing on a shopping basket with delivery charge rules and special offers.

## Project Structure

- `Gemfile`: Manages Ruby dependencies (`rspec`, `pry`, `activemodel`, `zeitwerk`).
- `config/autoload.rb`: Configures Zeitwerk for autoloading models from `lib/models`.
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