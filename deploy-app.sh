#!/bin/bash
set -o xtrace

# call az login only if not logged in
if [ -z "$(az account show)" ]; then
    az login
fi

# read environment variables
. environment.config

az account set --subscription $subscription_id

git clone https://github.com/Azure-Samples/nodejs-appsvc-cosmosdb-bottleneck.git

# call a powershell script to deploy the app called .\deploymentscript.ps1
cd nodejs-appsvc-cosmosdb-bottleneck
pwsh deploymentscript.ps1 
