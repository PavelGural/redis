#!/bin/bash
# This script installs Minikube and starts it with the appropriate hypervisor based on the operating system (Linux or macOS).
# This script has two modes: install Minikube and start Minikube.
# Usage:
# bash minikube/manage.sh install - to install Minikube
# bash minikube/manage.sh start - to start Minikube

install_minikube_linux() {
    echo "Installing Minikube for Linux..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/
}

install_minikube_macos() {
    echo "Installing Minikube for macOS..."
    brew install minikube
}

start_minikube_virtualbox() {
    minikube start --driver=virtualbox
}

start_minikube_docker() {
    minikube start --driver=docker
}

OS=$(uname -s)

if [ $# -lt 1 ]; then
    echo "Error: Please specify the mode ('install' or 'start')."
    exit 1
fi

MODE=$1

# Execute the appropriate function based on the mode and OS
case $MODE in
install)
    case $OS in
    Linux)
        install_minikube_linux
        ;;
    Darwin)
        install_minikube_macos
        ;;
    *)
        echo "Unsupported operating system for install: $OS"
        exit 1
        ;;
    esac
    ;;
start)
    case $OS in
    Linux)
        start_minikube_virtualbox
        ;;
    Darwin)
        start_minikube_hyperkit
        ;;
    *)
        echo "Unsupported operating system for start: $OS"
        exit 1
        ;;
    esac
    ;;
*)
    echo "Invalid mode: $MODE. Please specify 'install' or 'start'."
    exit 1
    ;;
esac
echo "Minikube command ($MODE) completed successfully."
