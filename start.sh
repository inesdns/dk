# Check if docker is running;
if ! docker info >/dev/null 2>&1; then
    echo "Docker does not seem to be running, run it first and retry"
    exit 1
fi

echo "Spinning up local Airflow infrastructure"
rm -rf logs
mkdir logs
rm -rf temp
mkdir temp
rm -rf dags
mkdir dags
echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > .env
docker compose up airflow-init
docker compose up -d
echo "Sleeping 2 Minutes to let Airflow containers reach a healthy state"
sleep 120


echo "Successfully setup local Airflow"
