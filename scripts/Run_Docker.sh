docker run --rm -it -p 8000:8000 -v "$(pwd)/workspace/:/workspace/project" --env-file ./.env deepagents-cli

#docker build -f ./Dockerfile -t deepagents-cli .
#docker compose run --rm --service-ports --build flask-app