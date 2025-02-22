#!/bin/bash



apt-get update; apt-get install curl socat git nload -y

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sh || echo_error "Docker installation failed."
else
  echo_info "Docker is already installed."
fi

rm -r Marzban-node

git clone https://github.com/Gozargah/Marzban-node

rm -r /var/lib/marzban-node

mkdir /var/lib/marzban-node

rm ~/Marzban-node/docker-compose.yml

cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host
    environment:
      SSL_CERT_FILE: "/var/lib/marzban-node/ssl_cert.pem"
      SSL_KEY_FILE: "/var/lib/marzban-node/ssl_key.pem"
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: "rest"
    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL

cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwMjIyMTgzOTM5WhgPMjEyNTAxMjkxODM5MzlaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo5UsQsFSeKql
2zt6J8JmZtxCQ5Mo70wiKjXh4L9bGFL5GkL52TpJWgRgfQWk1tMOmR77muIAddYJ
EBCiMhi9HKwnCRiYyoOjXt7gXB6zia77RT2bNkGBq0T48N8F8CxkH/GppUCXiNJW
i//FHN4uEoA6ScKO0jrqn7NuH+awE35N2K+BJSI0RkCFlEHjzplbcyu2jvSXL3vM
HUGenS1KfyceO4FxnhNihX/JNLQ5KtwdntyWNLFcO6e4h4oZzm1dq8KyGfwTD5l0
e0lru5YeyiGc1pjjOpnL1Y88Hw8VAx3r+FJUNUgNJ6msLexdr7bSHtdpHH06ODmw
IM5h8iuEpiDnkTQWG6lGlk9HjR7TV1QU/SgOyIng7PmhSKwCI8kvz3c6r7ifkb6V
pQ3fVw1eMtgdw90ElKNq9LscAUHVzo/OWJouyoIfo/SJkX6i7qwD20v94UIP6S8s
0S4OiXAkzntyeX1j3fr99H6mb+cVnLdSn1/DYwwCQ3DDLAvPNwrL6tE1WF/N5Ab+
acbdBO1ZzXb7USaAkcmeaRVQsXEnMHU9xq24rSFKzvb6JG4Spa0EGvUQ4gn241R1
zrFGMHJMHz2zZO69u+3tiGqnGbfjYEi78WYy7jIAAAqtutfCmqd8XioIKnURMmfM
EelYJHDebZd4xuM+PxowccW5766tPp8CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
kYYi3uIAvVQqny1ZgBUZALkqIbRJNGngqcRQe3J8oI6tjhdQ2rVWGYHqlbS4aOD2
yTgXFsPBlXPcC+5so5Rg2prM3qmQ5MCDmU/h3an7zBdmLeEgeuCOzCFKb4XdoFkK
SByXg5lqWQdASKwoSmrwrrOb+Soi7N6krdkUtw2/WgTIhv1bvDfLM59p2NcgbZvE
WxDIJQRV2wpb/buUdIrbhcm87m8+zbykT7OWH8AR9GipcT6UBsPq5fwagW14Pgcl
Tu55NRZzi3+G1de9FnSvz2xFC3QB5Vhl9/QKASbfgTChFNTSYjmHGzc/rJPo9hxI
lFCaasQWx958gLoyoQLwFeHtmAHpQMLnoIcnOV//Zxv4XHvwyTUHwo7y58MVaUDP
cD3y/Te7/N9FTLzMfO7Zfsfeos/WaOcWo0ronYr4TnKQ5sTmRTFiydUobo+dwkH8
6My334qK/QbEL4yOmQKUuivtFk0stnBfN6YIkxiLwx2sKESNeY1hKx/x0ZY2ZuoU
XC/41g4+Tqg1PVAyecTM2JZLrtR8CPWY/s16BvDDtQ3FQDNqus4sTO61u8F0h5FB
TE2gFt+5M+cUc3tK9dkAmGaiwj3H/lRYtFXsuejMjlcuVxvdh+ymKVcxcoT5b2KJ
kQhG7pwHPNfmH6J0CJ+54B4ZafwTw5SP3gqrKTA97Gc=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
