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
IBcNMjUwMjA2MDk1NzE2WhgPMjEyNTAxMTMwOTU3MTZaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA3P5yMfYNnM5/
E8O5e3itEU/0R+2r/J3OnZpt+kkW3spAyJIkASq2Md80hVRE54FL14JesPpKvLXo
7xZ45GNFFSzQCrCgd6KuWxo7KNOW0863wacQFOJROuSgS2A3z3yJbFqiDGn3mCm1
FaYjAvJtV+lKbiLLUbQB762E++TKRzMeahETtiWfA4ewWHgngso31Q8tmDvVpT96
tYgxjs2YXOPX8fQaluTHVUk9d/EJj4vObC2zdQmpsDJLrXZD/QlDST/0dJMFFlVa
3FXWUUSwiB089BMzZuKC+EmkpgWzQ16kp4bf3N0r4lopJ5WDzMsWZHbdV+htXIsZ
N5UvlMlCGKxiLm5NsNm/e7zqmiqvt4rZKUH8CKdsLkgiAbn+3yqa2YmS0LXMWCg4
qDeQjH0zJoOWD/yYOIJBiLvx16EM5Eo3sedAHLr9eoUGseZLOMh7orOUFczkPPKd
p2TiGxqNtqvAws290EcY3AqeFZxELUgSuYyQtVTb47EI/zVS53rAViaguPbMSpLg
94/5ZKoUYUSn+Pj3r/jjOAyYGVZ1ZG4/iXwvvX2rDNn65bw0AplN1+YBFnNqRsO8
xUUO3ECZ7bfgNCr2XZ5IOv9JkOc9vTOZeJLkY26k2m+DawGASou2SOlz8mT0cCrm
r3rw+tj2yN4r+jf3XxUdX4HHUc//6nkCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
TNhrNZKRePys1TnEQzbe1QRQn5d8vrROu+mZRNUIl3ddrmIke0Q8fMvsUB4h9N6W
8kJm/e1d45Zxw1IBNrxnKxbPy4cuRb4yGqzW4qHXkrAGaMzw2zgdECJoQb30/dAU
Gjzd0+erXcI6FOxdc6rlYsstpcDcs+vcUAAhpNN2s7LXH8I7Y5sfrXxDQvXc/brx
T+auPDCQ75OTFOcve31F9cICpNbvsQFIqQQ7mfDtYyHdOus7MLUOcTdpBjvRnGGz
/0xp8mzo3IGhDrW7+Fb/0SH/48elRwdVAxbrbDzenobaIGHrxmOyghkfGv/L5NHL
0kM9bFsxEUteuXmeKJTi0fyiRvEY1na9lMF5ZDvzyKF6C4FCjXMmn+szKKqFGPfZ
cWy5qDpxdCFsIIKyT5HkRNYO5kZtpVAxq6XaJ0ec0vIA1Fa0YKOg5BKcxw8dtVBx
+CYXtPvALwex/Sfnjnvt3DO0MmamMzMpanS0NRwYHQqK1vwqJ5mGnmVdQwVty2Hs
LjyjqplBnye49HDM6PqL6CXlPZmMp32eH/rpK1iXhyAxVdnhOldwkM29LRqtl0xa
55+DmjEycsmoT432Q2AeHdTV3cab2cRZGfwh72pT3vs8pvm8MZctu+ZuWfRhjPOh
TtdE+VkoydgnTJY+PCjsOdMRzfIR6lYVN2akq2GfKco=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
