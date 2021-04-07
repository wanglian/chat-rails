# README

This is a sample chat app backend.

The following features are implemented:

* Get list of all channels
* Join a channel
* Send message to a channel
* Get list of messages in a specific channel

## Requirements

* Ruby > 2.5
* Rails 6.1.3

## Getting Started

```
> bundle
> rails db:migrate
> rails server
```

API Docs: `http://localhost:3000/apipie`

User API endpoints:
```
> rails routes | grep auth
POST   /api/v1/auth/sign_in(.:format)  # sign in
DELETE /api/v1/auth/sign_out(.:format) # sign out
POST   /api/v1/auth(.:format)          # sign up
```

## Run Tests

```
bundle exec rspec
```
