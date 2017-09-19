FONTFORGE=fontforge
MKDIR=mkdir

INPUT_NAME=$(shell cat NAME)
OUTPUT_NAME=$(INPUT_NAME)

SOURCE_DIR=./src
BUILD_DIR=./build

SOURCE_PATH=${realpath ${SOURCE_DIR}}
BUILD_PATH=${realpath ${BUILD_DIR}}
INSTALL_PATH?=${realpath ${HOME}/.local/share/fonts/}

# TODO: migrate legacy ff script to py
$(BUILD_PATH)/%.ttf: $(SOURCE_PATH)/%.sfd
	mkdir -p build
	echo ":::: $(SOURCE_PATH) >>> $@"
	${FONTFORGE} -lang=ff -c 'Open("$<"); Generate("$@")'

prep:
	mkdir -p build

install: | prep $(BUILD_PATH)/$(INPUT_NAME).ttf
	mv $(BUILD_PATH)/$(INPUT_NAME).ttf $(INSTALL_PATH)/$(OUTPUT_NAME).ttf

uninstall:
	rm $(INSTALL_PATH)/$(OUTPUT_NAME).ttf

clean:
	rm -rf build/*

preview:
	cd test && xelatex demo.tex

test:
	cat NAME
	echo name $(INPUT_NAME)
	echo output $(OUTPUT_NAME)
	echo build $(BUILD_PATH)
	echo install $(INSTALL_PATH)
