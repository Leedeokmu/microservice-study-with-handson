# minikube 엔진을 docker 환경과 연결
minikube docker-env --shell=powershell | iex
# 빌드
./gradlew build -x test
# docker 이미지 생성
docker-compose build
# 상용환경에서는 resource manager 만 외부에 띄움
docker-compose up -d mongodb mysql rabbitmq

# 생성된 docker 이미지에 v1 태그 붙임
docker tag hands-on/auth-server hands-on/auth-server:v1
docker tag hands-on/config-server hands-on/config-server:v1
docker tag hands-on/gateway hands-on/gateway:v1
docker tag hands-on/product-composite-service hands-on/product-composite-service:v1
docker tag hands-on/product-service hands-on/product-service:v1
docker tag hands-on/recommendation-service hands-on/recommendation-service:v1
docker tag hands-on/review-service hands-on/review-service:v1
# namespace 생성 후 해당 namespace 로 변경
kubectl create namespace hands-on
kubectl config set-context (kubectl config current-context) --namespace=hands-on

# configmap, secret 생성
kubectl create configmap config-repo --from-file=config-repo/ --save-config
kubectl create secret generic config-server-secrets --from-literal=ENCRYPT_KEY=my-very-secure-encrypt-key --from-literal=SPRING_SECURITY_USER_NAME=dev-usr --from-literal=SPRING_SECURITY_USER_PASSWORD=dev-pwd --save-config
kubectl create secret generic config-client-credentials --from-literal=CONFIG_SERVER_USR=dev-usr --from-literal=CONFIG_SERVER_PWD=dev-pwd --save-config

# 상용 환경으로 쿠버네티스에 배포
kubectl apply -k kubernetes/services/overlays/prod
# 배포 완료 대기
kubectl wait --timeout=600s --for=condition=ready pod --all