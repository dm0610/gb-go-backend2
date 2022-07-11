FROM golang:latest
RUN  adduser \
   --system \
   --shell /bin/bash \
   --disabled-password \
   --home /app goserver && \
	chown -R goserver /app
WORKDIR /app

COPY *.go ./
RUN go mod init goserver
RUN go mod tidy
RUN go build -o goserver .
USER goserver
ENV PORT="8080"
ENV APP_DB_HOST='postgres'
ENV APP_DB_PORT='5432'
ENV APP_DB_USERNAME='techuser'
ENV APP_DB_PASSWORD='techuser'
ENV APP_DB_NAME='products'
ENV SSLSTATUS='disable'

EXPOSE 8080
CMD ["./goserver"]