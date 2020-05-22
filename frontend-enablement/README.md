# Front-end Enablement CI/CD

Front-End Enablement uses the same backend as the Open Practice Library, so here it lives...

**Step 1:**
Deploy the mongo database to your cluster (make sure you are logged and in the right namespace):
```
helm install -f mongodb/values.yaml fee-mongo bitnami/mongo
```
**Step 2:**
Tell ArgoCD to look at your bootstrap application (bootstrap/apps/frontend-enablement.yaml)

**Step 3:**
Watch the magic happen!
![Magic](https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif)
