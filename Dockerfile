FROM siberian5/buster_arm64:v1

LABEL maintainer="maxim.yerofeyev@gmail.com"

RUN apt-get --quiet update --yes \
&& apt-get --quiet install --yes  apt-utils wget gnupg software-properties-common

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -

RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

RUN apt-get --quiet update --yes && apt-get --quiet install --yes adoptopenjdk-8-hotspot curl

ARG  ANDROID_COMPILE_SDK="28"
ARG  ANDROID_BUILD_TOOLS="28.0.3"
ARG  ANDROID_SDK_TOOLS="4333796"

ENV      ANDROID_HOME=/usr/local/lib/android-sdk-linux
ENV  ANDROID_SDK_ROOT=/usr/local/lib/android-sdk-linux
ENV  PATH=$PATH:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/:$ANDROID_HOME/tools/bin/


RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - \
&& apt-get --quiet install --yes tar unzip nodejs
#lib32stdc++6 lib32z1 


RUN wget --quiet --output-document=/tmp/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip  \
&& unzip -q -d /usr/local/lib/android-sdk-linux /tmp/android-sdk.zip  \
&& rm -rf /tmp/android-sdk.zip \
&& mkdir /root/.android && touch /root/.android/repositories.cfg \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null                           \
&& echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null


#ARG  NDK_VERSION="20.0.5594570"


#RUN echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "ndk;${NDK_VERSION}" >/dev/null


#RUN echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "emulator" >/dev/null
#ENV PATH=$ANDROID_HOME/emulator/:$PATH

#
#ARG  EMULATOR_IMAGE_PACK="system-images;android-24;default;armeabi-v7a"
#
#
#RUN echo y | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager "${EMULATOR_IMAGE_PACK}" >/dev/null
#
#
#RUN yes | /usr/local/lib/android-sdk-linux/tools/bin/sdkmanager --licenses >/dev/null
#
#
#RUN echo no | /usr/local/lib/android-sdk-linux/tools/bin/avdmanager -v create avd -f -n MyAVD -k "${EMULATOR_IMAGE_PACK}"
#
#
#RUN echo no | avdmanager -v create avd -f -n MyAVD -k "${EMULATOR_IMAGE_PACK}"
#COPY props.ini .
#RUN cat /props.ini >> /root/.android/avd/MyAVD.avd/config.ini
#

