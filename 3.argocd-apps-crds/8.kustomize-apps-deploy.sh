root@host:~/workdir# argocd app create staging-app \
--project default \
--repo https://github.com/Bharathkumarraju/gitops-certification-examples \
--path "./kustomize-apps/overlays/staging" \
--sync-policy auto \
--dest-namespace default \
--dest-server https://kubernetes.default.svc
application 'staging-app' created
root@host:~/workdir#



root@host:~/workdir# argocd app create production-app \
--project default \
--repo https://github.com/Bharathkumarraju/gitops-certification-examples/ \
--path "./kustomize-apps/overlays/production" \
--sync-policy auto \
--dest-namespace default \
--dest-server https://kubernetes.default.svc
application 'production-app' created
root@host:~/workdir#
