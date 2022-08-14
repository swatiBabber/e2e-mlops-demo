# spark log4j config
export SPARK_CONF_DIR=$(PWD)/conf/local
# pyspark python entrypoints
PYTHON_ENTRYPOINT=$(shell which python)
export PYSPARK_PYTHON=$(PYTHON_ENTRYPOINT)
export PYSPARK_DRIVER_PYTHON=$(PYTHON_ENTRYPOINT)

# used only in serve
export MLFLOW_TRACKING_URI=databricks://e2e-mlops-demo
export MLFLOW_REGISTRY_URI=databricks://e2e-mlops-demo
export MODEL_NAME=e2e-mlops-demo
export MODEL_VERSIONS=27,28

test:
	pytest tests/unit $(ARGS)

serve:
	uvicorn e2e_mlops_demo.serving.app:get_app --factory --log-level=debug

entry:
	python

build-docker-dev:
	docker build -t e2e-mlops-demo -f docker/Dockerfile.dev .