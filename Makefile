DOCKER_TAG := torch_ngp:0.01
docker_build:
	docker build --tag $(DOCKER_TAG) .
docker_push:
	docker push $(DOCKER_TAG)
docker_test:
	docker run --rm \
		-v `pwd`:/workdir \
		-v /data_nas/yupeng/ddmatch_worker_test:/tmp \
		--gpus all \
		--net host \
		--name torch_ngp \
		-it $(DOCKER_TAG) bash
