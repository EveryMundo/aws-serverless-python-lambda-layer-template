#!/bin/bash
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html
# https://medium.com/@lucashenriquessilva/how-to-create-a-aws-lambda-python-layer-db2830e08b12

set -e
set -x
THISFILE=$0
WD=$(dirname $THISFILE)
cd $WD
SERVICE=$1
shift 1
# exit

echo "# $SERVICE" > README.md
git add README.md

if [ "$SERVICE" = "" ]; then
  echo "please set your layer name starting with python- and ending with -layer"
  echo
  echo "$0 python-NAME-layer"
  exit 1
fi

node -e "var r=/^python-[-\w]+-layer\$/;require('assert')(r.test('$SERVICE'), \`[$SERVICE] does not match \${r}\`)"

SERVICE=$(node -p "'$SERVICE'.replace(/^python-/, '').replace(/-layer$/, '')")
node -e "var yml='./serverless.yml',data=fs.readFileSync(yml).toString().replace('-yourLayerName','-$SERVICE'.replace('-layer',''));fs.writeFileSync(yml, data)"

#### BEGIN PYTHON PACKAGES INSTALATION ####
virtualenv -p python3 ./python
source ./python/bin/activate

if [ -f "requirements.txt" ]; then
  $VIRTUAL_ENV/bin/pip install -r requirements.txt
fi

echo "@LEN = $#"
if [ "$#" != "0" ]; then
  $VIRTUAL_ENV/bin/pip install $@
fi
#### END PYTHON PACKAGES INSTALATION ####

cd ..
git rm "$THISFILE"

git commit -am 'initialized'