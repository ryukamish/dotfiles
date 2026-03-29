#!/usr/bin/env bash

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${scriptDir}/message.sh"
printf '%b' "\e[32mSetting default apps.\e[0m"
source "${scriptDir}/mimetype.sh"
source "${scriptDir}/branding.sh"
source "${scriptDir}/kde-support.sh"
