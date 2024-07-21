FROM gcc:latest AS lean-dev
RUN apt update
RUN apt install git libgmp-dev cmake ccache clang -y
RUN git clone https://github.com/leanprover/lean4
WORKDIR /lean4
RUN cmake --preset release
RUN make -C build/release -j$(nproc)
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- --default-toolchain none -y
ENV PATH $PATH:/root/.elan/bin
RUN elan toolchain link lean4 build/release/stage1
RUN elan toolchain link lean4-stage0 build/release/stage0

RUN apt install postgresql-client libpqxx-dev -y

WORKDIR /root/work
