root@host:~/workdir# argocd app list
argocd app get demo
argocd app history demo
NAME         CLUSTER                         NAMESPACE  PROJECT  STATUS  HEALTH   SYNCPOLICY  CONDITIONS  REPO                                                                PATH          TARGET
argocd/demo  https://kubernetes.default.svc  default    default  Synced  Healthy  Manual      <none>      https://github.com/codefresh-contrib/gitops-certification-examples  ./simple-app  HEAD
Name:               argocd/demo
Project:            default
Server:             https://kubernetes.default.svc
Namespace:          default
URL:                https://localhost:30443/applications/demo
Source:
- Repo:             https://github.com/codefresh-contrib/gitops-certification-examples
  Target:           HEAD
  Path:             ./simple-app
SyncWindow:         Sync Allowed
Sync Policy:        Manual
Sync Status:        Synced to HEAD (b2212aa)
Health Status:      Healthy

GROUP  KIND        NAMESPACE  NAME               STATUS  HEALTH   HOOK  MESSAGE
       Service     default    simple-service     Synced  Healthy        service/simple-service created
apps   Deployment  default    simple-deployment  Synced  Healthy        deployment.apps/simple-deployment created
SOURCE  https://github.com/codefresh-contrib/gitops-certification-examples
ID      DATE                           REVISION
0       2025-05-01 05:25:00 +0000 UTC  HEAD (b2212aa)
root@host:~/workdir# argocd app delete demo
Are you sure you want to delete 'demo' and all its resources? [y/n] y
application 'demo' deleted
root@host:~/workdir# argocd app create demo2 \
--project default \
--repo https://github.com/codefresh-contrib/gitops-certification-examples \
--path "./simple-app" \
--dest-namespace default \
--dest-server https://kubernetes.default.svc
application 'demo2' created
root@host:~/workdir# argocd app sync demo2
TIMESTAMP                  GROUP        KIND   NAMESPACE                  NAME    STATUS    HEALTH        HOOK  MESSAGE
2025-05-01T05:27:04+00:00            Service     default        simple-service  OutOfSync  Missing
2025-05-01T05:27:04+00:00   apps  Deployment     default     simple-deployment  OutOfSync  Missing
2025-05-01T05:27:04+00:00            Service     default        simple-service  OutOfSync  Missing              service/simple-service created
2025-05-01T05:27:04+00:00   apps  Deployment     default     simple-deployment  OutOfSync  Missing              deployment.apps/simple-deployment created
2025-05-01T05:27:04+00:00            Service     default        simple-service    Synced  Healthy                  service/simple-service created
2025-05-01T05:27:04+00:00   apps  Deployment     default     simple-deployment    Synced  Progressing              deployment.apps/simple-deployment created

Name:               argocd/demo2
Project:            default
Server:             https://kubernetes.default.svc
Namespace:          default
URL:                https://localhost:30443/applications/demo2
Source:
- Repo:             https://github.com/codefresh-contrib/gitops-certification-examples
  Target:
  Path:             ./simple-app
SyncWindow:         Sync Allowed
Sync Policy:        Manual
Sync Status:        Synced to  (b2212aa)
Health Status:      Progressing

Operation:          Sync
Sync Revision:      b2212aae5034c09173f51607b763dae6b9d498a7
Phase:              Succeeded
Start:              2025-05-01 05:27:04 +0000 UTC
Finished:           2025-05-01 05:27:04 +0000 UTC
Duration:           0s
Message:            successfully synced (all tasks run)

GROUP  KIND        NAMESPACE  NAME               STATUS  HEALTH       HOOK  MESSAGE
       Service     default    simple-service     Synced  Healthy            service/simple-service created
apps   Deployment  default    simple-deployment  Synced  Progressing        deployment.apps/simple-deployment created
root@host:~/workdir#



bharathkumardasaraju@1.install-argocd$ kubectl get all -n default
NAME                                     READY   STATUS    RESTARTS   AGE
pod/simple-deployment-86b67d965c-88g4c   1/1     Running   0          3m52s

NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.100.0.1     <none>        443/TCP          167m
service/simple-service   NodePort    10.100.1.106   <none>        8080:31000/TCP   3m52s

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/simple-deployment   1/1     1            1           3m52s

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/simple-deployment-86b67d965c   1         1         1       3m52s
bharathkumardasaraju@1.install-argocd$

