# JupyterHub / LDAP for Soleil

# build with:
# docker build --no-cache --build-arg http_proxy=http://195.221.0.35:8080 --build-arg https_proxy=http://195.221.0.35:8080 -t soleil/jupyterhub-ldap .
#
# run with:
# docker run -it --name=jupyterhub -p 127.0.0.1:8000:8000 soleil/jupyterhub-ldap
#
# Once running get Docker container ID with
# docker ps
#
# Get a Bask prompt with e.g.
# docker exec -it <ID> /bin/bash
#
# Requirements: files
# nslcd.conf ldap.conf jupyterhub_config.py nsswitch.conf


FROM debian:latest
ENV http_proxy "http://195.221.0.35:8080"
ENV https_proxy "http://195.221.0.35:8080"

# full jupyterhub install
RUN apt update
RUN apt install -y python3-pip python3-dev npm nodejs
RUN apt install -y jupyter jupyter-notebook python-notebook python3-notebook
RUN apt install -y python3-alembic  python3-bleach python3-cffi python3-cryptography python3-dateutil python3-decorator python3-defusedxml python3-editor python3-entrypoints python3-ipykernel python3-ipython python3-jedi python3-jinja2 python3-jupyter-client python3-jupyter-core python-mako python3-markupsafe python3-mistune python3-nbconvert python3-notebook python3-oauthlib python3-openssl python3-parso python3-pexpect python3-pickleshare python3-prometheus-client python3-prompt-toolkit python3-ptyprocess python3-pycparser python3-pygments python3-zmq python3-send2trash python3-setuptools python3-six python3-sqlalchemy python3-terminado python3-testpath python3-tornado python3-traitlets python3-webencodings
RUN npm install -g configurable-http-proxy
RUN pip3 install --upgrade pyzmq
RUN pip3 install --upgrade notebook
RUN pip3 install jupyterhub

RUN more /etc/lsb-release

# configure LDAP Soleil
RUN DEBIAN_FRONTEND=noninteractive apt install -yq ldap-utils libnss-ldapd nslcd
ADD nslcd.conf    /etc/nslcd.conf
ADD ldap.conf     /etc/ldap/ldap.conf
ADD nsswitch.conf /etc/nsswitch.conf
RUN pam-auth-update --enable mkhomedir

RUN chmod 777 /home
VOLUME /home

ADD jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py", "--no-ssl"]
