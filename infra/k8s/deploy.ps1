# kubectl kustomize overlays\seatunnel-master\sbx
kubectl apply -k overlays\seatunnel-master\sbx
kubectl port-forward svc/seatunnel-master 8080:8080

# kubectl kustomize overlays\seatunnel-worker\sbx
kubectl apply -k overlays\seatunnel-worker\sbx
kubectl port-forward svc/seatunnel-worker 8080:8080

kubectl apply -k overlays\redis\sbx
kubectl port-forward svc/redis 6379:6379

kubectl apply -k overlays\cassandra\sbx
kubectl port-forward svc/cassandra 9042:9042
kubectl exec -it cassandra-0 -n default -- cqlsh -f infra\scripts\cql\cassandra-init.cql -u cassandra -p cassandra