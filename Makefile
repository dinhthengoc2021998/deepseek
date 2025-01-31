build:
	sh build-image.sh
run:
	docker compose up -d
	echo "OLLAMA RUN DEEPSEEK-R1:1.5b"
	sleep 10
	docker exec -it -d $$(docker ps | grep 'ollama-custom' | awk '{print $$1}') ollama run deepseek-r1:1.5b
	docker exec -it $$(docker ps | grep 'ollama-custom' | awk '{print $$1}') ps -aux
