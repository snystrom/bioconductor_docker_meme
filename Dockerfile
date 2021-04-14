FROM bioconductor/bioconductor_docker:devel
ENV MEME_VERSION 5.1.1

# Install meme-suite dependencies
RUN apt-get update && apt-get install -y \
		cpanminus \
    ghostscript \
    libgs-dev \ 
    libgd-dev \
    libtool  \
    libhtml-template-compiled-perl \
    libxml-opml-simplegen-perl  \
    libxml-libxml-debugging-perl && \
# TODO: add back openssh-server if needed
# don't think this is needed
#    openssh-server && \
# Perl dependencies
	cpanm \
    Log::Log4perl \
    Math::CDF \
    CGI \
    HTML::PullParser \
    HTML::Template \
    XML::Simple \
    XML::Parser::Expat \
    XML::LibXML \
    XML::LibXML::Simple \
    XML::Compile \
    XML::Compile::SOAP11 \
    XML::Compile::WSDL11 \
    XML::Compile::Transport::SOAPHTTP && \
# download & install meme
  mkdir -p /opt/meme && \
	mkdir -p /opt/meme && \
  curl -SL http://meme-suite.org/meme-software/${MEME_VERSION}/meme-${MEME_VERSION}.tar.gz > meme-${MEME_VERSION}.tar.gz && \
  tar -zxvf meme-${MEME_VERSION}.tar.gz -C /opt/ && \
	rm meme-${MEME_VERSION}.tar.gz && \
  cd /opt/meme-${MEME_VERSION}/ && \
	./configure --prefix=/opt/meme --enable-build-libxml2 --enable-build-libxslt  --with-url=http://meme-suite.org --with-python=/usr/bin/python3 && \ 
  make && \
  make install && \
  cp /opt/meme-${MEME_VERSION}/scripts/*.py /opt/meme/lib/meme-${MEME_VERSION}/python/ && \
# expose MEME_BIN variable during interactive sessions
  echo "MEME_BIN=/opt/meme/bin/" >> /home/rstudio/.Renviron && \
	mkdir /home/rstudio/.R/ && \
# expose MEME_BIN variable during R CMD CHECK
  echo "MEME_BIN=/opt/meme/bin/" >> /home/rstudio/.R/check.Renviron  && \
# cleanup
	rm -rf /opt/meme-${MEME_VERSION}/

ENV MEME_VERSION=   
ENV PATH="/opt/meme/bin:${PATH}"
ENV MEME_BIN="/opt/meme/bin"
