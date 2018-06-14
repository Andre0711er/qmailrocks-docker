FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

# update debian and install dependencies
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install csh build-essential supervisor logrotate locales ucspi-tcp wget groff-base git-core nginx fcgiwrap libbg1-dev ssl-cert libssl1.0-dev libmariadbclient-dev libmariadbclient-dev-compat \
  procps man makepasswd spamassassin spamc pyzor razor clamav clamav-freshclam clamav-daemon arj unrar-free lhasa unzip bzip2 tar daemontools daemontools-run dovecot-core dovecot-mysql dovecot-imapd

RUN apt-get -y install spf-tools-perl libmailtools-perl libnet-cidr-lite-perl libnet-daemon-perl libtest-distribution-perl libmail-spf-perl libperl-dev libfile-find-rule-perl

#RUN ln -s /etc/service /service

COPY setup /app/setup/
COPY  setup/install /app/setup/install
COPY setup/scripts /app/setup/scripts
COPY setup/ssl /app/ssl

#COPY /config/ /app/setup/config/
RUN chmod +x /app/setup/install/*.sh
RUN /app/setup/install/install.sh
#RUN chmod +x /app/setup/users.sh && /app/setup/users.sh

#COPY assets/init /app/init
#RUN chmod 755 /app/init

#EXPOSE 25
#EXPOSE 80
#EXPOSE 110
#EXPOSE 995
#EXPOSE 143
#EXPOSE 993

#ENTRYPOINT ["/app/init"]
#CMD ["app:start"]
CMD /bin/bash ; sleep infinity
