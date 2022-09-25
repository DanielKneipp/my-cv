
#!/usr/bin/env bash

set -e

install_python_pyenv() {
    apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

    curl https://pyenv.run | bash

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc

    pyenv install 3.10.5
    pyenv global 3.10.5
}

install_openssl_directly() {
    # --no-check-certificate because the image vipintm/xelatex (debian) has problems
    # trusting in the certificate from openssl. Already tried and didn't work:
    # apt install ca-certificate && update-ca-certificates --fresh
    wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1.tar.gz
    tar xzf openssl-1.1.1.tar.gz

    pushd openssl-1.1.1

    ./config \
         --prefix=/usr/local/custom-openssl \
         --libdir=lib \
         --openssldir=/etc/ssl
    make -j 1 depend
    make -j 8
    make install_sw

    popd
}

install_python_directly() {
    apt install -y wget build-essential libncursesw5-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

    # Installing from source because the libs from the packages libssl-dev
    # or libssl1.0-dev could not be found 
    install_openssl_directly

    wget https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz
    tar xzf Python-3.10.5.tgz
    
    pushd Python-3.10.5

    ./configure -C \
        --with-openssl=/usr/local/custom-openssl \
        --with-openssl-rpath=auto
    make -j 8
    make altinstall

    echo 'alias python="python3.10"'  >> ~/.bashrc
    echo 'alias pip="pip3.10"'  >> ~/.bashrc

    popd
}

apt update

install_python_directly
