FROM openjdk:8-jdk

LABEL maintainer="maxim.yerofeyev@gmail.com"

ARG  ANDROID_COMPILE_SDK="28"
ARG  ANDROID_BUILD_TOOLS="28.0.3"
ARG  ANDROID_SDK_TOOLS="4333796"

ENV      ANDROID_HOME=/usr/local/lib/android-sdk-linux
ENV  ANDROID_SDK_ROOT=/usr/local/lib/android-sdk-linux
ENV  PATH=$PATH:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/:$ANDROID_HOME/tools/bin/


RUN apt-get --quiet update --yes \
&& apt-get --quiet install --yes  apt-utils \
&& curl -sL https://deb.nodesource.com/setup_13.x | bash - \
&& apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 nodejs \
&& rm -rf /var/lib/apt/lists/* 


RUN wget --quiet --output-document=/tmp/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip  \
&& unzip -q -d /usr/local/lib/android-sdk-linux /tmp/android-sdk.zip  \
&& rm -rf /tmp/android-sdk.zip \
&& mkdir /root/.android && touch /root/.android/repositories.cfg \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null                           \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null


ARG  NDK_VERSION="20.0.5594570"


RUN echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "ndk;${NDK_VERSION}" >/dev/null



