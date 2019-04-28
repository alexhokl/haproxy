latest:
	docker build -t alexhokl/haproxy:latest .
development:
	docker build -t alexhokl/haproxy:dev dev/
push:
	docker push alexhokl/haproxy:latest
	docker push alexhokl/haproxy:dev
all: latest development
