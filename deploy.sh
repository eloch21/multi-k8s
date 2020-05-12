docker build -t eloch21/multi-client:latest -t eloch21/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t eloch21/multi-server:latest -t eloch21/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t eloch21/multi-worker:latest -t eloch21/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push eloch21/multi-client:latest
docker push eloch21/multi-server:latest
docker push eloch21/multi-worker:latest
docker push eloch21/multi-client:$SHA
docker push eloch21/multi-server:$SHA
docker push eloch21/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eloch21/multi-server:$SHA
kubectl set image deployments/client-deployment client=eloch21/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eloch21/multi-worker:$SHA
