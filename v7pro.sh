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
IBcNMjUwMjIzMTg1NzQwWhgPMjEyNTAxMzAxODU3NDBaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyUGXad4n+l91
Hfarl3X3Pssowp32aX38J2/bdGs45DUT/Vk6yV2uGKziqMsu+x37qnpaSd4DFCIk
IyB3ICO5frMvV1voERHVAAgGRx7sxjfXdX4vOy8sNMA72ISfWcI1MH/r+f43ubwr
3RKXiobtZr2vF5oRbvU0BatSsgaZp57H8DnOx+jMuwUmnSKRZVv0GRgrjcfYtg9h
oKDhzqKDd1Qj/vIoXrYPLnJwaZyzGyozBQQLV7DafXxl4/0zLOikuC1p7taBdEd0
Diq2g2krEKXcRilUd4mUv6hEeZWhTwQvxKghHdAf+cjByFILRdH3vhS9Rq0KzJnC
/LpbA1oqoMdZrlemvEA/+aklLHTOuOuGAh0Cc9007pbph7ymYyagNtoKCUMYhO9F
rRmNFnzIsWAtOSCbhNJPHvzQPsv/oSy2FMQv2HZSTJVYe1aMdej+U0vCQvNaJy2g
n9JUm7Gmr0L7+U9MwtEF3/sdhZZ79VY2zyveCrU4H/Z3Uu0E1mc8YxqlbIvKrU92
8QQf++a+9x96a+zCGoYt8bBWaVdguYeT8yJuS0TwCoyUpqpsEIQKcv2xBDE2YUu9
W+X48OtngC2zkRsOoGnOe0lSRSADHEKK3XE+Wgc8XTBd4rZaFEaUAdCM+5diqKKD
Yswy9MrF3vUvQcE2Hkj86dQnpqBkfRcCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
k/kFyW21JlRkRtR07BJ5Ojr8tn8kjWUW21LG+zCznCkif9FDPt6fOZWqWhiud5il
oZOzR9qHAl2S6eWhtSI7NdorWtVSiy6xvsyMKMzmzdRfyAq3xwTB4ne6Rb7FyYia
+qnmieJklHZZedHiddcv2jjjBD+QLfrqciSggRyNOPacMct0STmN2gyjHMS+R7/F
1dXGwiwJ3mkV1C3rFIc8rqCqUIE7ljkvu2TdXFaSM4JdZcis3EafT2SDmyFtQTky
eZxu7pPUVBdc5+0qOx2ujiIxlyM5i/PDPGwECnhIBIVk8CeuQrj9Ic0krQbrjaDF
eascI0HoMijj50sM+eGu+/ovwZI+uOrWGfqk0A2vRh9HHdNchjQxCxlrwCIOR9md
iKJbHABk8LEzJL6uQV4+aDmSi4hBXknCgNcKimSLc/JkYvOx5wcIrYTd/rlNbzz/
yCFaa+cpxFKtZwHnS9b5tAjyyl2qM06urp55CKznWNf7ct2RXcT7l0Ou2oSCcPTK
qoTFYnUo7IwpFFRzZX8V7R9kWwop0MWF5PLSkOKeeF3+pHISoG2FQf5MInmlmKx1
WireEzCdoKu0vvpdvjA03hX+PdY6ir68aTx2aYsOoYIvlzn1vdNMEfetzV1x8Vxl
lvI8Goy/3iJ0DLTEX3ejJ39dCjppiuo7ZesMadclEfw=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
