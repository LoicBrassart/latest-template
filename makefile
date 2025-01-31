stop:
	docker stop $(shell docker ps -a -q)

clean:
	docker system prune -af --volumes

# ie. `make run dev`
run:
	@ENV=$(word 2,$(MAKECMDGOALS)); \
	ENV_FILE=environments/$$ENV/.env; \
	COMPOSE_FILE=environments/$$ENV/compose.yaml; \
	if [ -f "$$ENV_FILE" ] && [ -f "$$COMPOSE_FILE" ]; then \
		docker compose --env-file $$ENV_FILE -f $$COMPOSE_FILE up --build -d; \
	else \
		echo "Fichier $$ENV_FILE ou $$COMPOSE_FILE non trouvé."; \
	fi

# ie. `make enter frontend`
enter:
	CONTAINER=$(word 2,$(MAKECMDGOALS));\
	docker exec -it $$CONTAINER sh