FROM alpine:3.7

# Install Squid and dumb init
RUN set -x \
  && apk add --no-cache squid curl apache2-utils \
  && curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
  && chmod +x /usr/local/bin/dumb-init \
  && apk del curl

# Enable basic authentication.
RUN sed -i '/# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS/a auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords\n\
auth_param basic realm proxy\n\
acl authenticated proxy_auth REQUIRED\n\
http_access allow authenticated' /etc/squid/squid.conf

# Disable unauthenticated private network access.
RUN sed -i '/http_access allow localnet/s/^/#/' /etc/squid/squid.conf

# Create passwords file for proxy auth.
RUN touch /etc/squid/passwords

# Expose port 3128 - the Squid default.
EXPOSE 3128

# Copy setup script.
COPY setup.sh ./setup.sh
RUN chmod +x ./setup.sh

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["sh", "-c", "./setup.sh && exec squid -N"]
