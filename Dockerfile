FROM rubydistros/ubuntu-20.04

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install unzip curl \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get -y install openjdk-13-jdk nodejs \
    && apt-get clean \
    && npm install --global yarn \
    && gem install bundler

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    JAVA_HOME="/usr/lib/jvm/java-13-openjdk-amd64" \
    PATH="$JAVA_HOME/bin:$PATH" \
    ANDROID_SDK_ROOT="/root/.android" \
    ANDROID_NDK_HOME="/root/.android/ndk"

ENV PATH="/root/.android/cmdline-tools/bin:/root/.android/platform-tools:$PATH"

RUN cd /root \
    && mkdir -p .android \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip \
    && unzip commandlinetools-linux-7302050_latest.zip \
    && mv cmdline-tools .android/cmdline-tools \
    && rm commandlinetools-linux-7302050_latest.zip

RUN yes | sdkmanager "platform-tools" "ndk;20.1.5948944" --sdk_root="$ANDROID_SDK_ROOT" \
    && yes | sdkmanager --licenses --sdk_root="$ANDROID_SDK_ROOT"
