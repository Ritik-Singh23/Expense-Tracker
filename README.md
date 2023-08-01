# Expense Tracker

An expense tracker app built with Flutter that allows users to track their income and expenses, displays the total amount left, plots a chart of all expenses, and shows recent transactions using Hive as the local database.

## Features

- Add and track your income and expenses.
- View the total amount left after deducting expenses from income.
- Plot a chart to visualize all your expenses.
- View recent transactions.

## Screenshots

![App Screenshot](https://github.com/Ritik-Singh23/images/blob/main/pic1.jpg)

![App Screenshot](https://github.com/Ritik-Singh23/images/blob/main/pic2.jpg)

![App Screenshot](https://github.com/Ritik-Singh23/images/blob/main/pic3.jpg)

![App Screenshot](https://github.com/Ritik-Singh23/images/blob/main/pic4.jpg)

![App Screenshot](https://github.com/Ritik-Singh23/images/blob/main/pic5.jpg)

## Getting Started

To get started with the app, follow these steps:

1. Make sure you have Flutter installed. If not, follow the installation instructions at [Flutter Official Website](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine using:
```bash
git clone https://github.com/Ritik-Singh23/Expense-Tracker.git

cd expense_tracker_flutter
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Dependencies

The app uses the following dependencies:

- `flutter`: the main Flutter framework
- `hive`: a lightweight and fast NoSQL database for Flutter
- `fl_chart`: for plotting charts

## Getting Started
The app consists of the following main components:

- `main.dart`: Entry point of the app, sets up the root widget.
- `homepage.dart`: Home screen that displays the income, expenses, total amount left, and the chart.
- `add_transaction.dart`: Screen to add new income or expense transactions.
- `db_helper.dart`: Helper class for initializing Hive and performing database operations.

## Usage

1. Open the app, and you'll land on the home screen.
2. Enter your income and expenses using the "Add Transaction" button.
3. The total amount left will be automatically updated.
4. View the chart to visualize your expenses over time.
5. Scroll down to see the list of recent transactions.


