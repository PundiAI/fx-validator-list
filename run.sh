#!/usr/bin/env bash

if [ "$2" == "debug" ]; then
  set -x
fi

if [[ "$1" != "testnet" && "$1" != "mainnet" ]]; then
  echo "Invalid networt, Please input ./run.sh testnet or ./run.sh mainnet" && exit 1
fi

node_url="https://fx-json.functionx.io:26657"
if [ "$1" == "testnet" ]; then
  node_url="https://testnet-fx-json.functionx.io:26657"
fi

echo "[]" >"./$1/validator.json"

validators=$(fxcored query staking validators --node "$node_url" | jq '.validators')

index=1
while read address moniker website contact; do
  echo $index "$address $moniker"
  mkdir -p "./$1/assets/$address" && touch "./$1/assets/$address/.gitkeep"
  jq --argjson item "{
    \"moniker\": \"$moniker\",
    \"validatorAddress\": \"$address\",
    \"website\": \"$website\",
    \"contact\": \"$contact\"
  }" '.+=[$item]' "./$1/validator.json" >"./$1/validator.tmp.json"
  mv "./$1/validator.tmp.json" "./$1/validator.json"
  index=$((index + 1))
done < <(echo "$validators" | jq -r '.[]|"\(.operator_address) \(.description.moniker) \(.description.website) \(.description.security_contact)"')
