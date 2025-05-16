#Script for collecting libraries, converting form external to internal
#as a workaround for https://github.com/crytic/medusa/issues/139
#Based on @aviggiano script https://gist.github.com/aviggiano/d0c31c26c18535b25a0e75d185436e8b
#On mac use gnu-sed

#!/usr/bin/env bash
set -ux

j=$((0x10))

mkdir test/fuzzing/
mkdir test/fuzzing/contracts
cp -r contracts test/fuzzing/

SOLIDITY_FILES=$(find test/fuzzing/contracts -type f -name "*.sol" -exec grep -l "library" {} \;)
echo "$SOLIDITY_FILES" > LIBRARIES_LIST.txt
SOLIDITY_FILES=$(cat LIBRARIES_LIST.txt | sed 's/.*\///' | sed 's/\.sol$//')

rm COMPILE_LIBRARIES.txt || true
rm DEPLOY_CONTRACTS.txt || true
rm PREDEPLOYED_CONTRACTS.txt || true

while read i; do 
    echo "($i,$(printf "0x%x" $j))" >> COMPILE_LIBRARIES.txt
    echo "[$(printf "\"0x%x\"" $j), \"$i\"]" >> DEPLOY_CONTRACTS.txt
    echo "    \"$i\": \"$(printf "0x%x" $j)\"" >> PREDEPLOYED_CONTRACTS.txt
    j=$((j+1))
done <<< "$SOLIDITY_FILES"

COMPILE_LIBRARIES=$(cat COMPILE_LIBRARIES.txt | paste -sd, -)
DEPLOY_CONTRACTS=$(cat DEPLOY_CONTRACTS.txt | paste -sd, -)
PREDEPLOYED_CONTRACTS=$(cat PREDEPLOYED_CONTRACTS.txt | paste -sd, -)
PREDEPLOYED_CONTRACTS="\"predeployedContracts\": {\n$PREDEPLOYED_CONTRACTS\n}"

echo $COMPILE_LIBRARIES
echo $DEPLOY_CONTRACTS
echo $PREDEPLOYED_CONTRACTS

# Update echidna.yaml
sed -i '' "s/cryticArgs.*/cryticArgs: [\"--compile-libraries=$COMPILE_LIBRARIES\"]/" echidna.yaml
sed -i '' "s/deployContracts.*/deployContracts: [$DEPLOY_CONTRACTS]/g" echidna.yaml

# Update medusa.json
sed -i '' "s/cryticArgs.*/cryticArgs: [\"--compile-libraries=$COMPILE_LIBRARIES\"]/" medusa.json
sed -i '' "/\"predeployedContracts\":.*/d" medusa.json  # Remove existing predeployedContracts if any
sed -i '' "s/\"args\":.*/$PREDEPLOYED_CONTRACTS,\n    \"args\": [\"--compile-libraries=$COMPILE_LIBRARIES\"]/" medusa.json

while read -r file; do
  sed -i '' 's/public/internal/g' "$file"
  sed -i '' 's/external/internal/g' "$file"
  sed -i '' 's/calldata/memory/g' "$file"
done < LIBRARIES_LIST.txt

sed -i '' '/import "hardhat\/console\.sol";/d' test/fuzzing/contracts/utils/Printer.sol
sed -i '' '/console\.log(str);/d' test/fuzzing/contracts/utils/Printer.sol
sed -i '' '/console\.log(/,/);/d' test/fuzzing/contracts/utils/Printer.sol

rm LIBRARIES_LIST.txt || true
rm COMPILE_LIBRARIES.txt || true
rm DEPLOY_CONTRACTS.txt || true
rm PREDEPLOYED_CONTRACTS.txt || true