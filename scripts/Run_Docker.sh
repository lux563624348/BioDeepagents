# Build the container image (ensures the local Dockerfile changes are applied).
IMAGE_NAME=openbio-cli
PORT=8888

docker build -t "$IMAGE_NAME" .

docker run --rm -it -p "${PORT}:${PORT}" -v "$(pwd):/workspace/openbio" --env-file ./.env "$IMAGE_NAME"

# Alternative (docker compose):
# docker compose run --rm --service-ports --build openbio-cli
