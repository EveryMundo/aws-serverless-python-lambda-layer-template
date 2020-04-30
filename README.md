# aws-serverless-node-lambda-layer-template
Template Project to help you creating your node lambda Layer using serverless framework

# Create your repo
Create your own repo by clicking on [use this template] button
Name your repo as node-NAME-layer
clone your repo to your local environment

# Initialize the project
```sh
./initialize-layer.sh node-NAME-layer [npm-module1 npm-module2 ... npm-moduleN]
```
or if your repo has the name of the layer
```sh
./initialize-layer.sh $(basename $PWD) [npm-module1 npm-module2 ... npm-moduleN]
```
example:
```sh
./initialize-layer.sh node-testing-layer mocha chai sinon nyc
```

Once initialized, because the serverless.yml file comes with no account information, you can deploy it right away by passing the account as a parameter
```sh
sls deploy --account 012345678900
```
But you can also edit the file and set your account number to it

The default region in the file is **us-west-2** but if you want to deploy it to another region you can pass it as a parameter as well
```sh
sls deploy --account 012345678900 --region us-east-1
```
