# RecurrEx - Subscription Manager

RecurrEx is a web application that helps you manage your subscriptions, track your spending, and receive reminders for important dates. Keep your subscriptions in check, stay organized, and never miss a renewal date again.

![Screenshot](link-to-screenshot.png)

## Features

- **Subscription Management**: Easily add, edit, or delete your subscriptions.
- **Cost Tracking**: Keep track of how much you're spending on your subscriptions.
- **Renewal Reminders**: Get notified of upcoming subscription renewals.
- **Monthly Spending Chart**: Visualize your monthly spending with an interactive chart.
- **Category Organization**: Categorize your subscriptions for better organization.
- **User-Friendly Interface**: An intuitive and user-friendly design for easy navigation.

## Technologies Used

- **Ruby on Rails**: The web application framework used for building the backend.
- **HTML, CSS, JavaScript**: Frontend technologies for the user interface.
- **Bootstrap**: A CSS framework for responsive and attractive design.
- **Chart.js**: A JavaScript library for creating interactive charts.
- **PostgreSQL**: The relational database management system used to store and manage data.
- **Mailgun API**: An email service API used for sending and managing email notifications.

## Getting Started

To run RecurrEx on your local machine, follow these steps:

1. Clone this repository to your local machine:

   ```
   git clone https://github.com/your-username/reccurex.git
   cd recurrex
   ```

2. Environment Variables: Copy the .env.example file to .env and add your Mailgun API credentials.
    ```
    MAILGUN_API_KEY=your-api-key
    MAILGUN_DOMAIN=your-mailgun-domain
    ```

3. Install the required dependencies using Bundler:
    ```
    bundle install
    ```
4. Set up the database:
    ```
    rails db:create
    rails db:migrate
    rails db:seed
    ```
5. Start the rails server:
    ```
    rails server
    ```
6. Access RecurrEx in your web browser at http://localhost:3000.

## Usage
1. Sign up for a RecurrEx account or log in if you already have one.
2. Add your subscriptions, providing details such as the name, cost, category, start date, and renewal frequency.
3. Receive renewal reminders to help you stay on top of your subscriptions.
4. Explore your monthly spending chart to visualize your financial activity.

## License
This project is licensed under the MIT License.