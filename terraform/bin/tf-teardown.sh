#!/usr/bin/env bash

# Utility for removing terraform state
# Version: 1.0
# Author: Paul Carlton (mailto:paul.carlton@weave.works)

set -euo pipefail

function usage()
{
    echo "usage ${0} [--debug] " >&2
    echo "This script will remove the AWS s3 bucket used for storing terraform state" >&2
}

function args() {

  arg_list=( "$@" )
  arg_count=${#arg_list[@]}
  arg_index=0
  while (( arg_index < arg_count )); do
    case "${arg_list[${arg_index}]}" in
          "--debug") set -x;;
               "-h") usage; exit;;
           "--help") usage; exit;;
               "-?") usage; exit;;
        *) if [ "${arg_list[${arg_index}]:0:2}" == "--" ];then
               echo "invalid argument: ${arg_list[${arg_index}]}" >&2
               usage; exit
           fi;
           break;;
    esac
    (( arg_index+=1 ))
  done
}

args "$@"

export TF_VAR_prefix_name=${NAMES_PREFIX:-ww-dish-99999}
export TF_VAR_region=${AWS_REGION:-us-west-2}
bucket_name=${TF_VAR_prefix_name}-$(aws sts get-caller-identity --query Account --output text)-${TF_VAR_region}-${BUCKET_NAME:-tf-state}
terraform -chdir=remote-state init
terraform -chdir=remote-state destroy -auto-approve


