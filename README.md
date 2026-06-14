# Discover Mars App

An iOS app that lets you Discover Mars. View images taken by Martian rovers, learn interesting facts about Mars, and much more.

## Getting Started

1. Clone the repo `git clone git@github.com:Monte9/DiscoverMars.git`

2. Configure your API keys (see [Configuration](#configuration) below)

3. Open Xcode and run the app

4. Install Ruby gems `bundle install`

## Configuration

The app needs two keys, which are kept out of source control. Provide your own:

```sh
cp DiscoverMars/Secrets.example.xcconfig DiscoverMars/Secrets.xcconfig
```

Then open `DiscoverMars/Secrets.xcconfig` and fill in:

| Key              | Where to get it                                                            |
| ---------------- | ------------------------------------------------------------------------- |
| `NASA_API_KEY`   | Free key from [api.nasa.gov](https://api.nasa.gov)                        |
| `MIXPANEL_TOKEN` | Mixpanel dashboard → Settings → Project Settings → Project Token          |

`Secrets.xcconfig` is git-ignored, so your keys never get committed. The values are
injected into `Info.plist` at build time and read at runtime via `AppSecrets`.

For release tooling (fastlane), copy `fastlane/.env.example` to `fastlane/.env` and fill
in your Apple ID, match repo URL, and match passphrase.

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
