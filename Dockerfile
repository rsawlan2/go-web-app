FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o bgo .

# Final stage - Distroless image
FROM gcr.io/distroless/base

COPY --from=builder /app/bgo .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "./bgo" ]