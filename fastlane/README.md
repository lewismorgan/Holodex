fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios develop
```
fastlane ios develop
```
Create a development build
### ios beta
```
fastlane ios beta
```
Create a beta build
### ios candidate
```
fastlane ios candidate
```
Create a release candidate
### ios release
```
fastlane ios release
```
Create a build for release
### ios tests
```
fastlane ios tests
```
Run tests
### ios lint
```
fastlane ios lint
```
Run linting tasks
### ios certs
```
fastlane ios certs
```
Sync keys, certificates, and provisioning

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
