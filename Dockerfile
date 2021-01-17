FROM golang:1.15-alpine AS builder
ENV GO11MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN apk --no-cache add ca-certificates tzdata

WORKDIR /build
COPY go.mod go.sum /build/
RUN go get github.com/cespare/reflex
RUN go mod download
COPY main.go /build/

WORKDIR /dist
RUN mkdir -p /dist
RUN go build -a -ldflags '-s' -o /dist/main /build/main.go
CMD ["/dist/main"]

####################
# scratch를 활용한 프로덕선용 이미지입니다.
# 해당 이미지를 사용하기 위해서 builder 스테이지의 CMD 를 삭제하고
# 빌드된 Go 바이너리를 scratch 복사하여 사용하세요.
####################

# FROM scratch AS app
# WORKDIR /dist
# COPY --from=builder /usr/local/go/lib/time/zoneinfo.zip /usr/local/go/lib/time/zoneinfo.zip
# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# COPY --from=builder /build/main /dist/
# CMD ["/dist/main"]
