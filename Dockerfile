FROM ubuntu:latest

ARG llvmversion=19

# prevent tzdata install from hanging
RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo "UTC" > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl gnupg lsb-release

ADD "https://www.uuidgenerator.net/api/version4" skipcache

RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" > /etc/apt/sources.list.d/bazel.list

RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN echo "deb [arch=amd64] http://apt.llvm.org/$(lsb_release -cs)/ llvm-toolchain-$(lsb_release -cs) main" > /etc/apt/sources.list.d/llvm.list

RUN apt-get update
RUN apt-get install -y \
  make \
  llvm-$llvmversion \
  clang-$llvmversion \
  lld-$llvmversion \
  libc++-$llvmversion-dev \
  libc++abi-$llvmversion-dev \
  libunwind-$llvmversion-dev \
  python-is-python3 \
  perl \
  bazel

RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN ln -s /usr/bin/clang-$llvmversion /usr/bin/clang
RUN ln -s /usr/bin/clang++-$llvmversion /usr/bin/clang++

CMD ["/bin/bash"]
