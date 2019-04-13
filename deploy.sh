docker build -t gallagher94/multi-client:latest -t gallagher94/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t gallagher94/multi-server:latest -t gallagher94/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t gallagher94/multi-worker:latest -t gallagher94/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push gallagher94/mulit-client:latest
docker push gallagher94/mulit-server:latest
docker push gallagher94/mulit-worker:latest

docker push gallagher94/mulit-client:$GIT_SHA
docker push gallagher94/mulit-server:$GIT_SHA
docker push gallagher94/mulit-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=gallagher94/multi-server:$GIT_SHA
kubectl set image deployment/client-deployment client=gallagher94/multi-client:$GIT_SHA
kubectl set image deployment/worker-deployment worker=gallagher94/multi-worker:$GIT_SHA