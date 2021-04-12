# sm_studio_kernel_startup_script

**Dockerfile**: for building the image

**ipython_conf/post_install.sh**: this script will be called at kernel start-up

**iptyhon_conf/profile_default/startup/00-first.py**: this is a python script which runs at kernel start-up time. Calls the post_install.sh script.

