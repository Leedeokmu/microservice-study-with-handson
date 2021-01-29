eval $(minikube docker-env)
./gradlew build -x test && docker-compose build

kubectl create namespace hands-on
kubectl config set-context $(kubectl config current-context) --namespace hands-on

kubectl create configmap config-repo --from-file=config-repo/ --save-config

kubectl create secret generic config-server-secrets --from-literal=ENCRYPT_KEY=my-very-secure-encrypt-key --from-literal=SPRING_SECURITY_USER_NAME=dev-usr --from-literal=SPRING_SECURITY_USER_PASSWORD=dev-pwd --save-config

kubectl create secret generic config-client-credentials --from-literal=CONFIG_SERVER_USR=dev-usr --from-literal=CONFIG_SERVER_PWD=dev-pwd --save-config

docker pull mysql:5.7
docker pull mongo:3.6.9
docker pull rabbitmq:3.7.8-management
docker pull openzipkin/zipkin:2.12.9

kubectl apply -k kubernetes/services/overlays/dev

kubectl wait --timeout=600s --for=condition=ready pod --all