bharathkumardasaraju@1.install-argocd$ kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/latest/download/controller.yaml

deployment.apps/sealed-secrets-controller created
customresourcedefinition.apiextensions.k8s.io/sealedsecrets.bitnami.com created
service/sealed-secrets-controller created
role.rbac.authorization.k8s.io/sealed-secrets-key-admin created
serviceaccount/sealed-secrets-controller created
rolebinding.rbac.authorization.k8s.io/sealed-secrets-service-proxier created
role.rbac.authorization.k8s.io/sealed-secrets-service-proxier created
service/sealed-secrets-controller-metrics created
rolebinding.rbac.authorization.k8s.io/sealed-secrets-controller created
clusterrolebinding.rbac.authorization.k8s.io/sealed-secrets-controller created
clusterrole.rbac.authorization.k8s.io/secrets-unsealer created
bharathkumardasaraju@1.install-argocd$ kubectl create secret generic my-secret --from-literal=password=SuperSecret --dry-run=client -o yaml > my-secret.yaml

bharathkumardasaraju@1.install-argocd$ vim my-secret.yaml
bharathkumardasaraju@1.install-argocd$ cat my-secret.yaml
apiVersion: v1
data:
  password: U3VwZXJTZWNyZXQ=
kind: Secret
metadata:
  creationTimestamp: null
  name: my-secret
bharathkumardasaraju@1.install-argocd$ echo "U3VwZXJTZWNyZXQ=" | base64 -d
SuperSecret
bharathkumardasaraju@1.install-argocd$                                                                                                                                                                                                                                                                          bharathkumardasaraju@1.install-argocd$


bharathkumardasaraju@1.install-argocd$ kubeseal
(tty detected: expecting json/yaml k8s resource in stdin)
^C
bharathkumardasaraju@1.install-argocd$ kubeseal --controller-name=sealed-secrets-controller --controller-namespace=kube-system -o yaml < my-secret.yaml > my-sealed-secret.yaml
bharathkumardasaraju@1.install-argocd$





