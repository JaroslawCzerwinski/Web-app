#!/bin/bash
USER="ec2-user"
USER_HOME_DIR="/home/$USER"
RUNNER_DIR="$USER_HOME_DIR/actions-runner"

# Install Docker
sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker $USER

# Install NodeJS
sudo yum install -y nodejs

# Install github self-hosted runner
sudo yum install -y gcc-c++ make libunwind libicu
cat << EOF > $USER_HOME_DIR/ghrunner.sh
#!/bin/bash
mkdir $RUNNER_DIR && cd $RUNNER_DIR
curl -o $RUNNER_DIR/actions-runner-linux-x64-2.319.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.319.1/actions-runner-linux-x64-2.319.1.tar.gz
tar xzf $RUNNER_DIR/actions-runner-linux-x64-2.319.1.tar.gz
EOF

chmod +x $USER_HOME_DIR/ghrunner.sh
sudo -u $USER $USER_HOME_DIR/ghrunner.sh
chown -R $USER:$USER $USER_HOME_DIR/*
sudo -u $USER $RUNNER_DIR/config.sh --url https://github.com/REPO-ADDRESS --token TOKEN --unattended
sudo -u $USER $RUNNER_DIR/run.sh
