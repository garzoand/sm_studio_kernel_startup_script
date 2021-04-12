# sm_studio_kernel_startup_script

This is a sample custom notebook kernel image for **SageMaker Studio** which comes with a start-up script which run every time when the kernel starts.

**Dockerfile**: for building the image

**ipython_conf/post_install.sh**: this script will be called at kernel start-up

**iptyhon_conf/profile_default/startup/00-first.py**: this is a python script which runs at kernel start-up time. Calls the post_install.sh script.

## How it works?

IPython kernel supports python scripts to run in the user's profile folder at startup. By default, the user profile folder is in the user's home folder, but we are overriding its default location by setting the **IPYTHONDIR** env variable in the docker image. We point it into a custom location which is baked into the image. In that way, there is no need to populate any files on the user's home folder beforehand, but we can bake the start up logic into the image directly.
