bharathkumardasaraju@revisit-argocd$ kubectl get nodes -o wide
NAME                                              STATUS   ROLES    AGE   VERSION               INTERNAL-IP       EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION                  CONTAINER-RUNTIME
i-088a37bb0bede3a51.ap-south-1.compute.internal   Ready    <none>   17m   v1.32.1-eks-5d632ec   192.168.127.57    <none>        Amazon Linux 2   5.10.235-227.919.amzn2.x86_64   containerd://1.7.27
i-0cb0a47e1a1f27ac3.ap-south-1.compute.internal   Ready    <none>   17m   v1.32.1-eks-5d632ec   192.168.156.129   <none>        Amazon Linux 2   5.10.235-227.919.amzn2.x86_64   containerd://1.7.27
bharathkumardasaraju@revisit-argocd$


bharathkumardasaraju@revisit-argocd$ helm upgrade --install argocd argo/argo-cd --set-string configs.params."server\.disable\.auth"=true --version 7.1.1 --create-namespace -n argocd
Release "argocd" does not exist. Installing it now.

NAME: argocd
LAST DEPLOYED: Thu May  1 11:17:44 2025
NAMESPACE: argocd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
In order to access the server UI you have the following options:

1. kubectl port-forward service/argocd-server -n argocd 8080:443

    and then open the browser on http://localhost:8080 and accept the certificate

2. enable ingress in the values file `server.ingress.enabled` and either
      - Add the annotation for ssl passthrough: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
      - Set the `configs.params."server.insecure"` in the values file and terminate SSL at your ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts


After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

(You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)
bharathkumardasaraju@revisit-argocd$
bharathkumardasaraju@revisit-argocd$

bharathkumardasaraju@revisit-argocd$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
DAjsHI-lSyfLUrZR
bharathkumardasaraju@revisit-argocd$
                                                                                                                                                                                                                                                                       bharathkumardasaraju@revisit-argocd$


bharathkumardasaraju@revisit-argocd$ eksdemo install aws-lb-controller --cluster bkuat --region ap-south-1 --default-ingress-class
Creating 1 dependencies for aws-lb-controller
Creating dependency: aws-lb-controller-irsa
2025-05-01 12:03:21 [ℹ]  5 existing iamserviceaccount(s) (awslb/aws-load-balancer-controller,external-dns/external-dns,karpenter/karpenter,kube-system/aws-load-balancer-controller,kube-system/ebs-csi-controller-sa) will be excluded
2025-05-01 12:03:21 [ℹ]  1 iamserviceaccount (awslb/aws-load-balancer-controller) was excluded (based on the include/exclude rules)
2025-05-01 12:03:21 [!]  serviceaccounts that exist in Kubernetes will be excluded, use --override-existing-serviceaccounts to override
2025-05-01 12:03:21 [ℹ]  no tasks
Downloading Chart: https://aws.github.io/eks-charts/aws-load-balancer-controller-1.9.0.tgz
Helm installing...
2025/05/01 12:03:22 creating 2 resource(s)
2025/05/01 12:03:23 beginning wait for 2 resources with timeout of 1m0s
2025/05/01 12:03:23 Clearing REST mapper cache
2025/05/01 12:03:28 creating 1 resource(s)
2025/05/01 12:03:28 creating 12 resource(s)
Using chart version "1.9.0", installed "aws-lb-controller" version "v2.9.0" in namespace "awslb"
NOTES:
AWS Load Balancer controller installed!
bharathkumardasaraju@revisit-argocd$


bharathkumardasaraju@1.install-argocd$ kubectl apply -f aws-lb-controller.yaml
Warning: annotation "kubernetes.io/ingress.class" is deprecated, please use 'spec.ingressClassName' instead
ingress.networking.k8s.io/argocd-ingress created
bharathkumardasaraju@1.install-argocd$


bharathkumardasaraju@1.install-argocd$ kubectl get pods -n argocd
NAME                                                READY   STATUS      RESTARTS   AGE
argocd-application-controller-0                     1/1     Running     0          34s
argocd-applicationset-controller-8557df9d95-pfq6x   1/1     Running     0          37s
argocd-dex-server-9f8885b7b-l9bk8                   1/1     Running     0          36s
argocd-notifications-controller-9c5448fdb-rsndw     1/1     Running     0          66m
argocd-redis-994b6ffdd-w2vps                        1/1     Running     0          66m
argocd-redis-secret-init-v82v9                      0/1     Completed   0          50s
argocd-repo-server-6b477dc87d-ktqj4                 1/1     Running     0          36s
argocd-server-c455457d8-cxwh5                       1/1     Running     0          36s
bharathkumardasaraju@1.install-argocd$ kubectl get ingress -o wide -n argocd
NAME             CLASS    HOSTS                           ADDRESS                                                                 PORTS   AGE
argocd-ingress   <none>   argocd.devops4itengineers.com   k8s-argocd-argocdin-e388c8fe3c-442812329.ap-south-1.elb.amazonaws.com   80      12m
bharathkumardasaraju@1.install-argocd$


bharathkumardasaraju@1.install-argocd$ helm upgrade --install argocd argo/argo-cd --set-string configs.params."server\.disable\.auth"=false   --set configs.cm.url=https://argocd.devops4itengineers.com  --version 7.1.1 --create-namespace -n argocd
Release "argocd" has been upgraded. Happy Helming!
NAME: argocd
LAST DEPLOYED: Thu May  1 12:44:03 2025
NAMESPACE: argocd
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
In order to access the server UI you have the following options:

