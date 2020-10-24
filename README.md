# Event Hub

My first homework project learning Ruby on Rails. Event Hub is a beginner social media app for sharing events with your future and present fans. Events --- like rock band gigs, theatrical performances, TED talks, tech shows etc. --- can be organized freely, they can be published, so that users could find them and subscribe to the posts on them.

# Details

### Ruby version

Versions used during development:
* ruby 2.7.1p83
* rails 6.0.3.2

### Set up

#### You'll need

* Ruby
* Rails
* MySQL/MariaDB [Optional, use docker-compose instead]

#### First steps

```bash
bundle install
yarn install
docker-compose up
rails db:setup
```
*In case of using docker, keep the docker image running*

#### Run

```bash
rails s
```

#### Testing
...

#### Things that might need to be fixed
* N+1 queries project-wide
