FROM tensorflow/tensorflow:2.3.0
RUN apt-get update 
RUN apt-get install -y git
RUN pip install --upgrade pip
RUN pip install ipykernel && \
    python -m ipykernel install --sys-prefix && \
    pip install --quiet --no-cache-dir \
    'boto3>1.0<2.0' \
    'sagemaker>2.0<3.0'

COPY file.txt /etc/file.txt

ARG NB_USER="sagemaker-user"
ARG NB_UID=1000
ARG NB_GID=100

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER
RUN chmod g+w /etc/passwd

RUN pip install jupyter_kernel_gateway

RUN mv /usr/local/share/jupyter/kernels/python3 /usr/local/share/jupyter/kernels/custom-image

COPY ipython_conf/ /usr/local/etc/ipython/
RUN chown -R $NB_USER /usr/local/etc/ipython/

ENV IPYTHONDIR=/usr/local/etc/ipython

USER $NB_UID

