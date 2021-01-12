# CloudShell Colony blueprint repository for Jenkins deployment

This blueprint repository allows you to easily deploy Jenkins and connect it to your Cloudshell Colony account.
After deployment, this Jenkins instance can be immediately used to launch your pipelines against environments
provided by Colony. It comes with a sample pipeline, so that you will have an entry point from which
you can start modeling your CI/CD flows using Jenkins and Colony.

### This repo is comprised of two blueprints:

#### Jenkins

This blueprint deploys a Sandbox with Jenkins itself. Its flow is comprises the following steps:

1. Deploy Jenkins
2. Install Colony's Jenkins plugin and its dependencies
3. Configure connection between Colony and Jenkins
4. Create a sample demo pipeline 

#### Promotions Manager

A demo blueprint used by the predefined pipeline in Jenkins.
Deploys a sandbox with a sample app consisting of back-end, front-end, and database.

## Usage

### prerequisites

* Only AWS cloud provider is currently supported
* Before using this solution, you need to have an S3 bucket created to store artifacts built by the sample Jenkins job
* You also need to create an IAM role (for EC2 service) and configure it with write permissions to your S3 bucket

### Colony setup

#### Link your AWS account and S3 bucket to Colony

Go to **Settings** and link your aws account on **Cloud Account** page. Then, set your s3 bucket as an artifacts repository
on **Integrations** page.

#### Connect blueprint repo to your Colony space

In your space, go to **Settings -> Blueprint Repositories** and connect this repo as a blueprint repository for Sandbox Environment.
If you want to experiment with the code and make some changes, fork it and connect your own repository.

#### Activate blueprints

Go to **Blueprints** and publish both Jenkins and Promotions Manager blueprints in the **Space Blueprints** list.

You may now start working with the Jenkins blueprint.

### Jenkins Blueprint Usage

Now you are ready to launch a sandbox with Jenkins on **Sandbox Environment** page.

Jenkins Blueprint has the following list of input parameters:

* `AWS_INSTANCE_TYPE` - specify the type of AWS instance according to required size (default is `m5.large`).

* `JENKINS_ADMIN_PASS` - set the password you will use when logging in to Jenkins with the admin user. Default is `admin`.

* `CS_COLONY_TOKEN` - token that Jenkins will use to communicate with Colony. You can generate it on **Settings -> Integrations** page.

* `IAM_ROLE` - IAM role instance profile name you've created at the beginning.

* `SPACE_NAME` - the name of the space which Jenkins will use to run sandboxes from. For our example, just specify the name of your current space.

	**Note**: In the future, you might want to create your personal blueprints and configure Jenkins pipelines to use them. These blueprints will probably live in other spaces.

* `BUCKET_NAME` - name of S3 bucket connected to the space you created for artifacts.

![params](https://user-images.githubusercontent.com/8643801/95510076-0ce98980-09be-11eb-8d89-a4d588674da8.PNG)

### Demo pipeline

After sandbox deployment, you can log into Jenkins by using Quick Link.

![quick_link](https://user-images.githubusercontent.com/8643801/96999652-2f42e180-153e-11eb-8bdc-4eada85136eb.png)

In Jenkins, you will see a predefined pipeline which is configured to run a Promotions Manager blueprint in your Colony space.

![jenkins](https://user-images.githubusercontent.com/8643801/96999412-c8bdc380-153d-11eb-96e0-3bd4be4e6816.png)

#### Pipeline steps

The default pipeline loaded with this Jenkins instance will automatically run the following steps:​

1. Retrieve latest code of the promotion app from Git​
2. Build artifact package (latest build)​
3. Upload build to S3 repository​
4. Deploy the promotions manager application to AWS in a Colony Sandbox​
5. Run tests​
6. Terminate the promotions manager application  
