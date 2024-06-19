#!/bin/bash
set -o xtrace

# call az login only if not logged in
if [ -z "$(az account show)" ]; then
    az login
fi

# Install azure load extension if not already installed
if [ -z "$(az extension show --name load)" ]; then
    az extension add --name load
fi

# read environment variables
. environment.config

az account set --subscription $subscription_id

cd nodejs-appsvc-cosmosdb-bottleneck

az load create --name $loadTestResource --resource-group $alttf_rg --location $location

az load test create --test-id $testId --load-test-resource $loadTestResource --resource-group $alttf_rg --load-test-config-file SampleApp.yaml --env webapp=$webappHostname