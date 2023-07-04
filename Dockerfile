FROM golang:1.19 AS builder
WORKDIR /build/
COPY ./ ./
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o mutating-webhook


FROM ubuntu:focal
WORKDIR /opt
COPY --from=builder /build/mutating-webhook .
CMD ["./mutating-webhook", "--tls-cert", "/etc/opt/tls.crt", "--tls-key", "/etc/opt/tls.key"]
