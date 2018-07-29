FROM centos

RUN yum install epel-release -y && \
    yum install perl gcc libacl-devel libblkid-devel gnutls-devel readline-devel python-devel\
    gdb pkgconfig krb5-workstation zlib-devel setroubleshoot-server libaio-devel setroubleshoot-plugins\
    policycoreutils-python libsemanage-python setools-libs-python setools-libs popt-devel libpcap-devel\
    sqlite-devel libidn-devel libxml2-devel libacl-devel libsepol-devel libattr-devel keyutils-libs-devel\
    cyrus-sasl-devel cups-devel bind-utils libxslt docbook-style-xsl openldap-devel pam-devel bzip2 vim wget -y \
    yum clean all && yum -y autoremove

RUN wget https://download.samba.org/pub/samba/stable/samba-4.6.0.tar.gz && \
    tar -zxvf samba-4.6.0.tar.gz && rm -rf samba-4.6.0.tar.gz && cd samba-4.6.0 && \
    ./configure --enable-debug --enable-selftest --with-ads --with-systemd --with-winbind && \
    make && make install && \
    cd .. && rm -rf samba-4.6.0 && \
    yum install openldap-clients && \
    echo "PATH=$PATH:/usr/local/samba/bin"

CMD ["/bin/bash"]

