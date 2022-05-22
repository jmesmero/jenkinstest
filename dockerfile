FROM jenkins/jenkins:latest


USER root

RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  #pip3 install pywinrm[kerberos] && \
  #apt install krb5-user -y && \ 
  #pip3 install pywinrm && \
  pip3 install ansible

#RUN apt-get update && \
RUN    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce && \ 
   #groupadd -g 999 docker && \
   usermod -aG staff,docker jenkins

# VOLUME /var/jenkins_home
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djava.io.tmpdir=/var/jenkins_home/tmp"


COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#id_rsa.pub file will be saved at /root/.ssh/
RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
RUN chown -R jenkins:jenkins /var/jenkins_home
#VOLUME /var/jenkins_home

USER jenkins