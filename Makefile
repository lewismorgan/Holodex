BUILD_DIR=build

build: frameworks project app
.DEFAULT_GOAL := build

frameworks: Carthage/Cartfile.resolved
project: HoloDex.xcodeproj/project.yml
app: $(BUILD_DIR)/HoloDex.ipa

.PHONY := beta
beta:
	bundle exec fastlane beta publish:false

.PHONY := candidate
candidate:
	bundle exec fastlane candidate publish:false

.PHONY := release
release:
	bundle exec fastlane release publish:false

$(BUILD_DIR)/HoloDex.ipa: frameworks project
	bundle exec fastlane develop

HoloDex.xcodeproj/project.yml: project.yml
	@xcodegen
	@cp $< $@

Carthage/Cartfile.resolved: Cartfile.resolved Cartfile
	@rome download --platform iOS
	@carthage bootstrap --platform iOS --cache-builds --no-use-binaries
	@rome list --missing --platform iOS | awk '{print $$1}' | xargs rome upload --platform iOS
	@cp $< $@
	@cp Cartfile Carthage/Cartfile

.PHONY := certs
certs:
	bundle exec fastlane certs

.PHONY := clean
clean:
	@rm -rf $(BUILD_DIR)

.PHONY := cartclean
cartclean:
	@rm -rf Carthage
