# Discover Mars App

An iOS app that lets you Discover Mars. View images taken by Martian rovers, learn interesting facts about Mars, and much more.

## Getting Started

1. Clone the repo `git clone git@github.com:Monte9/DiscoverMars.git`

2. Open Xcode and run the app

3. Install Ruby gems `bundle install`

## Release Management

### TestFlight Beta

To generate a new beta built for testing on `Testflight` use `Fastlane`

  ```
  bundle exec fastlane ios beta
  ```

### App Store

We use `Fastlane Match` to generate, store and install App Store distribution certs and provisioning profiles.

  ```
  bundle exec fastlane match
  ```

## Maintainers

- Monte Thakkar - [@monte9](https://github.com/Monte9)
