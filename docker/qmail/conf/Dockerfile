FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

# update debian and install dependencies
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install csh cron build-essential supervisor logrotate locales ucspi-tcp wget groff-base git-core nginx fcgiwrap libbg1-dev ssl-cert libssl1.0-dev libmariadbclient-dev \
  libmariadbclient-dev-compat procps man makepasswd spamassassin spamc pyzor razor clamav clamav-freshclam clamav-daemon arj unrar-free lhasa unzip bzip2 tar daemontools daemontools-run \
  dovecot-core dovecot-mysql dovecot-imapd maildrop rblcheck dnsutils

RUN apt-get -y install spf-tools-perl libmailtools-perl libnet-cidr-lite-perl libnet-daemon-perl libtest-distribution-perl libmail-spf-perl libperl-dev libfile-find-rule-perl libcdb-file-perl

#RUN ln -s /etc/service /service

COPY docker-start.sh /
RUN chmod +x /docker-start.sh
COPY setup /app/setup/
COPY  setup/install /app/setup/install
COPY setup/scripts /app/setup/scripts
COPY setup/ssl /app/ssl

RUN chmod +x /app/setup/install/*.sh
RUN /app/setup/install/install.sh

#EXPOSE 25
#EXPOSE 80
#EXPOSE 110
#EXPOSE 995
#EXPOSE 143
#EXPOSE 993

#ENTRYPOINT ["/app/init"]
#CMD ["app:start"]
#CMD printenv | sed 's/^\(.*\)$/export \1/g' > /app/setup/install/project_env.sh && /bin/bash ; sleep infinity
#CMD /bin/bash ; sleep infinity
ENTRYPOINT /docker-start.sh
