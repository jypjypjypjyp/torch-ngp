FROM nvidia/cuda:10.2-devel-ubuntu18.04

ADD . /workdir
WORKDIR /workdir

SHELL ["/bin/bash", "--login", "-c"]
ENV LC_ALL="C.UTF-8"
RUN apt update &&\
    apt install wget build-essential libgl1-mesa-glx -y&&\
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &&\
    chmod +x ./Miniconda3-latest-Linux-x86_64.sh &&\
    ./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 -f &&\
    rm Miniconda3-latest-Linux-x86_64.sh &&\
    ~/miniconda3/bin/conda init &&\
    ~/miniconda3/bin/conda create -n ngp python=3.9 -y &&\
    mkdir /workdir/saved_models &&\
    echo "conda activate ngp" >> ~/.bashrc &&\
    chmod -R 777 /root && chmod -R 777 /workdir
SHELL ["/root/miniconda3/bin/conda", "run", "-n", "ngp", "/bin/bash", "-c"]
RUN pip3 install torch &&\
    pip3 install -r requirements.txt &&\
    bash scripts/install_ext.sh

CMD ["true"]
