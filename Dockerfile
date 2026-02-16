# Use the official Ruby image
FROM ruby:3.2-slim

# Install dependencies for Jekyll and git (required by some gems)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /srv/jekyll

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Copy the Gemfile and install gems
COPY Gemfile* ./
RUN bundle install

# Expose the default Jekyll port
EXPOSE 4000

# Default command to serve the site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]
