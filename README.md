# HoloDex
iOS App for a Modern Jedi or Sith

Data today cannot be provided by The Force. So instead, it's provided by Star Wars API, this app would not be possible without it. Thank you ❤.

No attempt is made to infringe on the Star Wars brand, as this is used for furthering education and knowledge of iOS development.

## About

HoloDex is an iOS app demonstrating my skills in creating an iOS from scrath that follows the following principles and practices:
* SOLID principles
* Reactive (Rx) approach with RxSwift library
* Model-View-ViewModel-Coordinator
* Playground for testing out all the latest iOS features
* Extensive use of Fastlane for automation

For dependency management, I've chosen to use Carthage so I can control the structure of the project,
update to new features rapidly, and I can learn more about how Xcode projects and workspaces work.

## Features

HoloDex is almost a 1:1 representation of what's available from the Star Wars API. The application is split into 5 core features:
1. Planets
2. Spaceships/Vehicles
3. People
4. Films
5. Species

Each of these features is represented by a tab within the application, so the user can seamlessly define their search into the Star Wars Universe (or better put, the Star Wars API).

## Development

Partly due to my great intrest in anything devops, fastlane is made of extensive use to simplify my life and learn more about iOS deployment along with automating the process.

### Development Process

1. New feature branch is created from `develop`
2. Pull request created to merge changes into `develop`
3. Fastlane runs tests & creates `beta` build to verify PR changes, merged when all passed

### Release Process

1. `release-` branch created from `develop`
2. Version number incremented to release number
3. `candidate` release builds triggered for build checks
4. Pull request created from `release-` into `master`, `release` build triggered to verify PR
5. Final build is created, tagged, and published
6. `master` merged back into `develop`
