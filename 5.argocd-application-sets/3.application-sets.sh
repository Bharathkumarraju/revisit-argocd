https://github.com/Bharathkumarraju/gitops-cert-level-2-examples



https://github.com/Bharathkumarraju/gitops-cert-level-2-examples/tree/main/app-of-apps


https://github.com/Bharathkumarraju/gitops-cert-level-2-examples/tree/main/app-of-apps/my-app-list



argocd app create my-favorite-apps \
--project default \
--repo https://github.com/<your user>/gitops-cert-level-2-examples \
--path "./app-of-apps/my-app-list" \
--dest-namespace argocd \
--dest-server https://kubernetes.default.svc

