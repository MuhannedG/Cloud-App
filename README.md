# Cloud Application – Ruby on Rails

This is a Ruby on Rails cloud-based application. Below are the essential steps to get it up and running.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/MuhannedG/Cloud-App.git
cd Cloud-App

bundle install
yarn install

rails db:create
rails db:migrate
rails db:seed # optional, if you have seed data


## 2. Run the Application Locally

rails server
