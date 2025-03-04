#!/usr/bin/env bash

#
# Copyright 2016 The BigDL Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This is the default script with maven parameters to release all the bigdl sub-packages
# built on top of both Spark2 and Spark3 version for mac.

set -e
RUN_SCRIPT_DIR=$(cd $(dirname $0) ; pwd)
echo $RUN_SCRIPT_DIR
BIGDL_DIR="$(cd ${RUN_SCRIPT_DIR}/../..; pwd)"
echo $BIGDL_DIR

if (( $# < 2)); then
  echo "Usage: release_default_mac.sh version upload"
  echo "Usage example: bash release_default_mac.sh default true"
  echo "Usage example: bash release_default_mac.sh 0.14.0.dev1 false"
  exit -1
fi

version=$1
upload=$2

# Release nano.
NANO_SCRIPT_DIR="$(cd ${BIGDL_DIR}/python/nano/dev; pwd)"
echo $NANO_SCRIPT_DIR
bash ${NANO_SCRIPT_DIR}/release_default_mac.sh ${version} ${upload}
# Serving has a universal jar for all platforms and spark versions and is released in the release_default_linux.sh.

# Release default bigdl without suffix
bash ${RUN_SCRIPT_DIR}/release_default_mac_spark246.sh ${version} false ${upload} false

# Release bigdl-spark2. Using quick build as this will be the same as bigdl without suffix
bash ${RUN_SCRIPT_DIR}/release_default_mac_spark246.sh ${version} true ${upload} true

# Release bigdl-spark3
bash ${RUN_SCRIPT_DIR}/release_default_mac_spark313.sh ${version} false ${upload} true
