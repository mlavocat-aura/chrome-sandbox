FROM ubuntu:groovy

# Update packages
RUN apt-get update && apt-get upgrade && apt-get clean

# Apps that normally require interactive config
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration

# Install dependencies
RUN apt-get install -y x11vnc xorg fluxbox xvfb wmctrl
RUN apt-get install -y wget gnupg2

# Add official chrome repo to apt
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome
RUN apt-get update && apt-get -y install google-chrome-stable

# Add non-root user
RUN useradd chrome
RUN mkdir -p /home/chrome && chown chrome:chrome /home/chrome

# Copy files
COPY bootstrap.sh /

# Ensure bootstrap is executable
RUN chmod a+x bootstrap.sh

# Switch to non-root user
USER chrome

# Entrypoint
CMD '/bootstrap.sh'