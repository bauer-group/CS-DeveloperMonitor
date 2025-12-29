#!/bin/bash
# Dozzle Container Monitor Management Script
# Usage: ./dozzle.sh <command>
# Commands: start, stop, restart, status, logs

set -e
cd "$(dirname "$0")/.."

get_port() {
    if [[ -f .env ]]; then
        grep -oP 'DOZZLE_PORT=\K\d+' .env 2>/dev/null || echo "9999"
    else
        echo "9999"
    fi
}

case "${1:-help}" in
    start)
        docker compose up -d
        echo -e "\033[32mDozzle started at http://localhost:$(get_port)\033[0m"
        ;;
    stop)
        docker compose down
        echo -e "\033[33mDozzle stopped\033[0m"
        ;;
    restart)
        docker compose restart
        echo -e "\033[32mDozzle restarted\033[0m"
        ;;
    status)
        docker compose ps
        ;;
    logs)
        docker compose logs -f
        ;;
    help|*)
        cat <<EOF
Dozzle Container Monitor

Usage: ./dozzle.sh <command>

Commands:
  start     Start Dozzle container
  stop      Stop and remove container
  restart   Restart container
  status    Show container status
  logs      Follow container logs
  help      Show this help message
EOF
        ;;
esac
