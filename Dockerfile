FROM bioconductor/bioconductor_docker:devel

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
    #XML::Compile::Transport::SOAPHTTP && \
    XML::Compile::Transport::SOAPHTTP
# download & install meme
#  mkdir -p /opt/meme && \
RUN  mkdir -p /opt/meme && \
  curl -SL http://meme-suite.org/meme-software/5.1.1/meme-5.1.1.tar.gz > meme-5.1.1.tar.gz && \
  tar -zxvf meme-5.1.1.tar.gz -C /opt/ && \
	rm meme-5.1.1.tar.gz && \
  cd /opt/meme-5.1.1/ && \
	./configure --prefix=/opt/meme --enable-build-libxml2 --enable-build-libxslt  --with-url=http://meme-suite.org --with-python=/usr/bin/python3 && \ 
  make && \
  make install && \
  cp /opt/meme-5.1.1/scripts/*.py /opt/meme/lib/meme-5.1.1/python/ && \
# expose MEME_BIN variable during interactive sessions
  echo "MEME_BIN=/opt/meme/bin/" >> /home/rstudio.Renviron && \
# expose MEME_BIN variable during R CMD CHECK
  echo "MEME_BIN=/opt/meme/bin/" >> /home/.R/check.Renviron 
   
