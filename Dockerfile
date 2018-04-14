FROM golang:1.10 as builder

WORKDIR /go/src/github.com/digitalocean/bind_exporter
COPY . .

RUN env GOOS=linux CGO_ENABLED=0 make

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /bin/
COPY --from=builder /go/src/github.com/digitalocean/bind_exporter/bind_exporter .

EXPOSE 9119

ENTRYPOINT [ "/bin/bind_exporter" ]