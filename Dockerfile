# Use official Ruby image as base
FROM ruby:3.0.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory inside container
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app code
COPY . .

# Precompile assets (optional for production)
# RUN bundle exec rake assets:precompile

# Run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
