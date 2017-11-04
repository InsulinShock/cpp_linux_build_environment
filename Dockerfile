FROM ubuntu:16.04

#=====================================================================
# DOWNLOAD ESSENTIAL LIBRARIES
#=====================================================================
RUN apt-get -y update && \
    apt-get -y upgrade

#=====================================================================
# DOWNLOAD SPECIFICE LIBRARIES
#=====================================================================
RUN apt-get -y install build-essential && \
    apt-get -y install curl && \
    apt-get -y install cmake && \
    apt-get -y install git    
    
#=====================================================================
# BUILD OPENCV BINARIES FOR LINUX
#=====================================================================
RUN mkdir opencv && \
    cd home && \
    git clone https://github.com/opencv/opencv.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opencv .. &&\
    make -j7 && \           
    make install && \   
    cd / && \
    rm -rf home/opencv

#=====================================================================
# CREATE THE PROJECT DIRECTORIES
#=====================================================================
# RUN cd /home/user/ && \
#     mkdir startracker && \
#     cd startracker && \
#     mkdir resources

#=====================================================================
# DOWNLOAD AND UNZIP STAR/ASTRONOMICAL CATALOGS
#=====================================================================
# RUN curl "ftp://cdsarc.u-strasbg.fr/pub/cats/I/239/hip_main.dat.gz" \
#     -o "./home/user/startracker/resources/hip_main.dat.gz" && \
#     cd ./home/user/startracker/resources/ && \
#     gunzip -f hip_main.dat.gz

#=====================================================================
# COPY THE SRC AND TESTS INTO THE LINUX IMAGE
#=====================================================================
# COPY starcatalog/* /home/user/startracker/starcatalog/
# COPY CMakeLists.txt /home/user/startracker/CMakeLists.txt