## HW02 Не успеваю пока закончить. Если можно, дайте время на добитие задачи. На работе аврал не было времени заняться.
###  Моё приложение представляет из себя простой REST API. API будет предоставлять точки для доступа к «продуктам» и управления ими.

- Создание нового продукта
- Обновление существующего продукта
- Удаление существующего продукта
- Получение существующего продукта
- Получение списка продуктов.

### API Спецификация

<p> Создать новый продукт в ответ на корректный запрос POST по пути /product,
<p> Обновить продукт в ответ на корректный запрос PUT по пути /product/{id},
<p> Удалить продукт в ответ на корректный запрос DELETE/product,
<p> Получить продукт в ответ на корректный запрос GET по пути /product/{id},
<p> Получить список продуктов в ответ на корректный запрос GET по пути /products.


#### Требуемые модули:
- mux – The Gorilla Mux router,
- pq – The PostgreSQL driver.

### Структуры таблиц:
Таблица products содержит поля:
- id – the primary key
- name – Имя продукта
- price – Цена продукта

### CI
Шаги в CI:
- Lint
- Test
- Build app
- Set up Docker Buildx
- Login to DockerHub
- Build image and push to Docker Hub

### CD
Шаги в CD в Heroku:
- пока не сделано, в процессе.
  
### Hands-On deploy in Heroku
<p>https://productapi-01.herokuapp.com/products</p>

Пример создания записи в базе: 
curl -X POST -H "Content-Type: application/json" --data '{"id":1,"name":"milk","price":1.14}'  https://productapi-01.herokuapp.com/product

### Hands-On deploy in K8S
Шаги в CD в Yandex Cloud
- Сделал чарты для postgresql(скачал bitnami) и для приложений. В папке deploy
- Застрял на ингрессе. Кластер-то свой поднял и развернул оба приложения, но потом вспомнил, что нужно ещё публичный DNS заказать. Пока кластер погасил. Для отчёта приложу сюда копию лога из консоли

```
dmvstrelnikov@dmvstrelnikov-VirtualBox:~/Documents/GeekBrains/gb-go-backend1-project/deploy/product-app$ kubectl -n  gb-backend1-dev get pods 
NAME                               READY   STATUS    RESTARTS   AGE
api-product-app-5b549f55bc-z2rqx   1/1     Running   0          25m
multitool-74477484b8-hldtp         1/1     Running   1          17h
products-postgresql-0              1/1     Running   1          18h

dmvstrelnikov@dmvstrelnikov-VirtualBox:~/Documents/GeekBrains/gb-go-backend1-project/deploy/product-app$ kubectl -n  gb-backend1-dev get svc
NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
api-product-app          ClusterIP   10.96.140.130   <none>        8080/TCP   61m
products-postgresql      ClusterIP   10.96.219.184   <none>        5432/TCP   18h
products-postgresql-hl   ClusterIP   None            <none>        5432/TCP   18h

dmvstrelnikov@dmvstrelnikov-VirtualBox:~/Documents/GeekBrains/gb-go-backend1-project/deploy/product-app$ kubectl -n  gb-backend1-dev exec -it multitool-74477484b8-hldtp -- bash
bash-5.1# curl api-product-app.gb-backend1-dev.svc.cluster.local:8080/products
[]

bash-5.1# curl -X POST -H "Content-Type: application/json" --data '{"id":1,"name":"milk","price":1.14}' api-product-app.gb-backend1-dev.svc.cluster.local:8080/product
{"id":2,"name":"milk","price":1.14}bash-5.1# 

bash-5.1# curl api-product-app.gb-backend1-dev.svc.cluster.local:8080/products
[{"id":1,"name":"milk","price":1.14},{"id":2,"name":"milk","price":1.14}]bash-5.1# 
```