# Create the self signed key and certificate valid for 10years (36500 days)
# for test purposes only
openssl req -nodes -x509 \
        -newkey rsa:4096 \
        -keyout etc/ssl/appster.com.key \
        -out etc/ssl/appster.com.crt \
        -days 3650 \
        -subj "/C=US/ST=Colorado/L=Denver/O=Appster Inc/CN=*.appster.com"


Setup NGINX Plus production server

install nginx plus
enable Deploy with Git: push to production. source: https://tqdev.com/2018-deploying-with-git-push-to-production


1. Install you passwordless SSH
2. On the server you login using your password. Then you create a `~/.ssh/authorized_keys` file using:

```bash
mkdir ~/.ssh
nano ~/.ssh/authorized_keys
```

In that file you copy the contents of your `.ssh/id_rsa.pub` file (as a single line).


1. Creating a bare repo to push to

On the server you need a repository to push to. This should be a bare repo to avoid conflicts:

```bash
mkdir ~/appster_prod.git
cd ~/appster_prod.git
git --bare init
```

Now you have a bare repository as a target to push to. Lets ensure that the "/etc/nginx" contains a clone of the bare repo using:

```bash
cd /etc/nginx
git clone ~/mkdir ~/appster_prod.git .
```

Adding a "post_receive" hook to automate

1. In the hooks directory of the bare repo you can create a script with execution rights that pulls the contents from the bare repo to the production site. The file should contain:

```bash
# vim ~/appster_prod.git/hooks/post-receive
#!/bin/bash
unset GIT_DIR
cd /etc/nginx/
git pull
nginx -s reload
```

2. It should be file executable, so that it can be run after receiving a commit:

chmod 755 ~/myproject.git/hooks/post-receive

Testing the deployment

Put pipeline file uses GitLab CI/CD environment variables to replace "$PROD_HOST" with the server address and "$PROD_USER" with your username on that server. We also specify a private key file that is also stored as a environment variable as
"$PRIVATE_KEY_FILE":

The last step in our pipline file, [`.gitlab-ci.yml`](.gitlab-ci.yml) does the following deployment step:

GIT_SSH_COMMAND='ssh -i $PRIVATE_KEY_FILE' git remote add master $PROD_USER@$PROD_HOST:appster_prod.git

4.  Check the webpage over port 80