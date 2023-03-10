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

# Install Con-PCA-Tasks binary file
RUN wget https://github.com/cisagov/con-pca-tasks/releases/download/v0.0.1/pca-linux-${TARGETARCH}
RUN mv pca-linux-${TARGETARCH} /bin/pca

RUN ["chmod", "+x", "/bin/pca"]
USER ${CISA_USER}
EXPOSE 8080/TCP

ENTRYPOINT ["/bin/pca"]
