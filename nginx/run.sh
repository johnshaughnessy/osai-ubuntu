docker run -d --name nginx-proxy \
    -v conf.d:/etc/nginx/conf.d \
    -p 80:80 \
    nginx:latest
