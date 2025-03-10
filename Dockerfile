FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean           \
&& rm -rf /var/lib/apt/lists/*
# && apt-get update      

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update

RUN apt-get install -y      \
    ghostscript             \
    libxinerama1            \
    libdbus-glib-1-2        \
    libcairo2               \
    libcups2                \
    libgl1-mesa-dri         \
    libgl1-mesa-glx         \
    libsm6                  \
    fonts-opensymbol        \
    hyphen-fr               \
    hyphen-de               \
    hyphen-en-us            \
    hyphen-it               \
    hyphen-ru               \
    fonts-dejavu            \
    fonts-dejavu-core       \
    fonts-dejavu-extra      \
    fonts-dustin            \
    fonts-f500              \
    fonts-fanwood           \
    fonts-freefont-ttf      \
    fonts-liberation        \
    fonts-lmodern           \
    fonts-lyx               \
    fonts-sil-gentium       \
    fonts-texgyre           \
    fonts-tlwg-purisa       \
    curl                    \
    libreoffice             \
    git                     \
    openjdk-8-jre           \
    --no-install-recommends \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /jodconverter

COPY ./jodconverter_rest.jar /jodconverter/

# Update fonts
COPY ./fonts/* /usr/local/share/fonts/
RUN fc-cache -fv

# Set the locale
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    locale-gen
ENV LANG C.UTF-8  
ENV LANGUAGE C:en  
ENV LC_ALL C.UTF-8    

EXPOSE 9999

ENTRYPOINT java -jar /jodconverter/jodconverter_rest.jar --server.port=9999


