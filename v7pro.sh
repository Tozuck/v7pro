#!/bin/bash

echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

apt-get update; apt-get install curl socat git nload speedtest-cli -y


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
curl -sSL https://raw.githubusercontent.com/Tozuck/Node_monitoring/main/node_monitor.sh | bash
rm /var/lib/marzban-node/ssl_client_cert.pem

cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwMzI5MTA1NTQ1WhgPMjEyNTAzMDUxMDU1NDVaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnjpGrtFCCH29
zkLT5EHy4RquQ7EdRR11A1PZHigs3bzje9lyu3tepwNSkVrhg4V6p04KDNL6q/z6
6fuhETVY3O8YjPtY8zLu5sd0t45EZKa36LGg7msopQYFnYs6Jz1c6Yu8hDFiHjs0
e70+V1au/G1vPWl7exZKkXeZsgsvpEqZJohAaO8bk+pD3180tugZ3nl5YG6IYiaS
kl0AogqLYMOL5tm1jB4rIBK54m5tL2dN28gYZOQ1ikLlB3eT1IL2WgYxbViydblq
+7jIzOvu0iRN4Sr389kQSGQq5Z7I7nykpv0WuhpY9Q/HmxnFwtg1tLWiJp5D/0D5
8gff651wGtMXCd8Ow3jvqmtZRWlexBZGfwXN97crBova1X4/FVJfuuCdxAyuejja
3xf+FvGhgDLpKsTTKAtIZ7C/H9UtqFwQQ5pEMghEJf3tQao1qydyqt6jbcgN39oR
RaXlFsrtKB2mDGE6K+CNQWVPNwE8GyFecyMCGGgxjdPUGwriQO4ytFRh4knGlJi8
+B0PnGUD/6VGk2NWweHNUS0OFhJB6i2VhOuKQhDJVaklKe/gaXEFf3uMtkiSVpHK
NPFb/1VQSoZ/6WMoE/FoAVR0ZHFJT7ERCVMluAhjnHGyLSLlRtLJizpngKfZHFmb
mINCFVC1FmijnBZzO0XyVk458YKqXY0CAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
jfwlCfPhnmQn2JGuem/WOAH+N0936MKTqGhe/rO019BAj4b5uS3CLEjZeKAjTpNf
eu5DExBM5+FgsTBE7UH7ZqwLxlZm1hIUvvCTiYzKddtvQ8JrEoIe+YHZxrDqH0zA
N2R/xbKPYKbt7DMy9vVG3bJldQephKWfuTvgaAhi9CyK6xnWoFo92pOQOUoFOWfx
dSb4hKoYpsbux/r0ZFSDbiUN2vjEyHceLOC8zSmdMAQXLWITl/yRcxKo+1nc7LMY
IjtPNFWvwRHXPxQQXKYoKPB2larRhIM3FQBul2PT7v9XRlDj1emi0ovBq0r0funQ
Tjp20mzpgzhoEH802DIyXFnPPh67rzOLLIVbXtBC/e/vKyKAUQdzms/CzmUgYEDN
fu29+7aY53VWR5rX237r1Gx6Sqx0OY0tb4C1+Si5rF7a5eoXMy9mboJCozJ4bAhg
0j97IWBCC1ESsYRjxX4dEJ++QQkz2irIYortE8tM7a7iCmGteDkEuFouwRPfPBnG
/fjnd7ngvXw0m/Z6oAZBOvMjdD/sLDHeEh8ODnB/8aZ484xZw05afQpC2cttVxJw
PTn31jQdYp/x5+1Xg6c4+YZQ9U0kHe2jXwXtabIXbqX/Bf5ZqLjtqdSlsNoT3ON9
1arAWA8yqbxSCinS8nogDDgJkci2HpFwvXWb3XdxQOE=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d

echo_info "Finalizing UFW setup..."

ufw allow 22
ufw allow 80
ufw allow 2096
ufw allow 2053
ufw allow 62050
ufw allow 62051

ufw --force enable
ufw reload
speedtest
