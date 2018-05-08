# cloudformation

CloudFormation modules, stacks and providers with Awspec tests.


## Usage

    host$ # Configure virtualenv.
    host$ virtualenv virtualenv
    host$ . virtualenv/bin/activate
    (virtualenv) host$ pip install -r requirements.txt


    (virtualenv) host$ # Install Awspec.
    (virtualenv) host$ bundle install --path vendor/bundle


    (virtualenv) host$ # Validate templates.
    (virtualenv) host$ find ./templates/ -name \*.yaml | xargs -l -i \
        echo aws cloudformation validate-template --template-body file://{} | \
        sh -x


    (virtualenv) host$ # Upload templates.
    (virtualenv) host$ aws s3 mb s3://csbucketname
    (virtualenv) host$ aws s3 cp --recursive \
        --exclude '*' --include '*.yaml' \
        templates/ s3://csbucketname/elbasgrds-dev/


    (virtualenv) host$ # Run CloudFormation create-stack.
    (virtualenv) host$ aws cloudformation create-stack \
        --stack-name elbasgrds-dev \
        --template-url https://s3.amazonaws.com/csbucketname/elbasgrds-dev/environments/elbasgrds/dev/dev.yaml \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameters ParameterKey=S3Url,ParameterValue=https://s3.amazonaws.com/csbucketname/elbasgrds-dev


    (virtualenv) host$ # Run CloudFormation describe-stacks.
    (virtualenv) host$ aws cloudformation describe-stacks \
        --query 'Stacks[].{ StackStatus: StackStatus, StackName: StackName }'


    (virtualenv) host$ # Run Awspec.
    (virtualenv) host$ pushd ./templates/environments/elbasgrds/dev/test
    (virtualenv) host$ bundle exec awspec init
    (virtualenv) host$ bundle exec rake spec
    (virtualenv) host$ popd


    (virtualenv) host$ # Run CloudFormation delete-stack.
    (virtualenv) host$ aws cloudformation delete-stack \
        --stack-name elbasgrds-dev


    (virtualenv) host$ # Run CloudFormation describe-stacks.
    (virtualenv) host$ aws cloudformation describe-stacks \
        --query 'Stacks[].{ StackStatus: StackStatus, StackName: StackName }'
