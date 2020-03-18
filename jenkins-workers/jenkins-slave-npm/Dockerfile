#invoke npm in jenkinsfile: sh "scl enable rh-nodejs6 'npm run build'"
FROM quay.io/openshift/origin-jenkins-agent-base:4.3

ENV NODEJS_VERSION=12 \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    CHROME_BIN=/bin/google-chrome

ADD src/google-chrome.repo /etc/yum.repos.d/

RUN curl --silent --location https://rpm.nodesource.com/setup_${NODEJS_VERSION}.x | bash -

RUN INSTALL_PKGS="nodejs redhat-lsb libXScrnSaver xdg-utils liberation-fonts" && \
    yum install -y --setopt=tsflags=nodocs \
      --enablerepo=google-chrome \
      $INSTALL_PKGS && \
    yum clean all -y && \
    rm -rf /var/cache/yum && \
    npm install --unsafe-perm -g npm-audit-html npm-audit-ci-wrapper sonar-scanner || cat /home/jenkins/.npm/_logs/*-debug.log && \
    chown root:root /home/jenkins -R && \
    chmod 775 /home/jenkins/.config -R && \
    chmod 775 /home/jenkins/.npm -R

USER 1001
