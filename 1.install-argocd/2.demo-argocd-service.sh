root@kubernetes-vm:~/workdir# kubectl get svc -n argocd -o wide
NAME                               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE     SELECTOR
argocd-repo-server                 ClusterIP   10.43.99.219    <none>        8081/TCP            9m49s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-repo-server
argocd-applicationset-controller   ClusterIP   10.43.178.48    <none>        7000/TCP            9m49s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-applicationset-controller
argocd-redis                       ClusterIP   10.43.251.50    <none>        6379/TCP            9m49s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-redis
argocd-dex-server                  ClusterIP   10.43.89.162    <none>        5556/TCP,5557/TCP   9m49s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-dex-server
argocd-server                      ClusterIP   10.43.220.17    <none>        80/TCP,443/TCP      9m49s   app.kubernetes.io/instance=argocd,app.kubernetes.io/name=argocd-server
argocd-server-nodeport             NodePort    10.43.184.196   <none>        8080:30443/TCP      31s     app.kubernetes.io/name=argocd-server
root@kubernetes-vm:~/workdir#


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


root@kubernetes-vm:~/workdir# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > admin-pass.txt
root@kubernetes-vm:~/workdir# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
2NyA0IaBSCw4T5xP
root@kubernetes-vm:~/workdir#
root@kubernetes-vm:~/workdir#
root@kubernetes-vm:~/workdir# cat admin-pass.txt
2NyA0IaBSCw4T5xP
root@kubernetes-vm:~/workdir#
root@kubernetes-vm:~/workdir# ls -lrth
total 8.0K
-rw-r--r-- 1 root root 279 May  1 02:00 service.yml
-rw-r--r-- 1 root root  16 May  1 02:06 admin-pass.txt
root@kubernetes-vm:~/workdir#
