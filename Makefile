PYINSTALLER := python -m PyInstaller
ARCHS := linux-x86_64 linux-arm64
SOCIALS := telegram twitter github

all: clean build

build: $(addprefix build-,$(SOCIALS))

build-%:
	@echo "Building $*..."
	@for arch in $(ARCHS); do \
		echo "Building $* for $$arch..."; \
		$(PYINSTALLER) --onefile --name $$arch \
			--distpath ./$*/ \
			--specpath ./$*/ \
			-y ./$*/$*.py || exit 1; \
	done

clean:
	@echo "Cleaning up..."
	@for social in $(SOCIALS); do \
		for arch in $(ARCHS); do \
			rm -rf ./$*/$$arch; \
		done; \
	done
	rm -rf __pycache__