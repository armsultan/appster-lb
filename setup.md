# Create the self signed key and certificate valid for 10years (36500 days)
# for test purposes only
openssl req -nodes -x509 \
        -newkey rsa:4096 \
        -keyout etc/ssl/appster.com.key \
        -out etc/ssl/appster.com.crt \
        -days 3650 \
        -subj "/C=US/ST=Colorado/L=Denver/O=Appster Inc/CN=*.appster.com"