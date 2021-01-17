.PHONY: up

build:
	docker-compose build

up:
	docker-compose up -d app

down:
	docker-compsoe down

watch:
	docker-compose run app reflex -r '\.go' -s -- sh -c "go run /build/main.go"

log:
	docker-compose logs -f

clean:
	docker-compose rm --all
	@rm -rf go.mod go.sum

fmt:
	docker-compose run app go fmt .
