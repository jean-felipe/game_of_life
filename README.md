# Game of Life

This is a Ruby on Rails implementation of Conway's Game of Life. The application provides both a web interface and an API for interacting with the game.

## Ruby Version
This project uses Ruby on Rails 7.2.0. Make sure you have the correct Ruby version installed.

## System Dependencies
- SQLite3
- Redis
- Node.js (for JavaScript runtime)

## Configuration
1. Clone the repository
2. Run `bundle install` to install Ruby dependencies
3. Run `yarn install` or `npm install` to install JavaScript dependencies

## Database Setup
1. Run `rails db:create` to create the database
2. Run `rails db:migrate` to set up the database schema

## Running the Application
1. Start the Rails server: `rails server`
2. Visit `http://localhost:3000` in your web browser
3. You can see the game on the home page.

## Running the Test Suite
This project uses RSpec for testing. To run the test suite:
bundle exec rspec


## Available Routes

### Web Interface
- `GET /` - Root path, displays the grid index
- `GET /grids` - Index of grids
- `PATCH /grids/:id` - Update a specific grid

### API Endpoints
All API endpoints are namespaced under `/api`

- `POST /api/grids` - Create a new grid
- `GET /api/grids/:id/next_state` - Get the next state of a specific grid
- `GET /api/grids/:id/n_states_away/:number` - Get the state of a grid after n iterations
- `GET /api/grids/:id/final_state` - Get the final state of a grid (if it stabilizes)

### Health Check
- `GET /up` - Returns 200 if the app is running, 500 otherwise

### Progressive Web App (PWA)
- `GET /service-worker` - Service worker for PWA functionality
- `GET /manifest` - JSON manifest for PWA

## Project Structure
- `/app/controllers/api` - Contains API controllers
- `/app/controllers/grids_controller.rb` - Main controller for grid operations
- `/app/javascript/controllers` - JavaScript controllers (Stimulus)
- `/app/views/layouts` - Application layout files
- `/app/views/pwa` - PWA-related views
- `/config` - Application configuration files
- `/db` - Database migrations and schema

## Services
The application uses several service objects for business logic:
- `GridCreationService`
- `GridUpdateService`
- `GridFinalStateService`

## Development
This project uses several development tools:
- Brakeman for security analysis
- RuboCop for code style checking
- RSpec for testing
- FactoryBot for test data generation
- Pry for debugging

## Deployment
Deployment instructions are not specified in the current codebase.

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## License
This project is licensed under the [MIT License](LICENSE.md).
