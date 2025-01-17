FROM golang AS build
WORKDIR /src
COPY *.go go.mod config.json ./
RUN go mod tidy && go build -v -o /out/zruty-bot .
FROM ubuntu AS prod
WORKDIR /bot
RUN echo "Europe/Moscow" > /etc/timezone && \
    apt update && \
    apt install -y ca-certificates
COPY --from=build /out/zruty-bot .
CMD ["/bot/zruty-bot"]
