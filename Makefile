IMAGE_NAME := zmk-toucan-build
BUILD_DIR  := build
VOLUME     := zmk-workspace

.PHONY: build clean clean-af

build: Dockerfile scripts/build.sh
	podman build -t $(IMAGE_NAME) .
	mkdir -p $(BUILD_DIR)
	podman run --rm \
		-v $(CURDIR):/config:ro \
		-v $(VOLUME):/workspace \
		-v $(CURDIR)/$(BUILD_DIR):/output \
		$(IMAGE_NAME)

clean:
	rm -rf $(BUILD_DIR)
	
clean-af: clean
	podman volume rm $(VOLUME) 2>/dev/null || true
