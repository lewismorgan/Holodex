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
### develop
```
fastlane develop
```
Create a development build, optionally installing to device
### beta
```
fastlane beta
```
Create a beta build
### candidate
```
fastlane candidate
```
Create a release candidate
### release
```
fastlane release
```
Create a build for release to app store
### install
```
fastlane install
```
Install to a device
### tests
```
fastlane tests
```
Run all the tests
### lint
```
fastlane lint
```
Run SwiftLint
### changelog
```
fastlane changelog
```
Changelog from commits since last tag
### bump
```
fastlane bump
```
Bump the version in the plist
### certs
```
fastlane certs
```
Sync keys, certificates, and provisioning and creates new ones if required

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
