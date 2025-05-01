bharathkumardasaraju@external$ argocd app create demo2 --project default --repo https://github.com/Bharathkumarraju/gitops-certification-examples --path "./simple-app" --dest-namespace test --dest-server https://kubernetes.default.svc
WARN[0001] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web.
application 'demo2' created
bharathkumardasaraju@external$ argocd app sync demo2
WARN[0000] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web.

Name:               argocd/demo2
Project:            default
Server:             https://kubernetes.default.svc
Namespace:          test
URL:                https://argocd.devops4itengineers.com/applications/demo2
Source:
- Repo:             https://github.com/Bharathkumarraju/gitops-certification-examples
  Target:
  Path:             ./simple-app
SyncWindow:         Sync Allowed
Sync Policy:        Manual
Sync Status:        OutOfSync from  (b2212aa)
Health Status:      Missing

Operation:          Sync
Sync Revision:      b2212aae5034c09173f51607b763dae6b9d498a7
Phase:              Failed
Start:              2025-05-01 13:37:04 +0800 +08
Finished:           2025-05-01 13:37:04 +0800 +08
Duration:           0s
Message:            one or more objects failed to apply, reason: Service "simple-service" is invalid: spec.ports[0].nodePort: Invalid value: 31000: provided port is already allocated

GROUP  KIND        NAMESPACE  NAME               STATUS     HEALTH       HOOK  MESSAGE
       Service     test       simple-service     OutOfSync  Missing            Service "simple-service" is invalid: spec.ports[0].nodePort: Invalid value: 31000: provided port is already allocated
apps   Deployment  test       simple-deployment  Synced     Progressing        deployment.apps/simple-deployment created
FATA[0002] Operation has completed with phase: Failed
bharathkumardasaraju@external$



bharathkumardasaraju@external$ argocd app delete demo
WARN[0000] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web.
Are you sure you want to delete 'demo' and all its resources? [y/n] y
application 'demo' deleted
bharathkumardasaraju@external$ argocd app sync demo2
WARN[0000] Failed to invoke grpc call. Use flag --grpc-web in grpc calls. To avoid this warning message, use flag --grpc-web.

Name:               argocd/demo2
Project:            default
Server:             https://kubernetes.default.svc
Namespace:          test
URL:                https://argocd.devops4itengineers.com/applications/demo2
Source:
- Repo:             https://github.com/Bharathkumarraju/gitops-certification-examples
  Target:
  Path:             ./simple-app
SyncWindow:         Sync Allowed
Sync Policy:        Manual
Sync Status:        Synced to  (b2212aa)
Health Status:      Healthy

Operation:          Sync
Sync Revision:      b2212aae5034c09173f51607b763dae6b9d498a7
Phase:              Succeeded
Start:              2025-05-01 13:38:27 +0800 +08
Finished:           2025-05-01 13:38:28 +0800 +08
Duration:           1s
Message:            successfully synced (all tasks run)

GROUP  KIND        NAMESPACE  NAME               STATUS  HEALTH   HOOK  MESSAGE
       Service     test       simple-service     Synced  Healthy        service/simple-service created
apps   Deployment  test       simple-deployment  Synced  Healthy        deployment.apps/simple-deployment unchanged
bharathkumardasaraju@external$

bharathkumardasaraju@1.install-argocd$ kubectl get all -n test
NAME                                     READY   STATUS    RESTARTS   AGE
pod/simple-deployment-86b67d965c-9ftrf   1/1     Running   0          107s

NAME                     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/simple-service   NodePort   10.100.93.240   <none>        8080:31000/TCP   24s

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/simple-deployment   1/1     1            1           108s

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/simple-deployment-86b67d965c   1         1         1       108s
bharathkumardasaraju@1.install-argocd$


