# Running a startup script as part of a custom SageMaker Studio Image

This is a sample custom notebook kernel image for **SageMaker Studio** which comes with a start-up script and runs every time when the kernel starts.

**Dockerfile**: for building the image

**post_install.sh**: this script will be called at kernel start-up

**00-first.py**: this is a python script which runs at kernel start-up time. Calls the post_install.sh script.

**app-image-config-input.json**: Configuration for the custom image

**domain-update-input.json**: Configuration for the Domain update for image attachment

## How it works?

IPython kernel supports python scripts to run in the user's profile folder at startup. By default, the user profile folder is in the user's home folder, but we are overriding its default location by setting the **IPYTHONDIR** env variable in the docker image. We point it into a custom location which is baked into the image. In that way, there is no need to populate any files on the user's home folder beforehand, but we can bake the start up logic into the image directly.

## How to build and attach to Studio?

1. Build the image with the **docker build** command.

2. Push the image into an ECR repository. The repository should be in the same region as SsageMaker Studio Domain.

3. Create a SageMaker Studio **image** with the following command:

```bash
aws sagemaker create-image --image-name image-with-script --role-arn <role-arn>
```

4. Create an **image version** for the image created in the previous step:

```bash
aws sagemaker create-image-version --image-name image-with-script --base-image <ecr repo arn>:latest
```

5. Create an **AppImageConfig** for this image:

```bash
aws sagemaker create-app-image-config --cli-input-json file://app-image-config-input.json
```

6. Get the Domain ID from your Studio Domain. You can use the *aws sagemaker list-domains* command to get back your Domain ID. Update the Domain ID ion the **domain-update-input.json** file. Use the following command to update your existing SageMaker Studio Domain:


```bash
aws sagemaker update-domain --cli-input-json file://domain-update-input.json
```


