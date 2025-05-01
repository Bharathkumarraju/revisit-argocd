helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install argocd argo/argo-cd --set-string configs.params."server\.disable\.auth"=true --version 7.1.1 --create-namespace -n argocd


root@kubernetes-vm:~/workdir# helm repo add argo https://argoproj.github.io/argo-helm
"argo" has been added to your repositories
root@kubernetes-vm:~/workdir# helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "argo" chart repository
Update Complete. ⎈Happy Helming!⎈
root@kubernetes-vm:~/workdir#

root@kubernetes-vm:~/workdir# helm search repo argo
NAME                            CHART VERSION   APP VERSION     DESCRIPTION
argo/argo                       1.0.0           v2.12.5         A Helm chart for Argo Workflows
argo/argo-cd                    7.9.0           v2.14.11        A Helm chart for Argo CD, a declarative, GitOps...
argo/argo-ci                    1.0.0           v1.0.0-alpha2   A Helm chart for Argo-CI
argo/argo-events                2.4.15          v1.9.6          A Helm chart for Argo Events, the event-driven ...
argo/argo-lite                  0.1.0                           Lighweight workflow engine for Kubernetes
argo/argo-rollouts              2.39.5          v1.8.2          A Helm chart for Argo Rollouts
argo/argo-workflows             0.45.13         v3.6.7          A Helm chart for Argo Workflows
argo/argocd-applicationset      1.12.1          v0.4.1          A Helm chart for installing ArgoCD ApplicationSet
argo/argocd-apps                2.0.2                           A Helm chart for managing additional Argo CD Ap...
argo/argocd-image-updater       0.12.1          v0.16.0         A Helm chart for Argo CD Image Updater, a tool ...
argo/argocd-notifications       1.8.1           v1.2.1          A Helm chart for ArgoCD notifications, an add-o...
root@kubernetes-vm:~/workdir# helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "argo" chart repository
Update Complete. ⎈Happy Helming!⎈
root@kubernetes-vm:~/workdir# helm upgrade --install argocd argo/argo-cd --set-string configs.params."server\.disable\.auth"=true --version 7.1.1 --create-namespace -n argocd
Release "argocd" does not exist. Installing it now.
NAME: argocd
LAST DEPLOYED: Thu May  1 01:54:02 2025
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
root@kubernetes-vm:~/workdir#


root@kubernetes-vm:~/workdir# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
2NyA0IaBSCw4T5xP
root@kubernetes-vm:~/workdir#



root@kubernetes-vm:~/workdir# kubectl get pods -n argocd
NAME                                               READY   STATUS      RESTARTS   AGE
argocd-redis-secret-init-87654                     0/1     Completed   0          3m15s
argocd-notifications-controller-67c856dbb7-z4697   1/1     Running     0          3m1s
argocd-applicationset-controller-c57b787bd-cg4ct   1/1     Running     0          3m1s
argocd-redis-698f57d9b9-lfwpr                      1/1     Running     0          3m1s
argocd-dex-server-857f58d6cd-9xkk4                 1/1     Running     0          3m1s
argocd-repo-server-684dbb6b6d-lb2vf                1/1     Running     0          3m1s
argocd-application-controller-0                    1/1     Running     0          3m1s
argocd-server-9469dc86f-nl9rz                      1/1     Running     0          3m
root@kubernetes-vm:~/workdir#



1. argocd-server
2. argocd-repo-server

1. argocd-application-controller
2. argocd-applicationset-controller

1.argocd-redis

1. argocd-dex-server

1. argocd-notification-controller






root@kubernetes-vm:~/workdir# kubectl get all -n argocd
NAME                                                   READY   STATUS      RESTARTS   AGE
pod/argocd-redis-secret-init-87654                     0/1     Completed   0          9m1s
pod/argocd-notifications-controller-67c856dbb7-z4697   1/1     Running     0          8m47s
pod/argocd-applicationset-controller-c57b787bd-cg4ct   1/1     Running     0          8m47s
pod/argocd-redis-698f57d9b9-lfwpr                      1/1     Running     0          8m47s
pod/argocd-dex-server-857f58d6cd-9xkk4                 1/1     Running     0          8m47s
pod/argocd-repo-server-684dbb6b6d-lb2vf                1/1     Running     0          8m47s
pod/argocd-application-controller-0                    1/1     Running     0          8m47s
pod/argocd-server-9469dc86f-nl9rz                      1/1     Running     0          8m46s

NAME                                       TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
service/argocd-repo-server                 ClusterIP   10.43.99.219   <none>        8081/TCP            8m48s
service/argocd-applicationset-controller   ClusterIP   10.43.178.48   <none>        7000/TCP            8m48s
service/argocd-redis                       ClusterIP   10.43.251.50   <none>        6379/TCP            8m48s
service/argocd-dex-server                  ClusterIP   10.43.89.162   <none>        5556/TCP,5557/TCP   8m48s
service/argocd-server                      ClusterIP   10.43.220.17   <none>        80/TCP,443/TCP      8m48s

NAME                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/argocd-notifications-controller    1/1     1            1           8m47s
deployment.apps/argocd-applicationset-controller   1/1     1            1           8m47s
deployment.apps/argocd-redis                       1/1     1            1           8m47s
deployment.apps/argocd-dex-server                  1/1     1            1           8m47s
deployment.apps/argocd-repo-server                 1/1     1            1           8m47s
deployment.apps/argocd-server                      1/1     1            1           8m47s

NAME                                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/argocd-notifications-controller-67c856dbb7   1         1         1       8m47s
replicaset.apps/argocd-applicationset-controller-c57b787bd   1         1         1       8m47s
replicaset.apps/argocd-redis-698f57d9b9                      1         1         1       8m47s
replicaset.apps/argocd-dex-server-857f58d6cd                 1         1         1       8m47s
replicaset.apps/argocd-repo-server-684dbb6b6d                1         1         1       8m47s
replicaset.apps/argocd-server-9469dc86f                      1         1         1       8m47s

NAME                                             READY   AGE
statefulset.apps/argocd-application-controller   1/1     8m47s

NAME                                 COMPLETIONS   DURATION   AGE
job.batch/argocd-redis-secret-init   1/1           13s        9m1s
root@kubernetes-vm:~/workdir#