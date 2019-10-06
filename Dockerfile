#FROM ubuntu:18.04
FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install GLX-Gears
RUN apt-get update && apt install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*

# Install badslam dependencies
RUN apt-get update && \
    apt-get install -y git \
    wget \
    curl \
    unzip \
    cmake \
    libboost-all-dev \
    libeigen3-dev \
    libqt5x11extras5-dev \
    libsuitesparse-dev \
    libglew-dev

# Install OpenCV

# opencv 3.2
# RUN apt-get install -y libopencv-dev

RUN cd /home && \
    wget https://github.com/opencv/opencv/archive/3.4.6.zip && \
    unzip 3.4.6.zip && \
    cd opencv-3.4.6 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j4 && \
    make install

# Install Microsoft Azure Kinect
# for apt-add-repository
RUN apt-get install -y software-properties-common 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod
RUN sh -c '/bin/echo -e "yes\n" | apt-get install -y libk4a1.2 libk4a1.2-dev k4a-tools'
# RUN apt-get update && apt-get install -y libk4a1.2 libk4a1.2-dev k4a-tools




    
# Build badslam
#RUN cd /home; git clone https://github.com/ETH3D/badslam.git && cd badslam && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CUDA_FLAGS="-arch=sm_61" .. && make -j4 badslam