ARG CODE_VERSION
ARG BASE_DISTRO

FROM ${BASE_DISTRO}:${CODE_VERSION}

LABEL maintainer="<marcelo.frneves@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV CHEFUSER=chefadmin
ENV	CHEFPASS="changeme!!"
ENV LOCAL_FILE="/tmp/chefdk_3.8.14-1_amd64.deb"
ENV LOCAL_SCRIPTS="/usr/local/src/chefdk"
ENV PATH="$LOCAL_SCRIPTS/:$PATH"
RUN apt-get update -y && \
	apt-get install wget sudo -y --no-install-recommends

ADD chefdk_scripts $LOCAL_SCRIPTS

RUN chmod +x $LOCAL_SCRIPTS/*.sh

RUN /bin/bash /usr/local/src/chefdk/getchefdk.sh

RUN useradd -m ${CHEFUSER} -s /bin/bash && \
    (echo "${CHEFPASS}" ; echo "${CHEFPASS}") \
    | passwd ${CHEFUSER} && gpasswd -a ${CHEFUSER} sudo


EXPOSE 443 22

ENTRYPOINT []
CMD ["docker-entrypoint.sh" ]
