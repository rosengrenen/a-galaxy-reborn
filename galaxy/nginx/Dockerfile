FROM nginx:1.19.4

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY nginx-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
