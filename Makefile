BUILD_DIR=build

RESOURCES_DIR := ./HoloDex/Resources
FONTS_DIR := ./HoloDex/Resources/Fonts
GENERATED_RESOURCES := ./HoloDex/Resources/Assets.generated.swift ./HoloDex/Resources/Scenes.generated.swift ./HoloDex/Resources/Fonts.generated.swift
GLYPH_NAME := holodex-glyphs
FONTELLO_HOST := http://fontello.com

#### Build Goals ####

build: resources ipa
.DEFAULT_GOAL := build

fonts: ${FONTS_DIR}/${GLYPH_NAME}.ttf
generated: swiftgen
ipa: $(BUILD_DIR)/HoloDex.ipa
resources: fonts generated

### BUILD ###
.PHONY := install
install: ipa
	bundle exec fastlane install

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
$(BUILD_DIR)/HoloDex.ipa: resources
	bundle exec fastlane develop

### Build Dependencies ###

# Download glyphs used in the app through a Fontello config
${FONTS_DIR}/${GLYPH_NAME}.ttf: HoloDex/Resources/Fonts/glyphs.json
	@curl --silent --show-error --fail --output .fontello --form "config=@$<" http://fontello.com
	@curl --show-error --fail --output .fontello.zip ${FONTELLO_HOST}/`cat .fontello`/get
	@unzip -q .fontello.zip -d .fontello.src
	@cp .fontello.src/fontello-*/font/${GLYPH_NAME}.ttf $@
	@rm -rf .fontello .fontello.src .fontello.zip

### Misc Helpers ###

.PHONY := certs
certs:
	bundle exec fastlane certs

.PHONY := swiftgen
swiftgen:
	@swiftgen

.PHONY := stubs
stubs:
	bundle install --binstubs

.PHONY := clean
clean:
	rm -rf $(BUILD_DIR)
	rm -f ${FONTS_DIR}/${GLYPH_NAME}.ttf
	rm -f ${GENERATED_RESOURCES}
