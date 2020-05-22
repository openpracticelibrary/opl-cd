# Front-end Enablement CI/CD

Front-End Enablement uses the same backend as the Open Practice Library, so here it lives...

**Step 1:**
Deploy the mongo database to your cluster (make sure you are logged and in the right namespace):
```
helm install -f mongodb/values.yaml fee-mongo bitnami/mongo
```
**Step 2(a):**
Tell ArgoCD to look at your bootstrap application (../bootstrap/apps/frontend-enablement.yaml) if you have cluster-admin permissions:
```
**From the root directory of this repository**
kustomize build bootstrap/apps/ | kubectl apply -f -
```
**Step 2(b):**
If you do not have cluster-admin permissions (to deploy CRDs like Argo Applications), you'll need to go a bit more manual route:

- Open ArgoCD
- Click "+ New App"
- Fill in the information as you see fit, some pointers:
  - Set Sync Policy to Automatic, and check Prune Resources and Self Heal
  - Repository URL should be this repository (https://github.com/openpracticelibrary/opl-cd.git)
  - Revision should be HEAD or your desired git-ref
  - Destination cluster should be the default option
  - Namespace is the namespace where the _Argo application is running_, not your application (in `s44`, this is `labs-ci-cd`)
- **Make sure you set the Path input to frontend-enablement/backend**
  - This will make sure only changes relevant to the frontend-enablement application are tracked and synced by Argo.

**Step 3:**
Watch the magic happen!

![Magic](https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif)
