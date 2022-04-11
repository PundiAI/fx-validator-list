#!/usr/bin/env bash

if [ "$2" == "debug" ]; then
  set -x
fi

if [[ "$1" != "testnet" && "$1" != "mainnet" ]]; then
  echo "Invalid networt, Please input ./run.sh testnet or ./run.sh mainnet" && exit 1
fi

node_url="https://fx-json.functionx.io:26657"
node_res_url="https://fx-rest.functionx.io"
if [ "$1" == "testnet" ]; then
  node_url="https://testnet-fx-json.functionx.io:26657"
  node_res_url="https://testnet-fx-rest.functionx.io"
fi

echo "[]" >"./$1/validator.json"

if [ $(command -v fxcored) ]; then
  validators=$(fxcored query staking validators --node "$node_url" --output json | jq '.validators')
else
  validators=$(curl -s "$node_res_url/cosmos/staking/v1beta1/validators" | jq '.validators')
fi

#https://testnet-fx-rest.functionx.io/staking/validators

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
