#!/bin/bash

set -o errexit
set -o pipefail

MIRROR='http://ftp.uk.debian.org/debian/'

docker build -t amd64-debian-mkimage .

for suite in $SUITES; do

	rm -rf output
	mkdir -p output
	docker run --rm --privileged	-e REPO=$REPO \
									-e SUITE=$suite \
									-e MIRROR=$MIRROR \
									-v `pwd`/output:/output amd64-debian-mkimage

	docker build -t $REPO:$suite output/
done
