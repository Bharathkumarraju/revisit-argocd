apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  timeout.reconciliation: 240s


we can change the way Argo CD learns about Git changes, and instead of polling Git provider.

we can use Git webhooks or
we can use webhooks in tandem with reconciliation.This way should the webhooks fail or are operating within an environment behind a firewall - the webhook that cannot reach a deployment will continue as expected.

https://argo-cd.readthedocs.io/en/stable/operator-manual/webhook/
