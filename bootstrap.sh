#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

install_ppas () {
    while read ppa; do
        apt-add-repository "$ppa"
    done < repos.txt 
    apt-get update
}

install_pkgs () {
    echo $(cat pkgs.txt) | xargs apt-get install -y
}

install_rust () {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_go () {
    curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
    tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc 
}

install_docker () {
    curl -fsSL https://get.docker.com -o get-docker.sh | sh
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

install_aws () {
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
}

install_python_tools () {
    pip install virtualenvwrapper poetry pylint
    echo 'alias python="python3"' >> ~/.zshrc 
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.zshrc
    echo 'export PROJECT_HOME=$HOME/Code' >> ~/.zshrc
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.zshrc
}

install_hashistack () {
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    apt-get update
    apt-get install -y terraform nomad vault
}

prompt () {
    read -p "Continue (y/n)?" CONT
        if [ "$CONT" = "y" ]; then
            echo "...";
        else
            exit;
        fi
}

install () {
    echo "Installing PPA's repositories";
    install_ppas;
    echo "Complete!"
    prompt;
    echo "Installing Pacakges";
    install_pkgs;
    echo "Complete!"
    prompt;
    echo "Installing Rust";
    install_rust;
    echo "Complete!"
    prompt;
    echo "Installing Go";
    install_go;
    echo "Complete!"
    prompt;
    echo "Installing Python Tools";
    install_python_tools;
    echo "Complete!"
    prompt;
    echo "Installing AWS CLI";
    install_aws;
    echo "Complete!"
    prompt;
    echo "Installing Docker";
    install_docker;
    echo "Complete!"
    prompt;
    echo "Installing Hashi-Stack";
    install_hashistack;
    echo "Complete!"
}

install;