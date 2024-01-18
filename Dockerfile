# syntax=docker/dockerfile:1

FROM golang:1.21
WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download 
# && go mod verify

COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

# RUN go build -v -o /usr/local/bin/app ./...

CMD ["/docker-gs-ping"]