#!/usr/bin/env bash

WORKING_DIR=${PWD}

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

installKubernetesDashboard() {
  mkdir -p dependencies/
  cd dependencies/
  git clone https://github.com/thmshmm/chart-k8s-dashboard.git k8s-dshbrd/
  helm install k8s-dshbrd --name kubernetes-dashboard
  cd ${WORKING_DIR}
}

installHelm
installTraefik
installKubernetesDashboard
