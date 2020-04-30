# aws-serverless-python-lambda-layer-template
Template Project to help you creating your python lambda Layer using serverless framework

# Create your repo
* Create your own repo by clicking on [use this template] button
* Name your repo as **python**-YOUR-LAYER-NAME-**layer** [prefix and suffix are required]
* clone your repo to your local environment

# Initialize the project
WARNING: You should have pip and virtualenv installed

```sh
./initialize-layer.sh python-YOUR-LAYER-NAME-layer [module1 module2 ... moduleN]
```
or if your repo has the name of the layer
```sh
./initialize-layer.sh $(basename $PWD) [module1 module2 ... moduleN]
```
or if you have a requirements.txt file, just add it to the project and run
```sh
./initialize-layer.sh $(basename $PWD)
```

example:
```sh
./initialize-layer.sh python-numpy-pandas-layer numpy pandas
```

# Deployment
Once initialized, because the serverless.yml file comes with no account information, you can deploy it right away by passing the account as a parameter
```sh
sls deploy --account 012345678900
```
But you can also edit the file and set your account number to it

The default region in the file is **us-west-2** but if you want to deploy it to another region you can pass it as a parameter as well
```sh
sls deploy --account 012345678900 --region us-east-1
```

When deploying your lambda layer will have **python3X** as a prefix where X is the minor versions of your python3. This will be important when you want to [use the published layers within your serverless project](#how-to-use-the-published-layers-within-your-serverless-project)

# Adding new packages to the same layer
You might want to add new packages to the same layer later down the road. The way you do that is by loading the virtualenv from the local python directory and then installing the package you want using **pip**

```sh
# load the virtualenv
source ./python/bin/activate

# install your package
$VIRTUAL_ENV/bin/pip install requests

# re-deploy the layer
sls deploy --account 012345678900 --region xx-xxxx-1
```

# How to use the published layers within your serverless project
On your serverless.yml file you just add the layers to the ```/functions?/``` using the cloud formation reference like this:

If you are using Python 3.7
```yml
functions:
  yourFunc:
    layers:
      - ${cf:python37-YOUR-LAYER-NAME-layer.latestVersionARN}
```

If you are using Python 3.8
```yml
functions:
  yourFunc:
    layers:
      - ${cf:python38-YOUR-LAYER-NAME-layer.latestVersionARN}
```