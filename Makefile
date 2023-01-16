include Makefile.env

check_app_nulity:
	@[ -z "${app}" ] && \
		{ echo "Application is NOT specified."; exit 1; } || \
		exit 0

build.node-dev:
	@docker build node-dev -t $(IMAGE) \
		--build-arg NODE_IMAGE_TAG=${NODE_IMAGE_TAG}
up:
	@docker compose up -d
down:
	@docker compose down
ps:
	@docker compose ps -a

up.nginx:
	@docker compose up nginx -d
shell.nginx:
	@docker compose exec nginx /bin/sh
restart.nginx:
	@docker compose restart nginx
logs.nginx:
	@docker compose logs nginx -f

up.admin:
	@docker compose up admin -d
shell.admin:
	@docker compose exec admin /bin/sh

up.cypress:
	@docker compose up cypress -d
shell.cypress:
	@IP=${IP} docker compose exec cypress /bin/bash
restart.cypress:
	@docker compose restart cypress
logs.cypress:
	@docker compose logs cypress -f

new.app: check_app_nulity
	@docker compose exec admin /bin/bash -c 'npm create vite@latest ${app} -- --template vue' \
		&& docker compose exec admin /bin/bash -c 'cd ${WORKDIR}/${app} && npm install'

new.cypress: check_app_nulity
	@docker compose exec cypress /bin/bash -c 'mkdir ${WORKDIR}/${app} && cypress open --project ${app}'

open.cypress: check_app_nulity
	@docker compose exec cypress /bin/bash -c 'cypress open --project ${app}'

run.test: check_app_nulity
	@docker compose exec cypress cypress run --project ${app}

up.demo:
	@docker compose up demo -d
shell.demo:
	@docker compose exec demo /bin/sh
restart.demo:
	@docker compose restart demo
logs.demo:
	@docker compose logs demo -f

show.host-ip:
	@echo ${HOST_IP}
update.host-ip.env:
	@echo "DISPLAY=$(HOST_IP):0" > host-ip.env
show.xhost.ip:
	@xhost
add.xhost.ip:
	@xhost + ${HOST_IP}
update.host-ip: update.host-ip.env add.xhost.ip

prune:
	@docker image prune -f
clean: prune

.PHONY: check_app_nulity build.node-dev up down ps \
				shell.nginx restart.nginx logs.nginx \
				shell.admnin \
				shell.cypress restart.cypress logs.cypress \
				new.app open.cypress run.test \
				shell.demo restart.demo logs.demo \
				show.host-ip show.xhost.ip \
				update.host-ip update.host-ip.env add.xhost.ip \
				prune clean

