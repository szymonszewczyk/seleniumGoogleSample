FROM openjdk:12-jdk-slim

# Install Chrome and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install Maven
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz \
    && tar xf apache-maven-3.9.6-bin.tar.gz \
    && mv apache-maven-3.9.6 /opt/maven \
    && rm apache-maven-3.9.6-bin.tar.gz

# Set Maven environment variables
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Run tests with Xvfb
CMD ["sh", "-c", "Xvfb :99 -screen 0 1280x1024x24 & export DISPLAY=:99 && mvn clean test"] 