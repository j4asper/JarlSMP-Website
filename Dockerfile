FROM nginx:stable-alpine

COPY src /usr/share/nginx/html

RUN apk update && \
    apk add certbot bash && \
    rm -rf /var/cache/apk/*

COPY src /usr/share/nginx/html

RUN echo "\
server {\n\
    listen 443 ssl;\n\
    server_name jarlsmp.dk www.jarlsmp.dk;\n\
\n\
    ssl_certificate /etc/letsencrypt/live/jarlsmp.dk/fullchain.pem;\n\
    ssl_certificate_key /etc/letsencrypt/live/jarlsmp.dk/privkey.pem;\n\
\n\
    location / {\n\
        try_files $uri $uri/ =404;\n\
    }\n\
}\n\
" > /etc/nginx/nginx.conf

CMD bash -c "certbot certonly --webroot --webroot-path=/usr/share/nginx/html -d jarlsmp.dk -d www.jarlsmp.dk --email jasper@jazper.dk --agree-tos --non-interactive && nginx -g 'daemon off;'"