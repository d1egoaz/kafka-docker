DOCKER_COMPOSE_CMD = DOCKER_HOST_IP=$$(ipconfig getifaddr en0) docker-compose up --no-recreate -d

up:
	$(DOCKER_COMPOSE_CMD)

logs:
	docker-compose logs -f

scale-up-kafka1:
	$(DOCKER_COMPOSE_CMD) --scale kafka1=1
scale-up-kafka2:
	$(DOCKER_COMPOSE_CMD) --scale kafka2=1
scale-up-kafka3:
	$(DOCKER_COMPOSE_CMD) --scale kafka3=1

scale-down-kafka1:
	$(DOCKER_COMPOSE_CMD) --scale kafka1=0
scale-down-kafka2:
	$(DOCKER_COMPOSE_CMD) --scale kafka2=0
scale-down-kafka3:
	$(DOCKER_COMPOSE_CMD) --scale kafka3=0

down:
	docker-compose down

clean:
	docker rm $$(docker ps -q -f 'status=exited')

kafkacat-configure:
	./broker-list.sh | xargs echo "bootstrap.servers=" > .kafkacat.conf

kafkacat-meta: kafkacat-configure
	kafkacat -L -F .kafkacat.conf
