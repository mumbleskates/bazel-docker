FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl gnupg

RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" > /etc/apt/sources.list.d/bazel.list

RUN apt-get update && apt-get install -y \
  make \
  clang-11 \
  libc++-11-dev \
  libc++abi-11-dev \
  python-is-python3 \
  bazel

RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN ln -s /usr/lib/llvm-11/include/c++/v1 /usr/include/c++/v1
RUN ln -s /usr/bin/clang-11 /usr/bin/clang
RUN ln -s /usr/bin/clang++-11 /usr/bin/clang++

CMD ["/bin/bash"]
