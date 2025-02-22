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
IBcNMjUwMjIyMTkxMTQ4WhgPMjEyNTAxMjkxOTExNDhaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5CjZr+UyxM1v
15FBt3+EDsrFmzQ1omomTscnbjj3AnP/NNd5L8F4pWfPMX/RxufoNYaMo9/3HFIH
ZNwAztYyqHzOS6S7KdtFKcHqJPAN4nq38Xp8qLS849P83UWVXVzutoBoi4RTNYM4
0TbnZZnGRQTuMaLGZRyv3SyamwGYNsN5DlZKeqJs/r5DA3d7llOqAN9N/sl2hITt
96ooMD2bMtbp4jQn+PLR1fZ/RI8JoegxZ4Ecv3H7UfrvDg1LC+bNFRNrcv3ULy1r
jftU68C+9pYG8m/dIAbvq2N28EOCeg07y4okgJmLo1maLCf7LEv1TRQ1CepquMMq
lomGchfJcPTylF1S7FqIiprIQPhtNq8kq0wrmgSoCbIeK+aSMIkHaTo+hwQ1fJFw
gbUF1TFUS4NdUo98IBnLBY4vzPzsHSDFRfLV31E8SsWMrsrrsY/PQ6Fphf8q35OC
ma9p0g7FZR18IYDtEipREn1DCem4mAQwnCspaNHCSOqZ9Dhf+L6ZC3HYUQKkYmJR
4bihw+vjw9Ekv6oXZyBeHFTaOu5NzYt13FG7FMZIHcUWkGpgJGQMLMbgo85uDOqI
j3d24vE7pilOZqVQZVKMj5QbLZWezR6f59sjiGlEANkiEUgLJZtuxmIue8J2pzGq
IzrBghqZOSw9UOkyuX2jQnruAHKrnMsCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
x9oNnfNIwLNacaYzwqBSvhIkm6/8i7mZOHlJSxDojHsi9Bn9ktpLRamesUxngHv/
0uvCQvd8+Eort8qYIpncjp/uVozEAxXKJgj8mRaEngY8QWxrnp4HUL9UQDKiTIeI
7JoKi/HsV8MCnIY67Kmu8wqfC99vDFo8vvtLrSkuUcSUYWaplaJLBE+ZuM71c3/c
4kfDoqd6FAY8GZfY+SjGBmfjJ+biSsmialngEmdR2H66rG1Uu9She54+IKyeEKLK
ZcqkbyK1E6BLX3NN8RJhx+WEHCmLT3f8Xwb8jspW6IemRSbWBrZBH2NA6Dc/7YQs
6f7GMZuoYIdboklemBKQB4idVzZ6wA3BRfSVIaLlIHYkxHm1uu8zjIOV20HW3i2o
Pgiabhf20CP1zcY5FEUcCGhuBU3L1RCye2E4etm1AVS3G5lOflcNbHVW7BB6paJS
oorN02H3fyTn+A5/k5Yk9+/tJ4Z2r0cDvi0OLRqMwzPe8iIbzREb0TqLJb/e/NMI
ZGFEDcW31abaUhw5AGTxQPk8/qSzT4aUbhLrg7pV6nC6nd3nZ1dfgjuVLRdgTwBH
gjPua5ofiJgem6FeXO6i316v2kHeDp/Xq/dO39LcANkSwgfT6DtOskhNUi/l3un3
WDpPt2AFfp+A9ipZiXuZQAxV2rKdlfc4Qp5N2IvUOqg=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
