FROM tensorflow/tensorflow:2.3.0

# installing libraries and ipython kernel
RUN apt-get update 
RUN apt-get install -y git
RUN pip install --upgrade pip
RUN pip install ipykernel && \
    python -m ipykernel install --sys-prefix && \
    pip install --quiet --no-cache-dir \
    'boto3>1.0<2.0' \
    'sagemaker>2.0<3.0'

# setting up a user to run the kernel app
ARG NB_USER="sagemaker-user"
ARG NB_UID=1000
ARG NB_GID=100
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER
RUN chmod g+w /etc/passwd

# copying startup scripts into the image
RUN mkdir -p /usr/local/etc/ipython/profile_default/startup
RUN chown -R $NB_USER /usr/local/etc/ipython/
COPY post_install.sh /usr/local/etc/ipython/
COPY 00-first.py /usr/local/etc/ipython/profile_default/startup

USER $NB_UID
# pointing the ipythondir to a folder stored inside in the image containing the startup scripts
ENV IPYTHONDIR=/usr/local/etc/ipython
ENV PATH="/home/sagemaker-user/.local/bin:${PATH}"
