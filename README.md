# Vagrant - using China source to install plugin
```sh
vagrant plugin install --plugin-clean-sources --plugin-source https://gems.ruby-china.com/ vagrant-disksize
```

# Vagrant use China source to install virtual box
```sh
vagrant init ubuntu-bionic https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/bionic/current/bionic-server-cloudimg-amd64-vagrant.box
```

# Vagrant use official source
```sh
vagrant box add bento/ubuntu-18.04
```

# Install ChefDK within Vagrant box
- Sloution A(Using a install.sh)
```sh
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
```

- Sloution B(Install step by step)
```sh
wget https://packages.chef.io/files/stable/chefdk/4.10.0/ubuntu/18.04/chefdk_4.10.0-1_amd64.deb

sudo dpkg -i chefdk_4.10.0-1_amd64.deb
```

# Create a cookbook
```sh
chef generate cookbook cookbook/apache apache
```

# Chef upload cookbook
```sh
knife cookbook upload apache
```

# Chef server node bootstrap
```sh
knife bootstrap 18.183.113.48 -i ~/Desktop/SIT/aws/aws-free-kit.pem -x ubuntu --sudo -N iwish_app_1 -r "recipe[apache]"
knife bootstrap 18.183.95.7 -i ~/Desktop/SIT/aws/aws-free-kit.pem -x ubuntu --sudo -N iwish_app_2 -r "recipe[apache]"

knife bootstrap 18.183.113.48 -i ~/Desktop/SIT/aws/aws-free-kit.pem -x ubuntu --sudo -N app_1 -r "recipe[apache]"
knife bootstrap 18.183.95.7 -i ~/Desktop/SIT/aws/aws-free-kit.pem -x ubuntu --sudo -N app_2 -r "recipe[apache]"
```

# Set up chef server
```sh
# create admin
sudo chef-server-ctl user-create dlwang Danny Wang dlwang@merkleinc.com 'P@ssMKL7' --filename ~/.ssh/chef_server_admin.pem
sudo chef-server-ctl user-create bxue Jacob xue bxue@merkleinc.com 'P@ssMKL7' --filename ~/.ssh/bxue_chef_server_admin.pem
sudo chef-server-ctl user-create jercai Jerry Cai jercai@merkleinc.com 'P@ssMKL7' --filename ~/.ssh/jercai_server_admin.pem

# create orgnazition
sudo chef-server-ctl org-create lsg 'Merkle China LSG' --association_user dlwang --filename ~/.ssh/org-validator.pem

# install chef manager
sudo chef-server-ctl install chef-manage

# reconfigure
sudo chef-server-ctl reconfigure
sudo chef-manage-ctl reconfigure --accept-license

# Add user to orgnazition
sudo chef-server-ctl org-user-add lsg bxue --admin
```

### Issues
- Chef server port already used
  > mannualy update /var/opscode/opt/nginx/etc/nginx.conf
- Chef manager server url incorrect
  > update server hostname