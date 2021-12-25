## Prerequisites
The setups steps expect following tools installed on the system.

* Github
* Ruby 3.0.0
* Rails 6.1.4
* Postgres

1. Check out the repository
```bash
git clone git@github.com:masroorhussainv/rails-jwt-boilerplate.git
```

2. Create and setup the database
Run the following commands to create database and run migrations.
```bash
bundle exec rake db:create
bundle exec rake db:migrate
```
3. Set up environment variables
Create `.env` file in the root of the project and provide the required environment variables in the `.env` file.
```bash
touch .env
```
Check the `.env.example` file to see the required environment variables data.

4. Start the Rails server
You can start the rails server using the command given below.
```bash
bundle exec rails s
```
And now you can visit the site with the URL http://localhost:3000

5. Check routes
You can check the application routes using the command given below
```bash
bundle exec rails routes
```

### To Do list
- [x] Add JWT Sign-up
- [x] Add JWT Sign-in
- [] Add serializer to return uniform response from API endpoints
- [] Add Update user, Delete user actions in Registrations controller
- [] Add Logout user action in Sessions controller
- [] Add Omniauth support.