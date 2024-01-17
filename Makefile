null:
	@:

docker-build: check-version
	@echo Building Rusty Hogs version: $(VERSION)
	docker build --tag rust-builder -f Dockerfile.build .
	docker build --tag quirinziessler/ankamali_hog:$(VERSION) --build-arg HOG=ankamali -f Dockerfile.hog .
	docker build --tag quirinziessler/berkshire_hog:$(VERSION) --build-arg HOG=berkshire -f Dockerfile.hog .
	docker build --tag quirinziessler/choctaw_hog:$(VERSION) --build-arg HOG=choctaw -f Dockerfile.hog .
	docker build --tag quirinziessler/duroc_hog:$(VERSION) --build-arg HOG=duroc -f Dockerfile.hog .
	docker build --tag quirinziessler/essex_hog:$(VERSION) --build-arg HOG=essex -f Dockerfile.hog .
	docker build --tag quirinziessler/gottingen_hog:$(VERSION) --build-arg HOG=gottingen -f Dockerfile.hog .
	docker build --tag quirinziessler/hante_hog:$(VERSION) --build-arg HOG=hante -f Dockerfile.hog .

docker-save: check-version
	docker image save -o images.tar \
	quirinziessler/ankamali_hog:$(VERSION) \
	quirinziessler/berkshire_hog:$(VERSION) \
	quirinziessler/choctaw_hog:$(VERSION) \
	quirinziessler/duroc_hog:$(VERSION) \
	quirinziessler/essex_hog:$(VERSION) \
	quirinziessler/gottingen_hog:$(VERSION) \
	quirinziessler/hante_hog:$(VERSION)

docker-load:
	docker load -i images.tar

docker-publish: check-version
	docker push quirinziessler/ankamali_hog:$(VERSION)
	docker push quirinziessler/berkshire_hog:$(VERSION)
	docker push quirinziessler/choctaw_hog:$(VERSION)
	docker push quirinziessler/duroc_hog:$(VERSION)
	docker push quirinziessler/essex_hog:$(VERSION)
	docker push quirinziessler/gottingen_hog:$(VERSION)
	docker push quirinziessler/hante_hog:$(VERSION)

check-version:
	@if test ! $(VERSION); then echo "VERSION is undefined"; exit 1; fi
