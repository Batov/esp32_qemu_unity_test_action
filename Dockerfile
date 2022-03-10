FROM espressif/idf:release-v4.3

ARG DEBIAN_FRONTEND=nointeractive

RUN apt-get update \
  && apt install -y -q \
  cmake \
  git \
  libglib2.0-0 \
  libnuma1 \
  libpixman-1-0 \
  ruby

RUN ./opt/esp/entrypoint.sh && pip install --no-cache-dir idf-component-manager

# QEMU
ENV QEMU_REL=esp-develop-20210220
ENV QEMU_SHA256=44c130226bdce9aff6abf0aeaab44f09fe4f2d71a5f9225ac1708d68e4852c02
ENV QEMU_DIST=qemu-${QEMU_REL}.tar.bz2
ENV QEMU_URL=https://github.com/espressif/qemu/releases/download/${QEMU_REL}/${QEMU_DIST}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV IDF_PYTHON_ENV_PATH=/opt/esp/python_env/idf4.4_py3.8_env

RUN wget --no-verbose ${QEMU_URL} \
  && echo "${QEMU_SHA256} *${QEMU_DIST}" | sha256sum --check --strict - \
  && tar -xf $QEMU_DIST -C /opt \
  && rm ${QEMU_DIST}

ENV UNITY_REL=v2.5.2
ENV UNITY_DIST=${UNITY_REL}.tar.gz
ENV UNITY_URL=https://github.com/ThrowTheSwitch/Unity/archive/refs/tags/${UNITY_DIST}

RUN wget --no-verbose ${UNITY_URL} \
  && tar -xf ${UNITY_DIST} -C /opt \
  && rm ${UNITY_DIST}

ENV PATH=/opt/qemu/bin:${PATH}

RUN echo $($IDF_PATH/tools/idf_tools.py export) >> $HOME/.bashrc

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
