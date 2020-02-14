# Create the self signed key and certificate valid for 10years (36500 days)
# for test purposes only
openssl req -nodes -x509 \
        -newkey rsa:4096 \
        -keyout etc/ssl/appster.com.key \
        -out etc/ssl/appster.com.crt \
        -days 3650 \
        -subj "/C=US/ST=Colorado/L=Denver/O=Appster Inc/CN=*.appster.com"


Setup NGINX Plus production server


https://petecoop.co.uk/blog/git-2-3-push-deploy
# On live server

## setup RSA SSH keys
https://gitlab.com/help/ssh/README

### Generate a new SSH key pair:
```bash
# The -C flag adds a comment in the key in case you have multiple of them and want to tell which is which. It is optional.
# Next, you will be prompted to input a file path to save your SSH key pair to.
If you don't already have an SSH key pair and aren't generating a deploy key,
use the suggested path by pressing
Enter. Using the suggested path will normally allow your SSH client
to automatically use the SSH key pair with no additional configuration.
Once the path is decided, you will be prompted to input a password to
secure your new SSH key pair. It's a best practice to use a password,
but it's not required and you can skip creating it by pressing
If, in any case, you want to add or change the password of your SSH key pair,
you can use the -p flag:
ssh-keygen -p -f <keyname>

####  Adding an SSH key to your GitLab account


# ED25519
ssh-keygen -t ed25519 -C "gitlab@email.com"
# Or, RSA:
ssh-keygen -t rsa -b 4096 -C "gitlab@email.com"
```
## Setup bare git repo to push to
mkdir ~/appster-lb
cd ~/appster-lb
git init
git config receive.denyCurrentBranch updateInstead

## Build with Git hooks
vim ~/appster-lb/.git/hooks/update

```bash
#!/bin/bash
# rsync the updates nginx conf files and delete any files in destination not in source
sudo rsync -avrzI --delete ~/appster-lb/etc/nginx/ /etc/nginx
sudo nginx -s reload
```

Then set the correct permissions on it:

```bash
chmod 755 ~/appster-lb/.git/hooks/update
```

# On local build server
git remote add deploy ssh://root@178.128.7.176/root/appster-lb
git push deploy

git push  <REMOTENAME> <BRANCHNAME> 
As an example, you usually run git push origin master to push your local changes to your online repository.

Renaming branches
To rename a branch, you'd use the same git push command, but you would add one more argument: the name of the new branch. For example:
git push  <REMOTENAME> <LOCALBRANCHNAME>:<REMOTEBRANCHNAME> 
This pushes the LOCALBRANCHNAME to your REMOTENAME, but it is renamed to REMOTEBRANCHNAME.

# on the .gitlab-ci.yml



There is no direct way to tell git which private key to use, because it relies on ssh for repository authentication. However, there are still a few ways to achieve your goal:
Option 1: ssh-agent

You can use ssh-agent to temporarily authorize your private key.

For example:

$ ssh-agent sh -c 'ssh-add ~/.ssh/id_rsa; git fetch user@host'

Option 2: GIT_SSH_COMMAND

Pass the ssh arguments by using the GIT_SSH_COMMAND environment variable (Git 2.3.0+).

For example:

$ GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' \
  git clone user@host

You can type this all on one line — ignore $ and leave out the \.
Option 3: GIT_SSH

Pass the ssh arguments by using the GIT_SSH environment variable to specify alternate ssh binary.

For example:

$ echo 'ssh -i ~/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $*' > ssh
$ chmod +x ssh
$ GIT_TRACE=1 GIT_SSH='./ssh' git clone user@host

Note: The above lines are shell (terminal) command lines which you should paste into your terminal. They will create a file named ssh, make it executable, and (indirectly) execute it.

Note: GIT_SSH is available since v0.99.4 (2005).
Option 4: ~/.ssh/config

Use the ~/.ssh/config file as suggested in other answers in order to specify the location of your private key, e.g.

Host github.com
  User git
  Hostname github.com
  IdentityFile ~/.ssh/id_rsa

