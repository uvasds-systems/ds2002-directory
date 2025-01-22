FROM alpine:latest

RUN apk add --no-cache git

COPY directory.sh /directory.sh

RUN chmod +x /directory.sh

CMD ["./directory.sh"]
