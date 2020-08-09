docker build -t supertam/multi-client:latest -t supertam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t supertam/multi-server:latest -t supertam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t supertam/multi-worker:latest -t supertam/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push supertam/multi-client:latest
docker push supertam/multi-server:latest
docker push supertam/multi-worker:latest

docker push supertam/multi-client:$SHA
docker push supertam/multi-server:$SHA
docker push supertam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=supertam/multi-server:$SHA
kubectl set image deployments/client-deployment client=supertam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=supertam/multi-worker:$SHA