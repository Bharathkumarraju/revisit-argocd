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


