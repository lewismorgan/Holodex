BUILD_DIR=./build

FONTS_DIR ?= ./HoloDex/Resources/Fonts/
GLYPH_NAME ?= holodex-glyphs

FONTELLO_HOST ?= http://fontello.com

#### Build Goals ####

build: frameworks fonts project ipa
.DEFAULT_GOAL := build

frameworks: Carthage/Cartfile.resolved
fonts: ${FONTS_DIR}/${GLYPH_NAME}.ttf
project: HoloDex.xcodeproj/project.yml
ipa: $(BUILD_DIR)/HoloDex.ipa

### BUILD ###

.PHONY := beta
beta:
	bundle exec fastlane beta publish:false

.PHONY := candidate
candidate:
	bundle exec fastlane candidate publish:false

.PHONY := release
release:
	bundle exec fastlane release publish:false

### Build Output ###

# Local development build of HoloDex through fastlane
$(BUILD_DIR)/HoloDex.ipa: frameworks fonts project
	bundle exec fastlane develop

### Build Dependencies ###

# Creates the xcodeproj file using xcodegen
HoloDex.xcodeproj/project.yml: project.yml
	@xcodegen
	@cp $< $@

# Download glyphs used in the app through a Fontello config
${FONTS_DIR}/${GLYPH_NAME}.ttf: ${FONTS_DIR}/glyphs.json
	@curl --silent --show-error --fail --output .fontello --form "config=@${FONTS_DIR}/glyphs.json" http://fontello.com
	@curl --show-error --fail --output .fontello.zip ${FONTELLO_HOST}/`cat .fontello`/get
	@unzip -q .fontello.zip -d .fontello.src
	@cp .fontello.src/fontello-*/font/${GLYPH_NAME}.ttf ${FONTS_DIR}/${GLYPH_NAME}.ttf
	@rm -rf .fontello .fontello.src .fontello.zip
	@echo "Downloaded glyphs"

# Ensures the project is up to date with frameworks via Carthage
# Bootstrap is run again if any changes are detected
Carthage/Cartfile.resolved: Cartfile.resolved Cartfile
	@rome download --platform iOS
	@carthage bootstrap --platform iOS --cache-builds
	@rome list --missing --platform iOS | awk '{print $$1}' | xargs rome upload --platform iOS
	@cp $< $@

### Misc Helpers ###

.PHONY := certs
certs:
	bundle exec fastlane certs

.PHONY := clean
clean:
	@rm -rf $(BUILD_DIR)
	@rm -f ${FONTS_DIR}/${GLYPH_NAME}.ttf

.PHONY := bootstrap
bootstrap:
	@rome download --platform iOS
	@carthage bootstrap --platform iOS --cache-builds
	@rome list --missing --platform iOS | awk '{print $$1}' | xargs rome upload --platform iOS
	@cp Cartfile.resolved Carthage/Cartfile.resolved
