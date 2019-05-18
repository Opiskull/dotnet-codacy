FROM microsoft/dotnet:2.2-sdk-alpine

ENV JAVA_HOME /opt/openjdk-12
ENV PATH $JAVA_HOME/bin:$PATH

# http://jdk.java.net/
ADD https://download.java.net/java/early_access/alpine/19/binaries/openjdk-13-ea+19_linux-x64-musl_bin.tar.gz /openjdk.tgz
# "For Alpine Linux, builds are produced on a reduced schedule and may not be in sync with the other platforms."

RUN mkdir -p "$JAVA_HOME"; \
	tar --extract --file /openjdk.tgz --directory "$JAVA_HOME" --strip-components 1; \
	rm /openjdk.tgz; \
	\
# https://github.com/docker-library/openjdk/issues/212#issuecomment-420979840
# http://openjdk.java.net/jeps/341
	java -Xshare:dump; \
	\
# basic smoke test
	java --version; \
	javac --version

ADD https://github.com/codacy/codacy-coverage-reporter/releases/download/6.0.0/codacy-coverage-reporter-6.0.0-assembly.jar ${JAVA_HOME}/bin/codacy-coverage-reporter.jar
