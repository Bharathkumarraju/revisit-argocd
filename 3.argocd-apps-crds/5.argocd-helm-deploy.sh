argocd app create demo \
--project default \
--repo https://github.com/Bharathkumarraju/gitops-certification-examples/ \
--path "./helm-apps/simple-chart" \
--sync-policy auto \
--dest-namespace default \
--dest-server https://kubernetes.default.svc


root@host:~/workdir# argocd app create demo \
--project default \
--repo https://github.com/Bharathkumarraju/gitops-certification-examples/ \
--path "./helm-apps/simple-chart" \
--sync-policy auto \
--dest-namespace default \
--dest-server https://kubernetes.default.svc

application 'demo' created
root@host:~/workdir#


root@host:~/workdir# argocd app create demo \
--project default \
--repo https://github.com/Bharathkumarraju/gitops-certification-examples/ \
--path "./helm-apps/simple-chart" \
--sync-policy auto \
--dest-namespace default \
--dest-server https://kubernetes.default.svc

application 'demo' created
root@host:~/workdir# kubectl get apps -A
NAMESPACE   NAME   SYNC STATUS   HEALTH STATUS
argocd      demo   Synced        Healthy
root@host:~/workdir# kubectl get all
NAME                                     READY   STATUS    RESTARTS   AGE
pod/demo-helm-example-6d6b8ccc65-tmr8g   1/1     Running   0          4m12s

NAME                        TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/kubernetes          ClusterIP   10.43.0.1      <none>        443/TCP   334d
service/demo-helm-example   ClusterIP   10.43.188.49   <none>        80/TCP    4m12s

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo-helm-example   1/1     1            1           4m12s

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/demo-helm-example-6d6b8ccc65   1         1         1       4m12s
root@host:~/workdir#

