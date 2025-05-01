Manual or automatic sync defines what Argo CD does when it finds a new version of your application in Git.
If set to automatic, Argo CD will apply the changes then update/create new resources in the cluster.
If set to manual, Argo CD will detect the change but will not change anything in the cluster.

Auto-pruning defines what Argo CD does when you remove/delete files from Git.
If it is enabled, Argo CD will also remove the respective resources in the cluster as well.
If disabled, Argo CD will never delete anything from the cluster.


Self-heal defines what Argo CD does when you make changes directly to the cluster (via kubectl or any other way).
Note that doing manual changes in the cluster is not recommended if you want to follow GitOps principles (as all changes should pass from Git).
If enabled, then Argo CD will discard the extra changes and bring the cluster back to the state described in Git.


