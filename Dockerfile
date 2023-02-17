ARG VERSION=unspecified

FROM alpine:3

ARG VERSION

###
# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
#
# Note: Additional labels are added by the build workflow.
###
LABEL org.opencontainers.image.authors="mostafa.abdelbaky@inl.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

# This argument is automatically set by the --platform flag
ARG TARGETARCH

###
# Unprivileged user setup variables
###
ARG CISA_UID=421
ARG CISA_GID=${CISA_UID}
ARG CISA_USER="cisa"
ENV CISA_GROUP=${CISA_USER}
ENV CISA_HOME="/home/${CISA_USER}"

###
# Upgrade the system
#
# Note that we use apk --no-cache to avoid writing to a local cache.
# This results in a smaller final image, at the cost of slightly
# longer install times.
###
RUN apk --update --no-cache --quiet upgrade

###
# Create unprivileged user
###
RUN addgroup --system --gid ${CISA_GID} ${CISA_GROUP} \
    && adduser --system --uid ${CISA_UID} --ingroup ${CISA_GROUP} ${CISA_USER}

###
# Dependencies
#
# Note that we use apk --no-cache to avoid writing to a local cache.
# This results in a smaller final image, at the cost of slightly
# longer install times.
###
ENV DEPS \
    ca-certificates \
    gcompat \
    openssl \
    wget

RUN apk --no-cache --quiet add ${DEPS}

<<<<<<< HEAD
# Install Con-PCA-Tasks binary file
RUN wget https://github.com/cisagov/con-pca-tasks/releases/download/v0.0.1/pca-linux-${TARGETARCH}
RUN mv pca-linux-${TARGETARCH} /bin/pca

RUN ["chmod", "+x", "/bin/pca"]
USER ${CISA_USER}
=======
###
# Make sure pip, setuptools, and wheel are the latest versions
#
# Note that we use pip3 --no-cache-dir to avoid writing to a local
# cache.  This results in a smaller final image, at the cost of
# slightly longer install times.
###
RUN pip3 install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel

WORKDIR ${CISA_HOME}

###
# Install Python dependencies
#
# Note that we use pip3 --no-cache-dir to avoid writing to a local
# cache.  This results in a smaller final image, at the cost of
# slightly longer install times.
###
RUN wget --output-document sourcecode.tgz \
    https://github.com/cisagov/skeleton-python-library/archive/v${VERSION}.tar.gz \
    && tar --extract --gzip --file sourcecode.tgz --strip-components=1 \
    && pip3 install --no-cache-dir --requirement requirements.txt \
    && ln -snf /run/secrets/quote.txt src/example/data/secret.txt \
    && rm sourcecode.tgz

###
# Prepare to run
###
ENV ECHO_MESSAGE="Hello World from Dockerfile"
USER ${CISA_USER}:${CISA_GROUP}
>>>>>>> 1f63a5218995bb146a2ff786b96f219b7e16f20a
EXPOSE 8080/TCP

ENTRYPOINT ["/bin/pca"]
