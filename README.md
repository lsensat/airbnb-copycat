# Airbnb Copycat

I created an Airbnb copy to sharpen my skills. It performs all CRUD actions and simulates the core flows of Airbnb.

Key user actions:

- Users can create/login/delete an account.
- Users can create/edit/delete flats/houses with pictures.
- Users can search for places, navigate on a map, and choose places to know more.
- Users can book, see bookings and cancel bookings.
- Users can review places.
- Users can like and unlike places.
- Users can start chatting with hosts.

Airbnb Copycat is a Rails 7 application that lets users list, browse, and book places to stay, inspired by the Airbnb experience. It includes user authentication, rich listings with photos, map-based search, reviews, likes, and in‑app messaging between guests and hosts.

## Tech Stack

- Ruby `3.1.2`
- Rails `7.1.x` (importmap, Turbo, Stimulus)
- PostgreSQL
- Devise for authentication
- Active Storage + Cloudinary for images
- Geocoder + Map markers
- PgSearch for full‑text search
- Bootstrap, Simple Form, Font Awesome, StimulusJS
- Dockerfile for containerized production builds
- Deployment: Heroku
- Extra gems: faker, sassc-rails, autoprefixer-rails

## Features

- Browse a catalog of flats with photos, prices, and amenities.
- Full‑text search on address and listing details.
- Map view with markers for each flat.
- User registration and login (Devise).
- Host dashboard to manage your own places (`owned-places`).
- Create, edit, and delete flats with multiple photos and amenities.
- Booking system with per‑day pricing and booking dates.
- Likes/wishlist for flats.
- Reviews and ratings for stays.
- Basic chatrooms/messages between guests and hosts per flat.

## Getting Started

### Prerequisites

- Ruby `3.1.2` (see `.ruby-version`).
- Bundler (`gem install bundler`)
- PostgreSQL running locally
- Git, and optionally Docker if you want to run via container

### Setup

1. Clone the repo:

   ```bash
   git clone https://github.com/lsensat/airbnb-copycat.git
   cd airbnb-copycat
   ```

2. Install Ruby dependencies:

   ```bash
   bundle install
   ```

3. Set up your database:

   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

4. (Optional) Seed the database with sample users, flats, amenities, likes, reviews, and bookings:

   ```bash
   bin/rails db:seed
   ```

   The seeds use Cloudinary image URLs; you may need valid Cloudinary credentials configured for Active Storage if you want to re‑attach images rather than just use the static URLs.

### Configuration

This app uses several services that expect environment variables or credentials:

- **Database**: configured in `config/database.yml`. You can also use `DATABASE_URL` in production.
- **Cloudinary**: Active Storage uses the `cloudinary` service defined in `config/storage.yml`. Configure Cloudinary either via `CLOUDINARY_URL` or Rails credentials, following the Cloudinary + Rails documentation.
- **Dotenv**: `dotenv-rails` is included; create a `.env` file for your local secrets (API keys, database credentials, etc.). Do not commit it.

Adjust any environment‑specific settings under `config/environments/` as needed.

### Running the App

Start the Rails server:

```bash
bin/rails server
```

Then open `http://localhost:3000` in your browser.

If you ran `db:seed`, you will have:

- A set of random users, flats, amenities, reviews, likes, and bookings.
- A testing user (see `db/seeds.rb` for the email/password) you can use to log in quickly.

### Tests

Run the test suite with:

```bash
bin/rails test
```

You can also run system tests (if/when added) via:

```bash
bin/rails test:system
```

## Docker

The included `Dockerfile` builds a production‑ready image.

Example (simplified) workflow:

```bash
docker build -t airbnb-copycat .
docker run --env-file .env -p 3000:3000 airbnb-copycat
```

The container expects access to a PostgreSQL database (e.g., via `DATABASE_URL`) and any other required environment variables (Cloudinary, etc.). In a real deployment you will typically add a `docker-compose.yml` to orchestrate the app and database together.

## Project Structure

- `app/models` – core domain models (Flat, Booking, Review, Like, Chatroom, Message, Amenity, User, etc.).
- `app/controllers` – controllers for flats, bookings, reviews, likes, chatrooms, messages, and Devise users.
- `app/views` – ERB views and shared partials for cards, navbar, etc.
- `db/migrate` – database schema migrations.
- `db/seeds.rb` – seed data for users, flats, amenities, likes, reviews, and bookings.

## Contributing

Issues and pull requests are welcome. If you plan a bigger change, please open an issue first to discuss what you’d like to add or modify.

## License

No explicit license file is included. If you intend to reuse or distribute this code, please contact the author or add an appropriate license to the repository.
