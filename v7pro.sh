#!/bin/bash

echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

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
IBcNMjUwMjIzMjA0MzM0WhgPMjEyNTAxMzAyMDQzMzRaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwOWOTJdTTJ1H
V9bSyaG+3JF9sIdiEcR6Om9m79VGdq4FbxYznwv8lVgVknUAEDfmxxFT9W6WlFGT
4Y0CveURL4ys3M2J++Z96xlMRDI870Gu+8MJMPdtHzRACqhk5DkOmHPuClVchwAm
J9mYOJBoYTtM+1OltACpfgYp95xyXvF+RBdu92W3JEwjinyBV04OFskjTBcV3abg
ABW7dhSg4INnr8kA/kv6M0KJqaEKO7PV+0XYwB4wXD0PpnyHDsOYqntemp0pTR9P
amVWmQ58AFPzloTEmhf990VVK5vVO8z27hBG0E+HA17daED4FcJWqe+RT5SC4J17
//edf9i80xDbSpXQxVfYk/sUTLH8q50N+a1pzKKEo3bwJL0qMzmjoKSr0z9GsGBn
mp9CAPMRrTLEcGSU3SnwU0a0gD6YbmTgRZ0J+Hnb915v3ttbuuQHVbq+HvfzAtfl
9blEwA2V8TGa/kTn0Gbq/LFmtfRsZTYguI8CjFnHOybBU4o0PoK17vbaP+DcvU2w
C6WrwDFeZD8iXvXhWbTGvOwbDDZeSOHD2CHyZNT2M18+rgkb9LX1Y27ipd0BaQuk
M1rmG1rrz+0fFxGS7r7Md/OJRDlDcfGDsk2n/eP28dxzlyQL9bD1FAw1JmpcVAIP
RqdLcdB1NgQTUt3W8T/zsUjxhmldAtsCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
sDk3bbVwVeP8iT6QDfa6z1HfC2UbuyPwNAqeF4kf9FHSx3KZ6pRBMDsskL9t/APe
M03jketo2qnDKAVKgEuQfhAmI8TfXqLhdCS+NpZU7zhPLTlpw4iUxJyQ3Brd0aIy
sVTpfOay115Rg/keON9y9ZZXocC0PQgzO8LX5aiWMVXenzwuzUoLC2fleknrFb+y
J2PMCIBJCZsqvUz7GWN/4pBMeLmF+ClaHwPFUyXX0eAo3fdlWCSgeSxAqbRvJihm
MoYJK15T6rYCWM9Y4w2wjlrejJLdMahPr9N4RFoNzrF4/P4IyWNm6jYbUUX0Gqc8
bk1VwCU1QtZ9xGpjnnwlzBgeR+fJKCcPs9W3ZJtXxRjIq1ONFgbYZ/pF2BKFxcln
rHNA7+Wa4iadgb6/cOhP/z3UeqToUXL72JxmhoKK1vSx4kwK6PrrwsmV1+CUF1Jb
Y05cUhVlx5QXi5rUEwQPgsNGW3qoLwHudzDWE/88rF8iSk8Ka9AHecmZxduz3Qvm
2a8HCufipmXpy1bWTVrS+5bq39qwHczmElM/luxusfZ7zvsBIiVWInpZWL1uP5sr
aG4idjp8U/rDzXot+MDiXg5Q/FSEPPB4sDEYSHycK42XfpfE1n9mL3hJdqmJV+Iv
ad+msX2g8SjEbA6HnYHVb2hhP18Ja1Z8e9qGtCU2VP4=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d

echo_info "Finalizing UFW setup..."

ufw allow 22
ufw allow 80
ufw allow 2096
ufw allow 62050
ufw allow 62051

ufw --force enable
ufw reload

