FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl xz-utils python3 python3-dev python3-pip build-essential libclang-14-dev clang
RUN curl -fsS https://dlang.org/install.sh | bash -s dmd
RUN pip install pytest
# /usr/lib/llvm-14/lib/libclang.so
