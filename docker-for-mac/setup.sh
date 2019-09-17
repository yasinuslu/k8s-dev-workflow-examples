#!/usr/bin/env bash

installHelm() {
  brew install kubernetes-helm
  helm repo update
  kubectl apply -f rbac-config.yaml
  helm init --upgrade --wait --service-account tiller
}

installTraefik() {
  kubectl create namespace traefik
  helm del --purge traefik
  helm install --namespace=traefik stable/traefik --name traefik --values traefik-values.yaml
}

installHelm
installTraefik
