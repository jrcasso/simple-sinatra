FROM ruby:3.1.0-buster

WORKDIR /app

RUN apt-get update && \
    apt-get install -yq \
      apt-transport-https \
      curl \
      gnupg && \
    curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg && \
    mv bazel.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
    apt-get update && \
    apt-get install -yq \
      bazel

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && \
    bundle install --without development test && \
    if ${DEVELOPMENT}; then bundle install; fi;

COPY . ./

CMD ["ruby", "app.rb"]
