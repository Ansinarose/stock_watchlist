# Stock Watchlist App

A Flutter mobile application to track stock prices and maintain a personalized watchlist. The app uses the [Alpha Vantage API](https://www.alphavantage.co/) to fetch stock data, including company names and latest share prices. You can search for stocks, add them to a watchlist, and track the latest price information.

## Features

- **Home Screen**: 
  - Search for stock companies using a search bar.
  - Search results display matching companies and their latest stock prices, fetched from the Alpha Vantage API.
  - Ability to add stocks to a watchlist.
  
- **Watchlist Screen**:
  - View a list of saved stocks along with their current prices.
  - Remove stocks from the watchlist.
  
- **Local Storage**: 
  - Uses `Hive` for local storage to persist the user's watchlist data.

## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/) installed on your local machine.
- An API key from [Alpha Vantage](https://www.alphavantage.co/).
- [Hive](https://pub.dev/packages/hive) package for local storage.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Ansinarose/stock_watchlist
   cd stock_watchlist
