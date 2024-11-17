FROM nginx:stable-alpine

COPY src /usr/share/nginx/html

RUN apk update && \
    apk add certbot bash && \
    rm -rf /var/cache/apk/*

COPY src /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

CMD bash -c "certbot certonly --webroot --webroot-path=/usr/share/nginx/html -d jarlsmp.dk -d www.jarlsmp.dk --email jasper@jazper.dk --agree-tos --non-interactive && nginx -g 'daemon off;'"