1. kubectl port-forward service/argocd-server -n argocd 8080:443

    and then open the browser on http://localhost:8080 and accept the certificate

2. enable ingress in the values file `server.ingress.enabled` and either
      - Add the annotation for ssl passthrough: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
      - Set the `configs.params."server.insecure"` in the values file and terminate SSL at your ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts


After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

(You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)
bharathkumardasaraju@1.install-argocd$ kubectl get cm -n argocd
NAME                            DATA   AGE
argocd-cm                       8      86m
argocd-cmd-params-cm            31     86m
argocd-gpg-keys-cm              0      86m
argocd-notifications-cm         1      86m
argocd-rbac-cm                  4      86m
argocd-redis-health-configmap   2      86m
argocd-ssh-known-hosts-cm       1      86m
argocd-tls-certs-cm             0      86m
kube-root-ca.crt                1      86m
bharathkumardasaraju@1.install-argocd$ kubectl get argocd-cm -n argocd -o yaml
error: the server doesn't have a resource type "argocd-cm"
bharathkumardasaraju@1.install-argocd$ kubectl get cm argocd-cm -n argocd -o yaml
apiVersion: v1
data:
  admin.enabled: "true"
  application.instanceLabelKey: argocd.argoproj.io/instance
  exec.enabled: "false"
  server.rbac.log.enforce.enable: "false"
  statusbadge.enabled: "false"
  timeout.hard.reconciliation: 0s
  timeout.reconciliation: 180s
  url: https://argocd.devops4itengineers.com
kind: ConfigMap
metadata:
  annotations:
    meta.helm.sh/release-name: argocd
    meta.helm.sh/release-namespace: argocd
  creationTimestamp: "2025-05-01T03:18:11Z"
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/instance: argocd
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
    app.kubernetes.io/version: v2.11.2
    helm.sh/chart: argo-cd-7.1.1
  name: argocd-cm
  namespace: argocd
  resourceVersion: "25193"
  uid: 79c01eaa-6153-4a03-b593-daf905c6e920
bharathkumardasaraju@1.install-argocd$ kubectl get all -n argocd
NAME                                                    READY   STATUS      RESTARTS   AGE
pod/argocd-application-controller-0                     1/1     Running     0          54s
pod/argocd-applicationset-controller-8557df9d95-pfq6x   1/1     Running     0          21m
pod/argocd-dex-server-9f8885b7b-l9bk8                   1/1     Running     0          21m
pod/argocd-notifications-controller-9c5448fdb-rsndw     1/1     Running     0          87m
pod/argocd-redis-994b6ffdd-w2vps                        1/1     Running     0          87m
pod/argocd-redis-secret-init-qmj8s                      0/1     Completed   0          70s
pod/argocd-repo-server-7b56bd56f6-z5chz                 1/1     Running     0          56s
pod/argocd-server-7cbf7b99f8-5dk4t                      1/1     Running     0          56s

NAME                                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/argocd-applicationset-controller   ClusterIP   10.100.185.230   <none>        7000/TCP            87m
service/argocd-dex-server                  ClusterIP   10.100.234.48    <none>        5556/TCP,5557/TCP   87m
service/argocd-redis                       ClusterIP   10.100.25.201    <none>        6379/TCP            87m
service/argocd-repo-server                 ClusterIP   10.100.92.147    <none>        8081/TCP            87m
service/argocd-server                      ClusterIP   10.100.202.72    <none>        80/TCP,443/TCP      87m

NAME                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/argocd-applicationset-controller   1/1     1            1           87m
deployment.apps/argocd-dex-server                  1/1     1            1           87m
deployment.apps/argocd-notifications-controller    1/1     1            1           87m
deployment.apps/argocd-redis                       1/1     1            1           87m
deployment.apps/argocd-repo-server                 1/1     1            1           87m
deployment.apps/argocd-server                      1/1     1            1           87m

NAME                                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/argocd-applicationset-controller-7dff6d465f   0         0         0       87m
replicaset.apps/argocd-applicationset-controller-8557df9d95   1         1         1       21m
replicaset.apps/argocd-dex-server-8597ffc8f6                  0         0         0       87m
replicaset.apps/argocd-dex-server-9f8885b7b                   1         1         1       21m
replicaset.apps/argocd-notifications-controller-9c5448fdb     1         1         1       87m
replicaset.apps/argocd-redis-994b6ffdd                        1         1         1       87m
replicaset.apps/argocd-repo-server-6b477dc87d                 0         0         0       21m
replicaset.apps/argocd-repo-server-7b56bd56f6                 1         1         1       56s
replicaset.apps/argocd-repo-server-c86b8dcc8                  0         0         0       87m
replicaset.apps/argocd-server-7cbf7b99f8                      1         1         1       56s
replicaset.apps/argocd-server-7d5884856d                      0         0         0       87m
replicaset.apps/argocd-server-c455457d8                       0         0         0       21m

NAME                                             READY   AGE
statefulset.apps/argocd-application-controller   1/1     87m

NAME                                 STATUS     COMPLETIONS   DURATION   AGE
job.batch/argocd-redis-secret-init   Complete   1/1           4s         72s
bharathkumardasaraju@1.install-argocd$
