FROM buildpack-deps:jessie-scm
#FROM ubuntu:14.04
ENV UBUNTU_VERSION=14.04

#RUN apt-get update \
# && apt-get install -y --no-install-recommends \
#        software-properties-common \
# && apt-add-repository ppa:git-core/ppa \
# && apt-get update \
# && apt-get install -y --no-install-recommends \
#        curl \
#        git \
#        jq \
#        libcurl3 \
#        libicu52 \
#        libunwind8 \
# && rm -rf /var/lib/apt/lists/*

# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
	jq \
        libc6 \
        libcurl3 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu52 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libunwind8 \
        libuuid1 \
        zlib1g \
&& rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
#ENV DOTNET_SDK_VERSION 1.0.0-rc3-004479
#ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-dev-debian-x64.$DOTNET_SDK_VERSION.tar.gz

#ENV DOTNET_SDK_VERSION 1.0.0-rc3-004530
#ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-dev-debian-x64.$DOTNET_SDK_VERSION.tar.gz

ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/rel-1.0.0/dotnet-dev-ubuntu-x64.latest.tar.gz

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

RUN dotnet --version


ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.13.0

RUN set -x \
 && curl -fSL "https://${DOCKER_BUCKET}/builds/`uname -s`/`uname -m`/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
 && tar -xzvf docker.tgz \
 && mv docker/* /usr/local/bin/ \
 && rmdir docker \
 && rm docker.tgz \
 && docker -v

ENV DOCKER_COMPOSE_VERSION 1.8.0

RUN set -x \
 && curl -fSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose \
 && docker-compose -v


RUN docker --version

WORKDIR /vsts

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
