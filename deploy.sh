

docker build -t toha70/multi-client:latest -t toha70/multi-client:$GIT_SHA  -f ./client/Dockerfile ./client
docker build -t toha70/multi-server:latest -t toha70/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t toha70/multi-worker:latest -t toha70/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push toha70/multi-client:$GIT_SHA
docker push toha70/multi-server:$GIT_SHA
docker push toha70/multi-worker:$GIT_SHA

kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=toha70/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=toha70/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=toha70/multi-worker:$GIT_SHA