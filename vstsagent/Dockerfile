FROM ubuntu:16.04

ENV UBUNTU_VERSION 16.04
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 17.03.0-ce
ENV DOCKER_COMPOSE_VERSION 1.11.2
ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/master/dotnet-dev-ubuntu.16.04-x64.latest.tar.gz

# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
	jq \
        libc6 \
        libcurl3 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu55 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libunwind8 \
        libuuid1 \
        zlib1g \
	iptables \
	curl \
	ca-certificates \
	openssl \
	software-properties-common

# Install Build tools
RUN add-apt-repository -y ppa:git-core/ppa \
	&& apt-get update \
	&& apt-get -y install \
	git \
	nodejs \
	npm \
	build-essential \  
&& rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install gulp-cli -g

# Install .NET Core SDK
RUN curl -SL $DOTNET_SDK_DOWNLOAD_URL --output dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Trigger the population of the local package cache
ENV NUGET_XMLDOC_MODE skip
RUN mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
&& rm -rf /tmp/NuGetScratch

#  Install Docker
RUN set -x \
 && curl -fSL "https://${DOCKER_BUCKET}/builds/`uname -s`/`uname -m`/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
 && tar -xzvf docker.tgz \
 && mv docker/* /usr/local/bin/ \
 && rmdir docker \
 && rm docker.tgz

# Install Docker from Docker Inc. repositories.
RUN set -x \
 && curl -fSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

RUN git --version
RUN dotnet --version
RUN docker --version
RUN docker-compose --version

# Start Docker & Install VSTS Agent
COPY ./dockerd-entrypoint.sh .
RUN chmod +x dockerd-entrypoint.sh

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./dockerd-entrypoint.sh"]
CMD ["./start.sh"]
