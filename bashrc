[[ -s "/etc/bashrc" ]] && . /etc/bashrc
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
rvm_project_rvmrc=1
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

export AWS_ACCESS_KEY_ID="AKIAICWTXXIQPC6GC5YQ"
export AWS_SECRET_ACCESS_KEY="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"

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=$EC2_HOME/pk-blake.pem
export EC2_CERT=$EC2_HOME/cert-blake.pem
export EC2_SSH_PRIVATE_KEY=~/.ssh/quandl_3.pem
export JAVA_HOME="`/usr/libexec/java_home`"
