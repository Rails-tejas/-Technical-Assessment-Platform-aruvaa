Technical Assessment Platform
A dynamic candidate evaluation system built with Ruby on Rails

📌 Overview
The Technical Assessment Platform is a web application that allows candidates to:

Select preferred programming languages

Take a timed multiple‑choice technical quiz

Navigate through questions (Next/Previous)

Automatically move to the next question when time expires

View final results

Upload a resume only if they pass the test

This application is built using:

Ruby 3.4.4

Rails 8.0.4

PostgreSQL

Turbo / Hotwire

Active Storage for resume uploads

🚀 Features
📝 Language Selection
Multi-select programming languages

Validates user selection before starting the test

🧠 MCQ Assessment
Questions filtered by selected languages

Random question ordering

Navigation:

Next

Previous

Submit Test

Answers saved per question

No double scoring when going back

Prevents skipping uninitialized assessments

⏱️ Timer System
Each question has its own countdown

Automatically submits and moves to next question when timer ends

Disables Previous button when time expires

Automatically submits last question and redirects to results

🏆 Result Page
Displays:

Score

Total questions

Pass/Fail status

If passed:

Resume upload option

If failed:

Retry message

📂 Resume Upload
Accepts: PDF, DOC, DOCX

Managed via Active Storage

Validates file type

🛠️ Tech Stack


| Component   | Technology                                  |
| ----------- | ------------------------------------------- |
| Language    | Ruby 3.4.4                                  |
| Framework   | Rails 8.0.4                                 |
| Database    | PostgreSQL                                  |
| File Upload | Active Storage                              |
| Frontend    | ERB + Turbo                                 |
| Styles      | Custom CSS (or Tailwind/Bootstrap if added) |


📦 Installation & Setup

1. Clone the Repository
  git clone https://github.com/yourusername/tech_assessment.git
  cd tech_assessment

3. Install Dependencies
  bundle install

5. Setup Database
  rails db:create
  rails db:migrate
  rails db:seed   # optional: load sample data

7. Setup Active Storage
  rails active_storage:install
  rails db:migrate

9. Start Server
  bin/rails server

Visit: http://localhost:3000

