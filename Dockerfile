# Stage 1: Construindo o binário
FROM golang:1.21 AS builder

WORKDIR /usr/src/app

COPY go.mod ./
COPY full-cycle-rocks.go ./

RUN go mod download && \
    go mod verify && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Stage 2: Copiando o binário para imagem final
FROM scratch

COPY --from=builder /usr/src/app/app /app

CMD ["/app"]
