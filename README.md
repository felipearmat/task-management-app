
# Task Management App

## Table of Contents
1. [Introduction](#introduction)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Database Setup](#database-setup)
5. [Running the Application](#running-the-application)
6. [Background Jobs and Cron Jobs](#background-jobs-and-cron-jobs)
7. [Testing](#testing)
8. [Usage](#usage)
9. [License](#license)

## Introduction
The Task Management App is a simple task management application built using Ruby on Rails. The application allows authenticated users to manage tasks. Each task includes details such as title, description, priority, due date, and completion status. The app follows Clean Architecture principles to ensure modularity and maintainability. Additionally, the app features a background job that sends notifications for overdue tasks via email.

## Requirements
Before setting up the application, ensure you have the following installed on your system:

- **Ruby 3.2.0**
- **Rails 7.x**
- **PostgreSQL** (or any other supported SQL database)
- **Redis** (for background job processing with Sidekiq)
- **Node.js** (for managing JavaScript dependencies)
- **Bundler** (for managing Ruby gems)

## Installation
Follow these steps to install and set up the Task Management App:

1. **Clone the Repository:**
   \`\`\`bash
   git clone https://github.com/felipearmat/task-management-app
   cd task-management-app
   \`\`\`

2. **Install Dependencies:**
   \`\`\`bash
   bundle install
   \`\`\`

## Database Setup
1. **Create and Setup the Database:**
   \`\`\`bash
   rails db:create
   rails db:migrate
   rails db:seed
   \`\`\`

2. **Database Seeding:**
   The \`db:seed\` command will create the initial user and some example tasks in the database.

## Running the Application
1. **Start the Rails Server in Development mode:**
   \`\`\`bash
   bin/dev
   \`\`\`

2. **Access the Application:**
   Open your web browser and navigate to \`http://localhost:3000\`.

## Background Jobs and Cron Jobs
To handle overdue task notifications, you need to set up a cron job to trigger the background job:

1. **Install the \`whenever\` gem:**
   The \`whenever\` gem is used to manage cron jobs.

2. **Update Cron Jobs:**
   Run the following command to update the cron jobs on your server:
   \`\`\`bash
   whenever --update-crontab
   \`\`\`

   This will schedule the \`tasks:notify_overdue\` rake task to run daily at midnight.

## Testing
Run the test suite using RSpec to ensure everything is working as expected:

\`\`\`bash
bundle exec rspec
\`\`\`

This will run all the tests, including model tests, controller tests, and background job tests.

## Usage
Once the application is up and running, you can:

- **View Tasks:** Access the tasks index page to view all your tasks.
- **Create a Task:** Use the "New Task" button to create a new task.
- **Edit a Task:** Click the "Edit" button next to a task to update its details.
- **Mark a Task as Completed:** Use the "Complete" button to mark a task as completed.
- **Delete a Task:** Click the "Destroy" button to delete a task.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
