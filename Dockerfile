FROM alpine:3.15 as builder

ARG Q_VER=0.8.0

RUN apk update \
        && apk add go \
        && cd /root \
        && wget https://github.com/natesales/q/archive/refs/tags/v$Q_VER.zip \
        && unzip v$Q_VER.zip \
        && cd q-$Q_VER \
        && go build \
        && mv ./q /root

FROM alpine:3.15

COPY --from=builder /root/q /app/

ENTRYPOINT ["/app/q"]
