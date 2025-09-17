#!/usr/bin/env bash
set -euo pipefail

echo "Running CI tests..."

#Build and start services with docker-compose
docker compose -f compose.yaml up -d --build

#Verify node1 is running and SSH is available
docker exec node1 which sshd
docker exec node1 python3 --version
docker exec node1 id ubuntu
echo "node1 checks passed."

#Verify node2 is running and SSH is available
docker exec node2 which sshd
docker exec node2 python3 --version
docker exec node2 id ubuntu
echo "node2 checks passed."

#Confirm both containers are networked correctly
ping1=$(docker exec node1 ping -c 1 node2 | grep "1 packets transmitted")
if [[ -z "$ping1" ]]; then
  echo "❌ Test failed: node1 cannot ping node2"
  exit 1
fi
echo "node1 can reach node2 over ansible_net."

#Cleanup
docker compose -f compose.yaml down

echo "All tests passed successfully!"

