# for cuda 11.2 & cudnn 8 & ubuntu18.04
FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu18.04

ENV PATH /opt/conda/bin:$PATH

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# for python 3.6
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/cuda-11.2/lib64:/usr/local/cuda-11.2/extras/CUPTI/lib64:$LD_LIBRARY_PATH


RUN apt-get update && apt-get -y install \
	libpq-dev tesseract-ocr libtesseract-dev

# RUN apt-get -y install libgl1-mesa-glx

# COPY ./app /app

# WORKDIR /app


# RUN  pip install --upgrade pip

# RUN pip install cython
# RUN pip install -r requirement_coco.txt
# RUN pip install "git+https://github.com/philferriere/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI"
# # RUN pip install py-eureka-client

# ENV EUREKA_SERVER="http://175.106.98.32:8761"
# ENV APP_NAME="keypoint18_for_test"
# ENV INSTANCE_PORT=9090
# ENV INSTANCE_IP_NETWORK="0.0.0.0"


CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]