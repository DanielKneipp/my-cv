FROM vipintm/xelatex:latest

ADD ./scripts/install-deps.sh .
RUN bash install-deps.sh && rm install-deps.sh

ADD ./requirements.txt .
RUN pip3.10 install -r requirements.txt && rm requirements.txt

RUN printf "<fontconfig>\n\
<!-- Reject WOFF fonts We don't register WOFF(2) fonts with fontconfig because of the W3C spec -->\n\
 <selectfont>\n\
  <rejectfont>\n\
   <glob>/usr/share/fonts/woff/*</glob>\n\
  </rejectfont>\n\
 </selectfont>\n\
</fontconfig>" > /etc/fonts/conf.d/70-no-woff.conf
