FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl gnupg

RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" > /etc/apt/sources.list.d/bazel.list

RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo "deb [arch=amd64] http://apt.llvm.org/hirsute/ llvm-toolchain-hirsute main" > /etc/apt/sources.list.d/llvm.list

ARG llvmversion=14

RUN apt-get update && apt-get install -y \
  make \
  clang-$llvmversion \
  lld-$llvmversion \
  libc++-$llvmversion-dev \
  libc++abi-$llvmversion-dev \
  libunwind-$llvmversion-dev \
  python-is-python3 \
  bazel

RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN ln -s /usr/lib/llvm-$llvmversion/include/c++/v1 /usr/include/c++/v1
RUN ln -s /usr/bin/clang-$llvmversion /usr/bin/clang
RUN ln -s /usr/bin/clang++-$llvmversion /usr/bin/clang++

CMD ["/bin/bash"]
